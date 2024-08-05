use mizer_module::*;

use crate::background_discovery::MidiBackgroundDiscovery;
use crate::connections::MidiConnectionManager;
use crate::MidiDeviceProvider;

pub struct MidiModule;

module_name!(MidiModule);

impl Module for MidiModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let provider = MidiDeviceProvider::new();
        let background_discovery = MidiBackgroundDiscovery::new(&provider);
        let mut connection_manager = MidiConnectionManager::new(provider);
        background_discovery.start()?;
        let device_profile_path = &context.settings().paths.midi_device_profiles;
        tracing::info!(
            "Loading MIDI device profiles from {}",
            device_profile_path
                .iter()
                .map(|p| p.display().to_string())
                .collect::<Vec<_>>()
                .join(", ")
        );
        if let Err(err) = connection_manager.load_device_profiles(device_profile_path) {
            tracing::error!("Failed to load MIDI device profiles: {}", err);
        }
        context.provide_api(connection_manager.provider.profile_registry.clone());
        context.provide(connection_manager);

        Ok(())
    }
}
