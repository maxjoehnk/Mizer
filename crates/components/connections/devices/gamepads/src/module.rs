use gilrs::Gilrs;
use mizer_connection_contracts::ConnectionStorageView;
use mizer_module::*;
use crate::GamepadRef;

pub struct GamepadModule;

module_name!(GamepadModule);

impl Module for GamepadModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let connection_storage_view = context.try_get::<ConnectionStorageView>().unwrap();
        let handle = connection_storage_view.remote_access::<GamepadRef>();

        std::thread::Builder::new()
            .name("Gamepad Discovery".to_string())
            .spawn(move || {
                let service = crate::discovery::GamepadDiscoveryService {
                    gilrs: Gilrs::new()
                        .map_err(|err| anyhow::anyhow!("Can't create Gamepad context {:?}", err))
                        .unwrap(),
                    connection_sender: handle,
                    gamepad_states: Default::default(),
                };
                service.run();
            })?;

        Ok(())
    }
}
