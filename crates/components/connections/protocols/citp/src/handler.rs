use std::collections::HashSet;

use anyhow::Context;
use citp::protocol::pinf::PLoc;
use mizer_connection_contracts::RemoteConnectionStorageHandle;
use mizer_fixtures::manager::FixtureManager;
use mizer_status_bus::StatusHandle;

use crate::connection::{CitpConnection, CitpConnectionHandle, CitpConnectionName};

pub struct CitpConnectionHandler {
    connections: HashSet<CitpConnectionName>,
    receiver: flume::Receiver<PLoc>,
    sender: RemoteConnectionStorageHandle<CitpConnectionHandle>,
    fixture_manager: Option<FixtureManager>,
    status_handle: StatusHandle,
}

impl CitpConnectionHandler {
    pub fn new(
        receiver: flume::Receiver<PLoc>,
        handle_sender: RemoteConnectionStorageHandle<CitpConnectionHandle>,
        fixture_manager: Option<FixtureManager>,
        status_handle: StatusHandle,
    ) -> anyhow::Result<Self> {
        Ok(Self {
            connections: Default::default(),
            receiver,
            sender: handle_sender,
            fixture_manager,
            status_handle,
        })
    }

    pub async fn run(&mut self) -> anyhow::Result<()> {
        loop {
            let msg = self.receiver.recv_async().await?;
            let peer_name = msg.name.to_str()?.to_string();
            if let Err(err) = self.add_connection(msg).await {
                tracing::error!("Unable to create new connection for peer {peer_name}: {err:?}")
            }
        }
    }

    pub(crate) async fn add_connection(&mut self, ploc: PLoc) -> anyhow::Result<()> {
        let peer_name = ploc.name.to_str()?.to_string();
        let connection_name = peer_name.clone();
        let peer_name = CitpConnectionName(peer_name);
        if self.connections.contains(&peer_name) {
            tracing::trace!("Connection for peer {peer_name} already exists");
            return Ok(());
        }
        let connection = CitpConnection::new(ploc)
            .await
            .context("Creating new connection")?;
        self.connections.insert(peer_name.clone());
        let handle = connection.handle();
        let fixture_manager = self.fixture_manager.clone();
        let status_handle = self.status_handle.clone();
        tokio::spawn(async move {
            if let Err(err) = connection
                .connection_loop(status_handle, fixture_manager)
                .await
            {
                tracing::error!("Error in connection loop: {:?}", err);
            }
        });
        self.sender.add_connection(handle, Some(connection_name))?;

        Ok(())
    }
}
