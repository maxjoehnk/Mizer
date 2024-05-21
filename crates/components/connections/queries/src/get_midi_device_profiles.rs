use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use mizer_protocol_midi::{DeviceProfile, MidiDeviceProfileRegistry};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListMidiDeviceProfilesQuery;

impl<'a> Query<'a> for ListMidiDeviceProfilesQuery {
    type Dependencies = Ref<MidiDeviceProfileRegistry>;
    type Result = Vec<DeviceProfile>;

    fn query(&self, profile_registry: &MidiDeviceProfileRegistry) -> anyhow::Result<Self::Result> {
        Ok(profile_registry.list_device_profiles())
    }
    
    fn requires_main_loop(&self) -> bool {
        false
    }
}