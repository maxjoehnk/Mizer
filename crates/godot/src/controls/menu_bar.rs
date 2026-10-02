use crate::MizerInterface;
use godot::classes::{Button, FileDialog, HBoxContainer, IHBoxContainer, MenuButton, PopupMenu, Window};
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
    base: Base<HBoxContainer>,
    #[init(node = PROJECT_MENU)]
    project_menu: OnReady<Gd<MenuButton>>,
    #[init(node = "OpenDialog")]
    open_dialog: OnReady<Gd<FileDialog>>,
    #[init(node = "SaveDialog")]
    save_dialog: OnReady<Gd<FileDialog>>,
    #[init(node = "NewWindow")]
    new_window_btn: OnReady<Gd<Button>>,
    #[init(node = "ProjectSelector")]
    project_selector: OnReady<Gd<MenuButton>>,
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

    fn on_new_screen(&mut self) {
        let mut window = Window::new_alloc();
        let scene = load::<PackedScene>("res://scenes/main.tscn");
        let scene = scene.instantiate().unwrap();
        window.add_child(&scene);

        if let Some(mut scene) = self.base().get_tree().get_current_scene() {
            scene.add_child(&window);
        }
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
        if let Some(popup) = self.project_menu.get_popup() {
            popup.signals().id_pressed().connect_other(self, Self::on_menu_pressed);
        }
        self.open_dialog.signals().file_selected().connect(Self::on_open);
        self.save_dialog.signals().file_selected().connect(Self::on_save_as);
        self.new_window_btn.signals().pressed().connect_other(self, Self::on_new_screen);

    }

    fn process(&mut self, delta: f64) {
        // TODO: only update when history changes
        let interface = MizerInterface::singleton();
        let interface = interface.bind();
        let mut project_selector = self.project_selector.get_popup().unwrap();
        if let Some(history) = interface.handlers.session.get_history() {
            project_selector.clear();
            for item in history.items {
                project_selector.add_item(&item.label);
            }
        }
    }
}
