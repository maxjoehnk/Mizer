use winit::event::{Event, WindowEvent};
use winit::platform::run_return::EventLoopExtRunReturn;
use winit::window::WindowId;

use mizer_module::{ClockFrame, DebuggableProcessor, Injector, Processor};

use super::{EventLoopHandle, WindowEventSenders};

pub struct WindowProcessor;

impl Processor for WindowProcessor {
    fn pre_process(&mut self, injector: &mut Injector, _frame: ClockFrame, _fps: f64) {
        let event_loop = injector.get_mut::<EventLoopHandle>().unwrap();
        event_loop
            .event_loop
            .run_return(|event, _target, control_flow| match event {
                Event::WindowEvent {
                    event:
                        winit::event::WindowEvent::ScaleFactorChanged {
                            new_inner_size: size,
                            ..
                        },
                    window_id,
                } => {
                    send_window_event(
                        &event_loop.window_event_sender,
                        window_id,
                        WindowEvent::Resized(*size),
                    );
                    control_flow.set_poll();
                }
                Event::WindowEvent { event, window_id } => {
                    send_window_event(
                        &event_loop.window_event_sender,
                        window_id,
                        event.to_static().unwrap(),
                    );
                    control_flow.set_poll();
                }
                _ => control_flow.set_exit(),
            });
    }
}

impl DebuggableProcessor for WindowProcessor {}

fn send_window_event(
    window_events: &WindowEventSenders,
    window_id: WindowId,
    event: WindowEvent<'static>,
) {
    if let Some(window) = window_events.get(&window_id) {
        if let Err(err) = window.send(event) {
            log::error!("Failed to send window event: {err:?}");
            // TODO: drop the window from the map here?
        }
    }
}
