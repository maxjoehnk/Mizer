use std::ffi::CString;
use std::net::{Ipv4Addr, SocketAddr, SocketAddrV4};
use std::time::Duration;

use anyhow::Context;
use citp::protocol::pinf::{MULTICAST_PORT, OLD_MULTICAST_ADDR as MULTICAST_ADDR};
use citp::protocol::{pinf, ReadFromBytes, SizeBytes, WriteToBytes};
use tokio::net::UdpSocket;

use crate::protocol::{build_pinf_msg, layer_two_content_type, CONTENT_TYPE_LEN};

const MULTICAST_DESTINATION: SocketAddrV4 = SocketAddrV4::new(
    Ipv4Addr::new(
        MULTICAST_ADDR[0],
        MULTICAST_ADDR[1],
        MULTICAST_ADDR[2],
        MULTICAST_ADDR[3],
    ),
    MULTICAST_PORT,
);

pub struct CitpDiscovery {
    socket: UdpSocket,
    sender: flume::Sender<pinf::PLoc>,
}

impl CitpDiscovery {
    pub async fn new(sender: flume::Sender<pinf::PLoc>) -> anyhow::Result<Self> {
        let socket = UdpSocket::bind(MULTICAST_DESTINATION).await?;
        socket.join_multicast_v4(*MULTICAST_DESTINATION.ip(), Ipv4Addr::UNSPECIFIED)?;

        Ok(Self { socket, sender })
    }

    pub async fn discover(&self) -> anyhow::Result<()> {
        tracing::debug!("Starting discovery");
        let mut buf = [0u8; 65535];
        loop {
            self.receive_packet(&mut buf).await?;
            if let Err(err) = self.send_peer_location().await {
                tracing::error!("Error sending peer location: {err:?}");
            }
            tokio::time::sleep(Duration::from_secs(1)).await;
        }
    }

    async fn receive_packet(&self, buf: &mut [u8]) -> anyhow::Result<()> {
        let (len, host) = self.socket.recv_from(buf).await?;
        let data = &buf[..len];

        if let Err(err) = self.handle_packet(data, host).await {
            tracing::error!("Error handling packet: {:?}", err);
        }
        Ok(())
    }

    async fn send_peer_location(&self) -> anyhow::Result<()> {
        let ploc = peer_location()?;
        self.send_msg(ploc).await?;

        Ok(())
    }

    async fn send_msg(&self, msg: impl WriteToBytes) -> anyhow::Result<()> {
        let mut buffer = Vec::new();
        msg.write_to_bytes(&mut buffer)?;
        self.socket.send_to(&buffer, MULTICAST_DESTINATION).await?;

        Ok(())
    }

    async fn handle_packet(&self, data: &[u8], host: SocketAddr) -> anyhow::Result<()> {
        let header = citp::protocol::Header::read_from_bytes(data)?;
        let header_size = header.size_bytes();

        if &header.content_type.to_le_bytes() == pinf::Header::CONTENT_TYPE {
            if let pinf::PLoc::CONTENT_TYPE =
                &layer_two_content_type(data, header_size).to_le_bytes()
            {
                let ploc = pinf::PLoc::read_from_bytes(&data[header_size + CONTENT_TYPE_LEN..])?;
                let name = ploc.name.to_str()?.to_owned();
                if name == "Mizer" {
                    return Ok(());
                }
                tracing::debug!("Received PLoc from {name} at {host}");

                self.sender.send_async(ploc).await.context("Sending PLoc")?;
            }
        }

        Ok(())
    }
}

fn peer_location() -> anyhow::Result<pinf::Message<pinf::PLoc>> {
    let ploc = pinf::PLoc {
        listening_tcp_port: 0,
        kind: CString::new("LightingConsole")?,
        name: CString::new("Mizer")?,
        state: CString::new("Running")?,
    };
    Ok(build_pinf_msg(ploc, pinf::PLoc::CONTENT_TYPE))
}
