use std::ops::{Deref, DerefMut};

use dashmap::DashMap;

use mizer_message_bus::MessageBus;

use crate::{Surface, SurfaceId};

#[derive(Default)]
pub struct SurfaceRegistry {
    surfaces: DashMap<SurfaceId, Surface>,
    pub(crate) bus: MessageBus<Vec<Surface>>,
}

impl SurfaceRegistry {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn get<'a>(&'a self, id: &'a SurfaceId) -> Option<impl Deref<Target = Surface> + 'a> {
        self.surfaces.get(id)
    }

    pub fn get_mut<'a>(
        &'a self,
        id: &'a SurfaceId,
    ) -> Option<impl DerefMut<Target = Surface> + 'a> {
        self.surfaces.get_mut(id)
    }

    pub fn register_surface(&self, id: SurfaceId) {
        if self.surfaces.contains_key(&id) {
            return;
        }
        self.surfaces.insert(id, Surface::new(id));
        self.publish_update();
    }

    pub fn clear_surfaces(&self) {
        self.surfaces.clear();
        self.publish_update();
    }

    pub fn add_surfaces(&self, surfaces: Vec<Surface>) {
        for surface in surfaces {
            self.surfaces.insert(surface.id, surface);
        }
        self.publish_update();
    }

    pub fn list_surfaces(&self) -> Vec<Surface> {
        self.surfaces
            .iter()
            .map(|item| item.value().clone())
            .collect()
    }

    fn publish_update(&self) {
        self.bus.send(self.list_surfaces());
    }
}
