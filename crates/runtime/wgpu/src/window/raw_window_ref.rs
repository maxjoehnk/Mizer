use std::ops::Deref;
use std::sync::mpsc::Receiver;

use raw_window_handle::{HasRawDisplayHandle, RawDisplayHandle};
use winit::event::WindowEvent;

pub struct RawWindowRef {
    pub(crate) window: winit::window::Window,
    pub(crate) events: Receiver<WindowEvent>,
}

impl Deref for RawWindowRef {
    type Target = winit::window::Window;

    fn deref(&self) -> &Self::Target {
        &self.window
    }
}

unsafe impl HasRawDisplayHandle for RawWindowRef {
    fn raw_display_handle(&self) -> RawDisplayHandle {
        self.window.raw_display_handle()
    }
}

impl Drop for RawWindowRef {
    fn drop(&mut self) {
        log::debug!("Dropping window");
        self.window.set_visible(false);
    }
}

impl RawWindowRef {
    pub fn get_events(&mut self) -> Vec<WindowEvent> {
        let mut events = Vec::new();
        while let Ok(event) = self.events.try_recv() {
            events.push(event);
        }
        events
    }
}
