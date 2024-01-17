use std::collections::HashMap;
use std::sync::atomic::{AtomicU32, Ordering};
use std::sync::Arc;

use dashmap::DashMap;
use pinboard::NonEmptyPinboard;

use mizer_clock::Timecode;
use mizer_message_bus::{MessageBus, Subscriber};
use mizer_module::ClockFrame;

use crate::model::*;

const TIMECODE_FPS: f64 = 60.0; // TODO: use context framerate here or run timecode always at 60fps?

#[derive(Debug, Clone)]
pub struct TimecodeManager {
    timecode_counter: Arc<AtomicU32>,
    timecodes: Arc<NonEmptyPinboard<HashMap<TimecodeId, TimecodeTrack>>>,
    control_counter: Arc<AtomicU32>,
    controls: Arc<NonEmptyPinboard<HashMap<TimecodeControlId, TimecodeControl>>>,
    timecode_states: Arc<DashMap<TimecodeId, TimecodeState>>,
    timecode_bus: Arc<MessageBus<Vec<TimecodeTrack>>>,
}

#[derive(Default, Debug, Copy, Clone, PartialEq)]
struct TimecodeState {
    start_frame: Option<u64>,
    timestamp: i128,
}

impl TimecodeState {
    fn is_running(&self) -> bool {
        self.timestamp > 0 || self.start_frame.is_some()
    }
}

impl Default for TimecodeManager {
    fn default() -> Self {
        Self {
            timecode_counter: Arc::new(AtomicU32::new(1)),
            timecodes: Arc::new(NonEmptyPinboard::new(Default::default())),
            control_counter: Arc::new(AtomicU32::new(1)),
            controls: Arc::new(NonEmptyPinboard::new(Default::default())),
            timecode_states: Arc::new(Default::default()),
            timecode_bus: Arc::new(Default::default()),
        }
    }
}

impl TimecodeManager {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn clear(&self) {
        self.timecode_counter.store(1, Ordering::Relaxed);
        self.timecodes.set(Default::default());
        self.control_counter.store(1, Ordering::Relaxed);
        self.controls.set(Default::default());
        self.timecode_states.clear();
        self.emit_bus();
    }

    pub fn load_timecodes(&self, timecodes: Vec<TimecodeTrack>, controls: Vec<TimecodeControl>) {
        let timecode_id = timecodes.iter().map(|t| t.id).max().unwrap_or_default() + 1;
        for timecode in &timecodes {
            self.timecode_states.insert(timecode.id, Default::default());
        }
        self.timecodes
            .set(timecodes.into_iter().map(|t| (t.id, t)).collect());
        self.timecode_counter
            .store(timecode_id.0, Ordering::Relaxed);
        let control_id = controls.iter().map(|c| c.id).max().unwrap_or_default() + 1;
        self.controls
            .set(controls.into_iter().map(|c| (c.id, c)).collect());
        self.control_counter.store(control_id.0, Ordering::Relaxed);
        self.emit_bus();
    }

    pub fn timecodes(&self) -> Vec<TimecodeTrack> {
        self.timecodes.read().into_values().collect()
    }

    pub fn observe_timecodes(&self) -> Subscriber<Vec<TimecodeTrack>> {
        self.timecode_bus.subscribe()
    }

    pub fn controls(&self) -> Vec<TimecodeControl> {
        self.controls.read().into_values().collect()
    }

    pub(crate) fn add_timecode(&self, name: String) -> TimecodeTrack {
        let timecode = TimecodeTrack {
            id: self.timecode_counter.fetch_add(1, Ordering::Relaxed).into(),
            name,
            controls: self
                .controls()
                .into_iter()
                .map(|c| TimecodeControlValues {
                    id: c.id,
                    spline: Default::default(),
                })
                .collect(),
            labels: Default::default(),
        };
        let mut timecodes = self.timecodes.read();
        timecodes.insert(timecode.id, timecode.clone());
        self.timecode_states.insert(timecode.id, Default::default());
        self.timecodes.set(timecodes);
        self.emit_bus();

        timecode
    }

    pub(crate) fn insert_timecode(&self, timecode: TimecodeTrack) {
        let mut timecodes = self.timecodes.read();
        self.timecode_states.insert(timecode.id, Default::default());
        timecodes.insert(timecode.id, timecode);
        self.timecodes.set(timecodes);
        self.emit_bus();
    }

    pub(crate) fn remove_timecode(&self, timecode_id: TimecodeId) -> Option<TimecodeTrack> {
        let mut timecodes = self.timecodes.read();
        let timecode = timecodes.remove(&timecode_id);
        self.timecodes.set(timecodes);
        self.emit_bus();

        timecode
    }

