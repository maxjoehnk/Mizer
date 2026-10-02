use crate::MizerInterface;
use godot::classes::{Button, Control, HBoxContainer, IHBoxContainer, Label, LineEdit};
use godot::obj::Base;
use godot::prelude::*;
use godot::register::GodotClass;
use mizer_api::proto::transport::TransportState;

const SPEED_CONTROL: &'static str = "TransportBar/HBoxContainer/Speed";
const BEAT_INDICATOR: &'static str = "TransportBar/HBoxContainer/MarginContainer2/BeatIndicator";
const TIME_CONTROL: &'static str = "TransportBar/HBoxContainer/Timecode";
const STOP_CONTROL: &'static str = "TransportBar/HBoxContainer/HBoxContainer/Stop";
const PAUSE_CONTROL: &'static str = "TransportBar/HBoxContainer/HBoxContainer/Pause";
const PLAY_CONTROL: &'static str = "TransportBar/HBoxContainer/HBoxContainer/Play";
const COMMAND_LINE: &'static str = "TransportBar/HBoxContainer/MarginContainer/CommandLine";

const PRIMARY: Color = Color::from_rgba8(0xff, 0x57, 0x22, 0xff);
const INACTIVE: Color = Color::from_rgba8(0xff, 0xff, 0xff, 0x1A);

#[derive(GodotClass)]
#[class(init, base=HBoxContainer)]
struct MizerTransportBar {
    base: Base<HBoxContainer>,
    #[init(node = COMMAND_LINE)]
    command_line: OnReady<Gd<LineEdit>>,
    #[init(node = TIME_CONTROL)]
    time_control: OnReady<Gd<Label>>,
    #[init(node = STOP_CONTROL)]
    stop_control: OnReady<Gd<Button>>,
    #[init(node = PAUSE_CONTROL)]
    pause_control: OnReady<Gd<Button>>,
    #[init(node = PLAY_CONTROL)]
    play_control: OnReady<Gd<Button>>,
    #[init(node = BEAT_INDICATOR)]
    beat_indicator: OnReady<Gd<Control>>,
}

impl MizerTransportBar {
    fn update_command_line(text: GString) {
        let interface = MizerInterface::singleton();
        let interface = interface.bind();
        interface.handlers.ui.command_line_execute(text.to_string());
    }

    fn update_beat_indicator(&mut self, beat: f64) {
        let size = self.beat_indicator.get_size();
        let active_beat = beat.floor() as i32;
        for i in 0..4 {
            self.beat_indicator.draw_rect(
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
        self.command_line.signals().text_submitted().connect(Self::update_command_line);

        self.stop_control.signals().pressed().connect(|| {
            let interface = MizerInterface::singleton();
            let interface = interface.bind();
            interface.handlers.transport.set_state(TransportState::Stopped);
        });

        self.pause_control.signals().pressed().connect(|| {
            let interface = MizerInterface::singleton();
            let interface = interface.bind();
            interface.handlers.transport.set_state(TransportState::Paused);
        });

        self.play_control.signals().pressed().connect(|| {
            let interface = MizerInterface::singleton();
            let interface = interface.bind();
            interface.handlers.transport.set_state(TransportState::Playing);
        });
    }

    #[cfg(not(feature = "editor"))]
    fn process(&mut self, delta: f64) {
        let interface = MizerInterface::singleton();
        let interface = interface.bind();
        let snapshot = interface.handlers.transport.clock_ref().read();

        self.time_control.set_text(&snapshot.time.to_string());

        // self.update_beat_indicator(snapshot.beat);
    }
}
