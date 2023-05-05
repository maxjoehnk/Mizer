use crate::{MqttAddress, MqttConnectionManager};
use mizer_commander::{Command, RefMut};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct DeleteMqttConnectionCommand {
    pub id: String,
}

impl<'a> Command<'a> for DeleteMqttConnectionCommand {
    type Dependencies = RefMut<MqttConnectionManager>;
    type State = MqttAddress;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete MQTT Connection '{}'", self.id)
    }

    fn apply(
        &self,
        mqtt_manager: &mut MqttConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let address = mqtt_manager
            .delete_connection(&self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown mqtt connection"))?;

        Ok(((), address))
    }

    fn revert(
        &self,
        mqtt_manager: &mut MqttConnectionManager,
        address: Self::State,
    ) -> anyhow::Result<()> {
        mqtt_manager.add_connection(self.id.clone(), address)?;

        Ok(())
    }
}
