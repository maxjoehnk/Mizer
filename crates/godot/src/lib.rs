use godot::classes::Engine;
use godot::obj::Singleton;
use godot::prelude::{Gd, GodotClass, UserSingleton};
use libgodot::GodotOptions;
use mizer::Api;
use mizer_api::handlers::Handlers;

mod controls;

pub fn run(handlers: Handlers<Api>) -> anyhow::Result<()> {
    let mut runtime = libgodot::GodotRuntimeHandle::new(
        &GodotOptions::new("crates/godot").with_rendering_driver("vulkan"),
    )
    .map_err(|_| anyhow::anyhow!("Failed to create Godot runtime"))?;

    let interface = MizerInterface::ctor(handlers);
    Engine::singleton()
        .register_singleton(&MizerInterface::class_id().to_string_name(), &interface);

    runtime.start();

    loop {
        if runtime.iteration() {
            break;
        }
    }

    Ok(())
}

#[derive(GodotClass)]
#[class(no_init, base=Object)]
pub(crate) struct MizerInterface {
    handlers: Handlers<Api>,
}

impl UserSingleton for MizerInterface {}

impl MizerInterface {
    fn ctor(handlers: Handlers<Api>) -> Gd<Self> {
        Gd::from_object(Self { handlers })
    }
}
