use crate::buffer::DmxBuffer;
use evmap::{ReadHandleFactory, WriteHandle};
use std::collections::HashSet;
use std::sync::Arc;

type UniverseData = Arc<[u8; 512]>;

pub struct DmxMonitorInternalHandle {
    write_handle: WriteHandle<u16, UniverseData>,
    universes: HashSet<u16>,
}

impl DmxMonitorInternalHandle {
    pub fn write(&mut self, data: &DmxBuffer) {
        profiling::scope!("DmxMonitorInternalHandle::write");
        let universes = data.universes().collect::<HashSet<_>>();
        for (universe, data) in data.iter() {
            self.write_handle.update(universe, Arc::new(data));
        }
        self.universes
            .iter()
            .filter(|universe| !universes.contains(universe))
            .for_each(|universe| {
                self.write_handle.empty(*universe);
            });
        self.universes = universes;
    }

    pub fn flush(&mut self) {
        self.write_handle.refresh();
    }
}

#[derive(Clone)]
pub struct DmxMonitorHandle {
    handle_factory: ReadHandleFactory<u16, UniverseData>,
}

impl DmxMonitorHandle {
    pub fn read(&self, universe: u16) -> Option<UniverseData> {
        let handle = self.handle_factory.handle();
        let universe_guard = handle.get(&universe)?;

        universe_guard.into_iter().next().cloned()
    }

    pub fn read_all(&self) -> Vec<(u16, UniverseData)> {
        let handle = self.handle_factory.handle();
        let data = handle
            .map_into::<_, Vec<_>, _>(|universe, data| (*universe, data.iter().next().cloned()));

        data.into_iter()
            .filter_map(|(universe, data)| data.map(|data| (universe, data)))
            .collect()
    }
}

pub fn create_monitor() -> (DmxMonitorInternalHandle, DmxMonitorHandle) {
    let (read_handle, write_handle) = evmap::new();
    (
        DmxMonitorInternalHandle {
            write_handle,
            universes: Default::default(),
        },
        DmxMonitorHandle {
            handle_factory: read_handle.factory(),
        },
    )
}
