use crate::MidiConnectionManager;
use mizer_commander::{Command, Ref};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct ChangeMidiDeviceProfileCommand {
    pub device: String,
    pub profile_id: Option<String>,
}

impl<'a> Command<'a> for ChangeMidiDeviceProfileCommand {
    type Dependencies = Ref<MidiConnectionManager>;
    type State = Option<String>;
    type Result = ();

    fn label(&self) -> String {
        if let Some(profile_id) = self.profile_id.as_ref() {
            format!(
                "Change MIDI device profile for device {} to {}",
                self.device, profile_id
            )
        } else {
            format!("Change MIDI device profile for device {}", self.device)
        }
    }

    fn apply(
        &self,
        midi_connection_manager: &MidiConnectionManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        midi_connection_manager.change_device_profile(&self.device, self.profile_id.as_deref())?;

        Ok(((), None))
    }

    fn revert(
        &self,
        midi_connection_manager: &MidiConnectionManager,
        state: Self::State,
    ) -> anyhow::Result<()> {
        midi_connection_manager.change_device_profile(&self.device, state.as_deref())?;

        Ok(())
    }
}
