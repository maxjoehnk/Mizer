use crate::connections::MqttClientCommand;
use flume::Sender;
use mizer_util::StructuredData;
use mqtt_async_client::client::Publish;

pub struct MqttOutput<'a> {
    command_publisher: &'a Sender<MqttClientCommand>,
}

impl<'a> MqttOutput<'a> {
    pub(crate) fn new(command_publisher: &'a Sender<MqttClientCommand>) -> Self {
        Self { command_publisher }
    }

    pub fn write(&self, path: String, data: StructuredData, retain: bool) -> anyhow::Result<()> {
        log::trace!(
            "Sending publish command to {} with payload {:?}",
            path,
            data
        );
        let payload = serde_json::to_vec(&data)?;
        let mut publish = Publish::new(path, payload);
        publish.set_retain(retain);
        let command = MqttClientCommand::Publish(publish);
        self.command_publisher.send(command)?;

        Ok(())
    }
}
