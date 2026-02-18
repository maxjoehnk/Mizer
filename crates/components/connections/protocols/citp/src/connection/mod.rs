use std::ffi::CString;
use std::fmt;
use std::str::FromStr;

use anyhow::Context;
use citp::protocol::caex::{EnterShow, LeaveShow};
use citp::protocol::*;
use tokio::io::{AsyncBufReadExt, AsyncWriteExt, BufReader};
use tokio::net::tcp::{OwnedReadHalf, OwnedWriteHalf};
use tokio::net::TcpStream;
use mizer_connection_contracts::{IConnection, TransmissionStateSender};
use mizer_fixtures::manager::FixtureManager;
use mizer_status_bus::{ProjectStatus, StatusHandle};

use crate::protocol::*;

mod handlers;

#[derive(Debug, Default, Clone, Copy, Hash, PartialEq, Eq)]
pub struct CitpConnectionId(uuid::Uuid);

impl fmt::Display for CitpConnectionId {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.0.to_string())
    }
}

#[derive(Debug, Default, Clone, PartialEq, Eq, Hash)]
pub struct CitpConnectionName(pub(crate) String);

impl fmt::Display for CitpConnectionName {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(&self.0)
    }
}

#[derive(Debug, Clone, Copy)]
pub enum CitpKind {
    LightingConsole,
    MediaServer,
    Visualizer,
    Unknown,
}

impl From<String> for CitpKind {
    fn from(value: String) -> Self {
        match value.as_str() {
            "LightingConsole" => Self::LightingConsole,
            "MediaServer" => Self::MediaServer,
            "Visualizer" => Self::Visualizer,
            val => {
                tracing::warn!("Unknown CITP kind: {val}");

                Self::Unknown
            }
        }
    }
}

#[derive(Debug, Clone)]
pub struct CitpConnectionHandle {
    pub id: CitpConnectionId,
    pub name: CitpConnectionName,
    pub kind: CitpKind,
    pub state: String,
}

impl IConnection for CitpConnectionHandle {
    type Config = Self;
    const TYPE: &'static str = "citp";

    fn create(config: Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self> {
        Ok(config)
    }
}

impl CitpConnectionId {
    pub fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

#[derive(Debug)]
pub struct CitpConnection {
    pub id: CitpConnectionId,
    pub name: CitpConnectionName,
    pub kind: CitpKind,
    pub state: String,
    reader: BufReader<OwnedReadHalf>,
    writer: OwnedWriteHalf,
}

impl CitpConnection {
    pub async fn new(ploc: pinf::PLoc) -> anyhow::Result<Self> {
        tracing::debug!("Trying to connect to {ploc:?}");
        let name = ploc.name.to_str()?.to_string();
        let kind = ploc.kind.to_str()?.to_string();
        let kind = CitpKind::from(kind);
        let state = ploc.state.to_str()?.to_string();
        let address = format!("{}:{}", extract_ip_address(&name), ploc.listening_tcp_port);
        let stream = TcpStream::connect(address).await?;
        let (reader, writer) = stream.into_split();
        let reader = BufReader::new(reader);
        let id = CitpConnectionId::new();

        tracing::info!("Connected to {name} ({kind:?})");

        let mut connection = Self {
            id,
            name: CitpConnectionName(name),
            kind,
            state,
            reader,
            writer,
        };

        connection.send_connect_to_capture().await?;

        Ok(connection)
    }

    pub fn handle(&self) -> CitpConnectionHandle {
        CitpConnectionHandle {
            name: self.name.clone(),
            state: self.state.clone(),
            kind: self.kind,
            id: self.id,
        }
    }

