use crate::{MqttAddress, MqttConnectionManager};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};
use url::Url;

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct AddMqttConnectionCommand {
    pub url: String,
    pub username: Option<String>,
    pub password: Option<String>,
}

impl<'a> Command<'a> for AddMqttConnectionCommand {
    type Dependencies = RefMut<MqttConnectionManager>;
    type State = String;
    type Result = String;

    fn label(&self) -> String {
        format!("Add MQTT Connection '{}'", self.url)
    }

    fn apply(
        &self,
        mqtt_manager: &mut MqttConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let id = mqtt_manager.list_connections().len();
        let id = format!("mqtt-{}", id);
        let url = Url::parse(&self.url)?;
        let address = MqttAddress {
            url,
            username: self.username.clone(),
            password: self.password.clone(),
        };
        mqtt_manager.add_connection(id.clone(), address)?;

        Ok((id.clone(), id))
    }

    fn revert(
        &self,
        mqtt_manager: &mut MqttConnectionManager,
        id: Self::State,
    ) -> anyhow::Result<()> {
        mqtt_manager.delete_connection(&id);

        Ok(())
    }
}
