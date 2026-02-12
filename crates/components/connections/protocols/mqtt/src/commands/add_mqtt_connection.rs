use crate::{MqttAddress};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use url::Url;
use mizer_connection_contracts::{ConnectionId, ConnectionStorage};
use crate::connections::MqttConnection;

#[derive(Debug, Deserialize, Serialize)]
pub struct AddMqttConnectionCommand {
    pub url: String,
    pub username: Option<String>,
    pub password: Option<String>,
}

impl<'a> Command<'a> for AddMqttConnectionCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = ConnectionId;
    type Result = ConnectionId;

    fn label(&self) -> String {
        format!("Add MQTT Connection '{}'", self.url)
    }

    fn apply(
        &self,
        connection_storage: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let url = Url::parse(&self.url)?;
        let address = MqttAddress {
            url,
            username: self.username.clone(),
            password: self.password.clone(),
        };
        let id = connection_storage.acquire_new_connection::<MqttConnection>(address, None)?;

        Ok((id, id))
    }

    fn revert(
        &self,
        connection_storage: &mut ConnectionStorage,
        id: Self::State,
    ) -> anyhow::Result<()> {
        connection_storage.delete_connection(&id);

        Ok(())
    }
}