    pub(crate) fn update_timecode(
        &self,
        timecode_id: TimecodeId,
        update: impl FnOnce(&mut TimecodeTrack),
    ) -> anyhow::Result<()> {
        let mut timecodes = self.timecodes.read();
        let timecode = timecodes
            .get_mut(&timecode_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown timecode {}", timecode_id))?;
        update(timecode);
        self.timecodes.set(timecodes);
        self.emit_bus();

        Ok(())
    }

    pub(crate) fn add_timecode_control(&self, name: String) -> TimecodeControl {
        let timecode_control = TimecodeControl {
            id: self.control_counter.fetch_add(1, Ordering::Relaxed).into(),
            name,
        };
        let mut controls = self.controls.read();
        controls.insert(timecode_control.id, timecode_control.clone());
        self.controls.set(controls);
        let mut timecodes = self.timecodes.read();
        for (_, timecode) in timecodes.iter_mut() {
            timecode.controls.push(TimecodeControlValues {
                id: timecode_control.id,
                spline: Default::default(),
            });
        }
        self.timecodes.set(timecodes);
        self.emit_bus();

        timecode_control
    }

    pub(crate) fn insert_timecode_control(
        &self,
        timecode_control: TimecodeControl,
        timecode_values: Vec<(TimecodeId, TimecodeControlValues)>,
    ) {
        let timecode_control_id = timecode_control.id;
        let mut timecode_controls = self.controls.read();
        timecode_controls.insert(timecode_control_id, timecode_control);
        self.controls.set(timecode_controls);
        let mut timecodes = self.timecodes.read();
        for (timecode_id, timecode) in timecodes.iter_mut() {
            let control_value = timecode_values
                .iter()
                .find(|(id, _)| timecode_id == id)
                .map(|(_, v)| v)
                .cloned()
                .unwrap_or_else(|| TimecodeControlValues {
                    id: timecode_control_id,
                    spline: Default::default(),
                });
            timecode.controls.push(control_value);
        }
        self.timecodes.set(timecodes);
        self.emit_bus();
    }

    pub(crate) fn remove_timecode_control(
        &self,
        timecode_control_id: TimecodeControlId,
    ) -> Option<(TimecodeControl, Vec<(TimecodeId, TimecodeControlValues)>)> {
        let mut controls = self.controls.read();
        let timecode_control = controls.remove(&timecode_control_id);
        self.controls.set(controls);
        let mut values = Vec::new();
        let mut timecodes = self.timecodes.read();
        for (timecode_id, timecode) in timecodes.iter_mut() {
            if let Some(p) = timecode
                .controls
                .iter()
                .position(|c| c.id == timecode_control_id)
            {
                let control_values = timecode.controls.remove(p);
                values.push((*timecode_id, control_values));
            }
        }
        self.timecodes.set(timecodes);
        self.emit_bus();

        timecode_control.map(|control| (control, values))
    }

    pub(crate) fn update_timecode_control(
        &self,
        timecode_control_id: TimecodeControlId,
        update: impl FnOnce(&mut TimecodeControl),
    ) -> anyhow::Result<()> {
        let mut timecode_controls = self.controls.read();
        let timecode_control = timecode_controls
            .get_mut(&timecode_control_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown Timecode Control {}", timecode_control_id))?;
        update(timecode_control);
        self.controls.set(timecode_controls);
        self.emit_bus();

        Ok(())
    }

    pub fn get_control_value(&self, control_id: TimecodeControlId) -> Option<f64> {
        let state = self
            .timecode_states
            .iter()
            .find(|state| state.is_running())?;
        let timecodes = self.timecodes.read();
        let timecode = timecodes.get(state.key())?;
        let control = timecode.get_control(control_id)?;

        if control.spline.is_empty() {
            return None;
        }

        let timestamp = state.timestamp.max(0) as u64;
        if control.is_out_of_bounds(timestamp) {
            return None;
        }

        let value = control.sample(timestamp);

        Some(value)
    }

    pub fn write_timestamp(&self, timecode_id: TimecodeId, timestamp: u64) {
        if let Some(mut state) = self.timecode_states.get_mut(&timecode_id) {
            state.timestamp = timestamp as i128;
        }
    }

    pub fn start_timecode_track(&self, timecode_id: TimecodeId, frame: ClockFrame) {
        if let Some(mut state) = self.timecode_states.get_mut(&timecode_id) {
            state.start_frame = Some(frame.frames);
        }
    }

    pub fn stop_timecode_track(&self, timecode_id: TimecodeId) {
        if let Some(mut state) = self.timecode_states.get_mut(&timecode_id) {
            state.start_frame = None;
            state.timestamp = 0;
        }
    }

    pub(crate) fn advance_timecodes(&self, frame: ClockFrame, fps: f64) {
        for mut state in self.timecode_states.iter_mut() {
            if let Some(start_frame) = state.start_frame {
                state.timestamp =
                    (frame.frames as i128 - start_frame as i128) * (TIMECODE_FPS / fps) as i128;
                // TODO: only apply diffed fps to new frames
                // This is only relevant when the fps changes during playback
            }
        }
    }

    pub fn get_state_access(&self, id: TimecodeId) -> Option<TimecodeStateAccess> {
        self.timecode_states.get(&id).map(|_| TimecodeStateAccess {
            id,
            states: Arc::clone(&self.timecode_states),
        })
    }

    fn emit_bus(&self) {
        self.timecode_bus.send(self.timecodes());
    }
}

#[derive(Debug, Clone)]
pub struct TimecodeStateAccess {
    id: TimecodeId,
    states: Arc<DashMap<TimecodeId, TimecodeState>>,
}

impl TimecodeStateAccess {
    pub fn is_playing(&self) -> bool {
        self.states
            .get(&self.id)
            .map(|state| state.start_frame.is_some())
            .unwrap_or_default()
    }

    pub fn get_timecode(&self) -> Option<Timecode> {
        self.states
            .get(&self.id)
            .map(|state| Timecode::from_i128(state.timestamp, TIMECODE_FPS))
    }
}
