use crate::connections::OscClientCommand;
use flume::Sender;
use rosc::OscMessage;

pub struct OscOutput<'a> {
    command_publisher: &'a Sender<OscClientCommand>,
}

impl<'a> OscOutput<'a> {
    pub(crate) fn new(command_publisher: &'a Sender<OscClientCommand>) -> Self {
        Self { command_publisher }
    }

    pub fn write(&self, msg: OscMessage) -> anyhow::Result<()> {
        log::trace!("Writing osc message {msg:?}");
        let command = OscClientCommand::Publish(msg);
        self.command_publisher.send(command)?;

        Ok(())
    }
}
