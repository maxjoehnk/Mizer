use crate::{MqttAddress};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use url::Url;
use mizer_connection_contracts::{ConnectionStorage, StableConnectionId};
use crate::connections::MqttConnection;

#[derive(Debug, Deserialize, Serialize)]
pub struct ConfigureMqttConnectionCommand {
    pub connection_id: StableConnectionId,
    pub url: String,
    pub username: Option<String>,
    pub password: Option<String>,
}

impl<'a> Command<'a> for ConfigureMqttConnectionCommand {
    type Dependencies = RefMut<ConnectionStorage>;
    type State = MqttAddress;
    type Result = ();

    fn label(&self) -> String {
        format!("Configure MQTT Connection '{}'", self.connection_id)
    }

    fn apply(
        &self,
        mqtt_manager: &mut ConnectionStorage,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let url = Url::parse(&self.url)?;
        let address = MqttAddress {
            url,
            username: self.username.clone(),
            password: self.password.clone(),
        };
        let connection = mqtt_manager.get_connection_by_stable_mut::<MqttConnection>(&self.connection_id)
            .ok_or_else(|| anyhow::anyhow!("Connection not found"))?;
        let previous_address = connection.reconfigure(address)?;

        Ok(((), previous_address))
    }

    fn revert(
        &self,
        mqtt_manager: &mut ConnectionStorage,
        previous_address: Self::State,
    ) -> anyhow::Result<()> {
        let connection = mqtt_manager.get_connection_by_stable_mut::<MqttConnection>(&self.connection_id)
            .ok_or_else(|| anyhow::anyhow!("Connection not found"))?;
        connection.reconfigure(previous_address)?;

        Ok(())
    }
}