    pub async fn connection_loop(
        mut self,
        status_handle: StatusHandle,
        fixture_manager: Option<FixtureManager>,
    ) -> anyhow::Result<()> {
        let handlers = handlers::get_handlers(fixture_manager);
        let project_subscriber = status_handle.subscribe_current_project();
        for handler in &handlers {
            if let Some(announcement) = handler.announce()? {
                self.writer.write_all(&announcement).await?;
            }
        }
        self.writer.flush().await?;

        let (writer_tx, writer_rx) = flume::bounded::<Vec<u8>>(1);

        let writer_handle = tokio::task::spawn(async move {
            while let Ok(msg) = writer_rx.recv_async().await {
                if let Err(err) = self.writer.write_all(&msg).await {
                    tracing::error!("Error writing to CITP connection: {err:?}");
                }
                if let Err(err) = self.writer.flush().await {
                    tracing::error!("Error flushing CITP connection: {err:?}");
                }
            }
        });

        let project_writer = writer_tx.clone();
        let project_handle: tokio::task::JoinHandle<anyhow::Result<()>> =
            tokio::task::spawn(async move {
                async fn send_msg(
                    writer: &flume::Sender<Vec<u8>>,
                    msg: impl WriteToBytes,
                ) -> anyhow::Result<()> {
                    let mut buffer = Vec::new();
                    msg.write_to_bytes(&mut buffer)?;
                    writer
                        .send_async(buffer)
                        .await
                        .context("Transmitting citp message to writer")?;

                    Ok(())
                }

                while let Ok(status) = project_subscriber.read_async().await {
                    match status {
                        ProjectStatus::None => {
                            let msg = LeaveShow {};
                            let msg = build_caex_msg(msg, &LeaveShow::CONTENT_TYPE.to_le_bytes());
                            send_msg(&project_writer, msg).await?;
                        }
                        ProjectStatus::New => {
                            let msg = EnterShow {
                                name: Ucs2::from_str("(New)").map_err(|err| {
                                    anyhow::anyhow!("Unable to construct Ucs2 {err:?}")
                                })?,
                            };
                            let msg = build_caex_msg(msg, &EnterShow::CONTENT_TYPE.to_le_bytes());
                            send_msg(&project_writer, msg).await?;
                        }
                        ProjectStatus::Loaded(name) => {
                            let msg = EnterShow {
                                name: Ucs2::from_str(&name).map_err(|err| {
                                    anyhow::anyhow!("Unable to construct Ucs2 {err:?}")
                                })?,
                            };
                            let msg = build_caex_msg(msg, &EnterShow::CONTENT_TYPE.to_le_bytes());
                            send_msg(&project_writer, msg).await?;
                        }
                    }
                }

                Ok(())
            });

        let packet_writer = writer_tx;
        let packet_handle: tokio::task::JoinHandle<anyhow::Result<()>> =
            tokio::task::spawn(async move {
                loop {
                    let mut data = self.reader.fill_buf().await?.to_vec();

                    let mut total_bytes_processed = 0;

                    while !data.is_empty() {
                        tracing::debug!("Processing {} bytes", data.len());
                        let header = Header::read_from_bytes(&data[..])?;
                        let header_size = header.size_bytes();
                        let read_offset = header_size + CONTENT_TYPE_LEN;

                        let content_type = header.content_type.to_le_bytes();
                        let message_content_type =
                            layer_two_content_type(&data, header_size).to_le_bytes();

                        let handler = handlers.iter().find(|handler| {
                            handler.can_handle(&content_type, &message_content_type)
                        });

                        if let Some(handler) = handler {
                            tracing::debug!(
                                "Handling message with {handler_name}",
                                handler_name = handler
                            );
                            let response = handler.handle(&data[read_offset..])?;
                            packet_writer.send_async(response).await?;
                        } else {
                            tracing::debug!(
                                "No handler found for {content_type:?} {message_content_type:?}"
                            );
                        }

                        total_bytes_processed += header.message_size as usize;
                        data = data.drain(header.message_size as usize..).collect();
                    }

                    self.reader.consume(total_bytes_processed);
                }
            });

        let (_, project, packet) =
            futures::future::try_join3(writer_handle, project_handle, packet_handle).await?;

        project?;
        packet?;

        Ok(())
    }

    async fn send_connect_to_capture(&mut self) -> anyhow::Result<()> {
        let pnam = pinf::PNam {
            name: CString::new("Mizer")?,
        };
        let msg = build_pinf_msg(pnam, pinf::PNam::CONTENT_TYPE);
        self.send_msg(msg).await?;

        Ok(())
    }

    async fn send_msg(&mut self, msg: impl WriteToBytes) -> anyhow::Result<()> {
        let mut buffer = Vec::new();
        msg.write_to_bytes(&mut buffer)?;
        self.writer.write_all(&buffer).await?;
        self.writer.flush().await?;
        Ok(())
    }
}

fn extract_ip_address(s: &str) -> String {
    let start_bytes = s.find('(').unwrap_or(0) + 1;
    let end_bytes = s.find(')').unwrap_or(s.len());
    s[start_bytes..end_bytes].to_string()
}
