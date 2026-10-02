use godot::classes::{Button, IButton, Label, Texture2D, TextureRect};
use godot::obj::{Base, WithBaseField};
use godot::prelude::*;
use godot::register::GodotClass;

const GRID_BUTTON_SCENE: &'static str = "res://scenes/grid_button.tscn";

#[derive(GodotClass)]
#[class(tool, init, base=Button)]
pub struct GridButton {
    base: Base<Button>,
    #[export]
    pub icon: Option<Gd<Texture2D>>,
    #[export]
    pub label: GString
}

impl GridButton {
    pub fn new() -> Gd<Self> {
        let grid_button_scene = load::<PackedScene>(GRID_BUTTON_SCENE);
        let grid_button = grid_button_scene.instantiate_as::<GridButton>();
        
        grid_button
    }
    
    pub fn disable(&mut self) {
        self.base_mut().set_disabled(true);
    }
}

#[godot_api]
impl IButton for GridButton {
    fn ready(&mut self) {
        self.base().get_node_as::<TextureRect>("%Icon").set_texture(self.icon.as_ref());
        self.base().get_node_as::<Label>("%Label").set_text(&self.label);
    }
}
