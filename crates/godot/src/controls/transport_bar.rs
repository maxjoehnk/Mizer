use crate::MizerInterface;
use godot::classes::{Control, HBoxContainer, IHBoxContainer, Label, LineEdit};
use godot::obj::Base;
use godot::prelude::*;
use godot::register::GodotClass;
use std::cell::OnceCell;

const SPEED_CONTROL: &'static str = "TransportBar/HBoxContainer/Speed";
const BEAT_INDICATOR: &'static str = "TransportBar/HBoxContainer/MarginContainer2/BeatIndicator";
const TIME_CONTROL: &'static str = "TransportBar/HBoxContainer/Timecode";
const COMMAND_LINE: &'static str = "TransportBar/HBoxContainer/MarginContainer/CommandLine";

const PRIMARY: Color = Color::from_rgba8(0xff, 0x57, 0x22, 0xff);
const INACTIVE: Color = Color::from_rgba8(0xff, 0xff, 0xff, 0x1A);

#[derive(GodotClass)]
#[class(init, base=HBoxContainer)]
struct MizerTransportBar {
    base: Base<HBoxContainer>,
    time_control: OnceCell<Gd<Label>>,
}

impl MizerTransportBar {
    fn update_command_line(text: GString) {
        let interface = MizerInterface::singleton();
        let interface = interface.bind();
        interface.handlers.ui.command_line_execute(text.to_string());
    }

    fn update_beat_indicator(&self, beat: f64) {
        let mut beat_indicator = self.base().get_node_as::<Control>(BEAT_INDICATOR);
        let size = beat_indicator.get_size();
        let active_beat = beat.floor() as i32;
        for i in 0..4 {
            beat_indicator.draw_rect(
                Rect2::new(
                    Vector2::new(i as f32 * 10.0, 0.0),
                    Vector2::new(10.0, 10.0),
                ),
                if i == active_beat {
                    PRIMARY
                } else {
                    INACTIVE
                }
            )
        }
    }
}

#[godot_api]
impl IHBoxContainer for MizerTransportBar {
    fn ready(&mut self) {
        let command_line = self.base().get_node_as::<LineEdit>(COMMAND_LINE);
        command_line.signals().text_submitted().connect(Self::update_command_line);

        self.time_control.set(self.base().get_node_as::<Label>(TIME_CONTROL)).unwrap();
    }

    fn process(&mut self, delta: f64) {
        // if Os::singleton().has_feature("editor") {
        //     return;
        // }
        let interface = MizerInterface::singleton();
        let interface = interface.bind();
        let snapshot = interface.handlers.transport.clock_ref().read();

        self.time_control.get_mut().unwrap().set_text(&snapshot.time.to_string());

        // self.update_beat_indicator(snapshot.beat);
    }
}
