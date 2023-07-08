use winit::event::Event;
use winit::platform::run_return::EventLoopExtRunReturn;
use winit::window::WindowId;

use mizer_module::{ClockFrame, Injector, Processor};

use super::{EventLoopHandle, WindowEvent, WindowEvents};

pub struct WindowProcessor;

impl Processor for WindowProcessor {
    fn pre_process(&mut self, injector: &mut Injector, _frame: ClockFrame) {
        let event_loop = injector.get_mut::<EventLoopHandle>().unwrap();
        event_loop
            .event_loop
            .run_return(|event, target, control_flow| match event {
                Event::WindowEvent {
                    event: winit::event::WindowEvent::Resized(size),
                    window_id,
                } => {
                    resize(&event_loop.window_events, window_id, size);
                    control_flow.set_poll();
                }
                Event::WindowEvent {
                    event:
                        winit::event::WindowEvent::ScaleFactorChanged {
                            new_inner_size: size,
                            ..
                        },
                    window_id,
                } => {
                    resize(&event_loop.window_events, window_id, *size);
                    control_flow.set_poll();
                }
                _ => control_flow.set_exit(),
            });
    }
}

fn resize(window_events: &WindowEvents, window_id: WindowId, size: winit::dpi::PhysicalSize<u32>) {
    if let Some(window) = window_events.get(&window_id) {
        if let Err(err) = window.send(WindowEvent::Resized {
            width: size.width,
            height: size.height,
        }) {
            log::error!("Failed to send window event: {err:?}");
            // TODO: drop the window from the map here?
        }
    }
}
