use mizer_module::*;

use crate::connections::MidiConnectionManager;
use crate::processor::MidiProcessor;

pub struct MidiModule;

module_name!(MidiModule);

impl Module for MidiModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let mut connection_manager = MidiConnectionManager::new();
        let device_profile_path = &context.settings().paths.midi_device_profiles;
        tracing::info!(
            "Loading MIDI device profiles from {}",
            device_profile_path.display()
        );
        if let Err(err) = connection_manager.load_device_profiles(device_profile_path) {
            tracing::error!("Failed to load MIDI device profiles: {}", err);
        }
        context.provide(connection_manager);
        context.add_processor(MidiProcessor);

        Ok(())
    }
}
