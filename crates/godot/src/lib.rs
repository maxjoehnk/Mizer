use godot::classes::{Container, Control, Engine, IPanelContainer, PanelContainer};
use godot::obj::Singleton;
use godot::prelude::*;
use libgodot::GodotOptions;
use mizer::Api;
use mizer_api::handlers::Handlers;
use crate::panels::sequences_panel::SequencesPanel;
use crate::views::ActiveView;

mod controls;
mod views;
mod panels;

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

#[derive(GodotClass)]
#[class(init, singleton, base=Object)]
pub(crate) struct WindowConfiguration {
    base: Base<Object>,
    pub view: ActiveView,
    pub console_open: bool,
    pub selection_open: bool,
    pub programmer_open: bool,
}

impl WindowConfiguration {
    pub fn set_view(&mut self, view: ActiveView) {
        self.view = view;
        self.signals().view_changed().emit(view);
    }

    pub fn toggle_console(&mut self) {
        self.console_open = !self.console_open;
    }

    pub fn toggle_selection(&mut self) {
        self.selection_open = !self.selection_open;
    }

    pub fn toggle_programmer(&mut self) {
        self.programmer_open = !self.programmer_open;
    }
}

#[godot_api]
impl WindowConfiguration {
    #[signal]
    fn view_changed(view: ActiveView);
}

#[derive(GodotClass)]
#[class(init, base=PanelContainer)]
struct MizerWindow {
    base: Base<PanelContainer>,
}

impl MizerWindow {
    fn change_view(&mut self, view: ActiveView) {
        let node = match view {
            ActiveView::Sequencer => {
                let panel_scene = load::<PackedScene>("res://scenes/panels/sequences_panel.tscn");
                panel_scene.instantiate_as::<SequencesPanel>().upcast::<Node>()
            },
            _ => Control::new_alloc().upcast::<Node>(),
        };

        let mut parent = self.base_mut().get_node_as::<Container>("%Content");
        let children = parent.get_children();
        for child in children.iter_shared() {
            parent.remove_child(&child);
        }
        parent.add_child(&node);
    }
}

#[godot_api]
impl IPanelContainer for MizerWindow {
    #[cfg(not(feature = "editor"))]
    fn ready(&mut self) {
        WindowConfiguration::singleton().signals().view_changed().connect_other(self, Self::change_view);
    }
}
