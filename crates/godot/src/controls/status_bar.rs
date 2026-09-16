use crate::MizerInterface;
use godot::classes::{HBoxContainer, IHBoxContainer, Label};
use godot::obj::{Base, Gd, Singleton};
use godot::prelude::*;
use jiff::Unit;
use mizer_message_bus::Subscriber;
use mizer_status_bus::StatusMessage;

#[derive(GodotClass)]
#[class(init, base=HBoxContainer)]
struct MizerStatusBar {
    base: Base<HBoxContainer>,
    fps_subscriber: Option<Subscriber<f64>>,
    message_subscriber: Option<Subscriber<Option<StatusMessage>>>,
}

#[godot_api]
impl IHBoxContainer for MizerStatusBar {
    fn ready(&mut self) {
        let handlers = MizerInterface::singleton();
        let handlers = handlers.bind();
        let fps = handlers.handlers.status.get_fps_counter();
        let message = handlers.handlers.status.observe_status_messages();

        self.fps_subscriber = Some(fps);
        self.message_subscriber = Some(message);
        self.message_control().set_text("");
    }


    fn process(&mut self, _delta: f64) {
        if let Some(fps) = self.fps_subscriber.as_ref().and_then(|s| s.read()) {
            let mut fps_control = self.fps_control();
            fps_control.set_text(&format!("FPS {fps:.2}"))
        }

        if let Some(message) = self.message_subscriber.as_ref().and_then(|s| s.read()) {
            if let Some(message) = message {
                let mut message_control = self.message_control();
                message_control.set_text(&message.message);
            }
        }

        if let Ok(now) = jiff::Zoned::now().round(Unit::Second) {
            let hour = now.hour();
            let minute = now.minute();

            let mut control = self.time_control();
            control.set_text(&format!("{hour:02}:{minute:02}"))

        }
    }
}

impl MizerStatusBar {
    fn message_control(&self) -> Gd<Label> {
        self.base().get_node_as("Message")
    }

    fn fps_control(&self) -> Gd<Label> {
        self.base().get_node_as("FPS")
    }

    fn time_control(&self) -> Gd<Label> {
        self.base().get_node_as("Time")
    }
}
