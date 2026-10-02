use std::cell::OnceCell;
use godot::classes::{Container, Control, HFlowContainer, IControl, IPanelContainer, MarginContainer, PanelContainer, ScrollContainer};
use godot::classes::control::{LayoutPreset, SizeFlags};
use godot::classes::scroll_container::ScrollMode;
use godot::prelude::*;
use crate::MizerInterface;
use crate::controls::{GridButton, MizerPanel};

#[derive(GodotClass)]
#[class(init, base=Control)]
pub struct SequencesPanel {
    base: Base<Control>,
    container: OnceCell<Gd<HFlowContainer>>
}

#[godot_api]
impl IControl for SequencesPanel {
    fn enter_tree(&mut self) {
        let panel_scene = load::<PackedScene>("res://scenes/panel.tscn");
        let mut panel = panel_scene.instantiate_as::<MizerPanel>();
        panel.bind_mut().set_title("Sequences");
        self.base_mut().add_child(&panel);

        self.base_mut().set_anchors_preset(LayoutPreset::FULL_RECT);
        self.base_mut().set_v_size_flags(SizeFlags::EXPAND_FILL);
        self.base_mut().set_h_size_flags(SizeFlags::EXPAND_FILL);

        let mut margin_container = MarginContainer::new_alloc();
        margin_container.add_theme_constant_override("margin_left", 1);
        margin_container.add_theme_constant_override("margin_right", 1);
        margin_container.add_theme_constant_override("margin_top", 1);
        margin_container.add_theme_constant_override("margin_bottom", 1);
        margin_container.set_v_size_flags(SizeFlags::EXPAND_FILL);
        panel.add_child(&margin_container);

        // let mut scroll_container = ScrollContainer::new_alloc();
        // scroll_container.set_horizontal_scroll_mode(ScrollMode::DISABLED);
        // scroll_container.set_vertical_scroll_mode(ScrollMode::AUTO);
        // margin_container.add_child(&scroll_container);

        let mut grid_container = HFlowContainer::new_alloc();
        grid_container.set_v_size_flags(SizeFlags::EXPAND_FILL);
        grid_container.set_h_size_flags(SizeFlags::EXPAND_FILL);
        margin_container.add_child(&grid_container);
        self.container.set(grid_container).unwrap();
    }

    fn process(&mut self, delta: f64) {
        let interface = MizerInterface::singleton();
        let interface = interface.bind();
        let sequences = interface.handlers.sequencer.get_sequences();
        let container = self.container.get_mut().unwrap();

        for child in container.get_children().iter_shared() {
            container.remove_child(&child);
        }

        let count = sequences.sequences.len();
        for sequence in sequences.sequences {
            let mut button = GridButton::new();
            button.bind_mut().label = sequence.name.to_godot();
            container.add_child(&button);
        }

        let fill_count = 200usize.saturating_sub(count);
        for _ in 0..fill_count {
            let mut button = GridButton::new();
            button.set_disabled(true);
            container.add_child(&button);
        }
    }
}
