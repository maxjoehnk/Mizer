use std::time::Duration;

use winit::event::{Event, WindowEvent};
use winit::platform::pump_events::EventLoopExtPumpEvents;
use winit::window::WindowId;

use mizer_module::{ClockFrame, DebuggableProcessor, Injector, Processor};

use super::{EventLoopHandle, WindowEventSenders};

pub struct WindowProcessor;

impl Processor for WindowProcessor {
    fn pre_process(&mut self, injector: &mut Injector, _frame: ClockFrame, _fps: f64) {
        let event_loop = injector.get_mut::<EventLoopHandle>().unwrap();
        event_loop
            .event_loop
            .pump_events(Some(Duration::ZERO), |event, _target| {
                if let Event::WindowEvent { event, window_id } = event {
                    send_window_event(&event_loop.window_event_sender, window_id, event);
                }
            });
    }
}

impl DebuggableProcessor for WindowProcessor {}

fn send_window_event(window_events: &WindowEventSenders, window_id: WindowId, event: WindowEvent) {
    if let Some(window) = window_events.get(&window_id) {
        if let Err(err) = window.send(event) {
            tracing::error!("Failed to send window event: {err:?}");
            // TODO: drop the window from the map here?
        }
    }
}
