use crate::{ConnectionId, ConnectionStorage, IConnection};
use std::collections::HashMap;
use std::sync::mpsc;

#[derive(Copy, Clone, Debug, PartialEq, Eq, Hash)]
pub struct StorageCommandId(uuid::Uuid);

impl StorageCommandId {
    fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

pub enum StorageCommand<T: IConnection> {
    AddConnection {
        id: StorageCommandId,
        config: T::Config,
        name: Option<String>,
    },
    UpdateConnection { id: StorageCommandId, update: Box<dyn FnOnce(&mut T) + Send + Sync> },
    DropConnection(StorageCommandId),
}

#[derive(Clone)]
pub struct RemoteConnectionStorageHandle<T: IConnection> {
    sender: mpsc::Sender<StorageCommand<T>>,
}

impl<T: IConnection> RemoteConnectionStorageHandle<T>
where
    T::Config: Send + Sync,
{
    pub(crate) fn create() -> (Self, RemoteConnectionStorageReceiver<T>) {
        let (sender, receiver) = mpsc::channel();
        let handle = Self { sender };

        (handle, RemoteConnectionStorageReceiver::new(receiver))
    }

    pub fn add_connection(&self, config: T::Config, name: Option<String>) -> anyhow::Result<StorageCommandId> {
        let id = StorageCommandId::new();
        self.sender
            .send(StorageCommand::AddConnection { id, config, name })?;

        Ok(id)
    }

    pub fn update_connection(&self, id: StorageCommandId, update: impl FnOnce(&mut T) + Send + Sync + 'static) -> anyhow::Result<()> {
        self.sender.send(StorageCommand::UpdateConnection { id, update: Box::new(update) })?;

        Ok(())
    }

    pub fn drop_connection(&self, id: StorageCommandId) -> anyhow::Result<()> {
        self.sender.send(StorageCommand::DropConnection(id))?;

        Ok(())
    }
}

pub(crate) struct DynRemoteConnectionStorageHandle(Box<dyn IRemoteConnectionStorageReceiver>);

pub(crate) struct RemoteConnectionStorageReceiver<T: IConnection> {
    receiver: mpsc::Receiver<StorageCommand<T>>,
    ids: HashMap<StorageCommandId, ConnectionId>,
}

impl<T: IConnection> RemoteConnectionStorageReceiver<T> {
    fn new(receiver: mpsc::Receiver<StorageCommand<T>>) -> Self {
        Self { receiver, ids: HashMap::new() }
    }
}

pub(crate) trait IRemoteConnectionStorageReceiver: Send {
    fn handle_command(&mut self, storage: &mut ConnectionStorage) -> anyhow::Result<()>;
}

impl<T: IConnection> IRemoteConnectionStorageReceiver for RemoteConnectionStorageReceiver<T> where T::Config: Send + Sync {
    fn handle_command(&mut self, storage: &mut ConnectionStorage) -> anyhow::Result<()> {
        if let Ok(command) = self.receiver.try_recv() {
            match command {
                StorageCommand::AddConnection { id, config, name } => {
                    let connection_id = storage.acquire_new_connection::<T>(config, name)?;
                    self.ids.insert(id, connection_id);
                }
                StorageCommand::UpdateConnection { id, update } => {
                    let connection_id = self
                        .ids
                        .get(&id)
                        .ok_or_else(|| anyhow::anyhow!("Connection not found"))?;
                    if let Some(connection) = storage.get_connection_mut::<T>(connection_id) {
                        update(connection);
                    }
                }
                StorageCommand::DropConnection(id) => {
                    let connection_id = self
                        .ids
                        .remove(&id)
                        .ok_or_else(|| anyhow::anyhow!("Connection not found"))?;
                    storage.delete_connection(&connection_id);
                }
            }
        }

        Ok(())
    }
}
