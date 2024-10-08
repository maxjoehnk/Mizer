use std::ops::Deref;
use std::sync::mpsc::Receiver;
use std::sync::Arc;

use winit::event::WindowEvent;
use winit::raw_window_handle::{DisplayHandle, HandleError, HasDisplayHandle};

pub struct RawWindowRef {
    pub window: Arc<winit::window::Window>,
    pub(crate) events: Receiver<WindowEvent>,
}

impl Deref for RawWindowRef {
    type Target = winit::window::Window;

    fn deref(&self) -> &Self::Target {
        &self.window
    }
}

impl HasDisplayHandle for RawWindowRef {
    fn display_handle(&self) -> Result<DisplayHandle<'_>, HandleError> {
        self.window.display_handle()
    }
}

impl Drop for RawWindowRef {
    fn drop(&mut self) {
        tracing::debug!("Dropping window");
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
