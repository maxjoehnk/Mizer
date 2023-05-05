use crate::{MqttAddress, MqttConnectionManager};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use url::Url;

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct ConfigureMqttConnectionCommand {
    pub connection_id: String,
    pub url: String,
    pub username: Option<String>,
    pub password: Option<String>,
}

impl<'a> Command<'a> for ConfigureMqttConnectionCommand {
    type Dependencies = RefMut<MqttConnectionManager>;
    type State = MqttAddress;
    type Result = ();

    fn label(&self) -> String {
        format!("Configure MQTT Connection '{}'", self.connection_id)
    }

    fn apply(
        &self,
        mqtt_manager: &mut MqttConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let url = Url::parse(&self.url)?;
        let address = MqttAddress {
            url,
            username: self.username.clone(),
            password: self.password.clone(),
        };
        let previous_address = mqtt_manager.reconfigure_connection(&self.connection_id, address)?;

        Ok(((), previous_address))
    }

    fn revert(
        &self,
        mqtt_manager: &mut MqttConnectionManager,
        previous_address: Self::State,
    ) -> anyhow::Result<()> {
        mqtt_manager.reconfigure_connection(&self.connection_id, previous_address)?;

        Ok(())
    }
}
