use godot::classes::{IHBoxContainer, IVBoxContainer, Texture2D, VBoxContainer};
use godot::obj::{Base, Singleton, WithBaseField};
use godot::prelude::*;
use godot::register::GodotClass;
use crate::controls::grid_button::GridButton;
use crate::views::ActiveView;
use crate::WindowConfiguration;

const GRID_BUTTON_SCENE: &'static str = "res://scenes/grid_button.tscn";

#[derive(GodotClass)]
#[class(init, base=VBoxContainer)]
struct MizerNavigationBar {
    base: Base<VBoxContainer>,
}

impl MizerNavigationBar {
    fn add_view_button(&mut self, icon_path: &str, label: &str, view: ActiveView) {
        let mut grid_button = GridButton::new();
        grid_button.bind_mut().icon = Some(load::<Texture2D>(icon_path));
        grid_button.bind_mut().label = label.into();
        grid_button.bind_mut().base_mut().signals().pressed().connect(move || {
            WindowConfiguration::singleton().bind_mut().set_view(view);
        });
        self.base_mut().add_child(&grid_button);
    }
}

#[godot_api]
impl IVBoxContainer for MizerNavigationBar {
    fn ready(&mut self) {
        let children = self.base().get_children();
        for child in children.iter_shared() {
            self.base_mut().remove_child(&child);
        }
        self.add_view_button("res://assets/icons/view-quilt-outline.svg", "Layout", ActiveView::Layout);
        self.add_view_button("res://assets/icons/view-comfy.svg", "2D Plan", ActiveView::Plan);
        self.add_view_button("res://assets/icons/account-tree-outline.svg", "Nodes", ActiveView::Nodes);
        self.add_view_button("res://assets/icons/animation-play-outline.svg", "Sequencer", ActiveView::Sequencer);
        self.add_view_button("res://assets/icons/tune-vertical.svg", "Fixtures", ActiveView::Fixtures);
        self.add_view_button("res://assets/icons/palette-swatch-outline.svg", "Presets", ActiveView::Presets);
        self.add_view_button("res://assets/icons/vector-circle.svg", "Effects", ActiveView::Effects);
        self.add_view_button("res://assets/icons/multimedia.svg", "Media", ActiveView::Media);
        self.add_view_button("res://assets/icons/monitor.svg", "Surfaces", ActiveView::Surfaces);
        self.add_view_button("res://assets/icons/chart-timeline.svg", "Timecode", ActiveView::Timecode);

        for _ in 0..20 {
            let mut grid_button = GridButton::new();
            grid_button.bind_mut().disable();
            self.base_mut().add_child(&grid_button);
        }
    }
}
