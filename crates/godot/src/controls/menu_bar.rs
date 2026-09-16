use crate::MizerInterface;
use godot::classes::{FileDialog, HBoxContainer, IHBoxContainer, MenuButton};
use godot::obj::{Base, Singleton, WithBaseField};
use godot::prelude::*;
use godot::register::GodotClass;

const PROJECT_MENU: &'static str = "ProjectMenu";

const PROJECT_NEW: i64 = 0;
const PROJECT_OPEN: i64 = 1;
const PROJECT_SAVE: i64 = 2;
const PROJECT_SAVE_AS: i64 = 3;

#[derive(GodotClass)]
#[class(init, base=HBoxContainer)]
struct MizerMenuBar {
    base: Base<HBoxContainer>
}

impl MizerMenuBar {
    fn on_menu_pressed(&mut self, id: i64) {
        let interface = MizerInterface::singleton();
        let interface = interface.bind();
        match id {
            PROJECT_NEW => {
                interface.handlers.session.new_project();
            },
            PROJECT_OPEN => self.open_project(),
            PROJECT_SAVE => {
                interface.handlers.session.save_project();
            },
            PROJECT_SAVE_AS => self.save_project_as(),
            _ => (),
        }
    }

    fn on_open(path: GString) {
        if path.is_empty() {
            return;
        }

        let interface = MizerInterface::singleton();
        let interface = interface.bind();

        interface.handlers.session.load_project(path.to_string());
    }

    fn on_save_as(path: GString) {
        if path.is_empty() {
            return;
        }

        let interface = MizerInterface::singleton();
        let interface = interface.bind();

        interface.handlers.session.save_project_as(path.to_string());
    }

    fn open_project(&mut self) {
        self.base().get_node_as::<FileDialog>("OpenDialog").show();
    }

    fn save_project_as(&mut self) {
        self.base().get_node_as::<FileDialog>("SaveDialog").show();
    }
}

#[godot_api]
impl IHBoxContainer for MizerMenuBar {
    fn ready(&mut self) {
        let project_menu = self.base().get_node_as::<MenuButton>(PROJECT_MENU);
        if let Some(popup) = project_menu.get_popup() {
            popup.signals().id_pressed().connect_other(self, Self::on_menu_pressed);
        }
        self.base().get_node_as::<FileDialog>("OpenDialog").signals().file_selected().connect(Self::on_open);
        self.base().get_node_as::<FileDialog>("SaveDialog").signals().file_selected().connect(Self::on_save_as);
    }
}
