use std::collections::HashMap;
use std::sync::atomic::{AtomicU32, Ordering};
use std::sync::Arc;
use std::time::{Duration, Instant};

use dashmap::{DashMap, DashSet};
use pinboard::NonEmptyPinboard;

use mizer_clock::Timecode;
use mizer_message_bus::{MessageBus, Subscriber};

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
    recording: Arc<DashSet<TimecodeId>>,
}

#[derive(Default, Debug, Copy, Clone, PartialEq)]
struct TimecodeState {
    start_point: Option<Instant>,
    timestamp: Duration,
}

impl TimecodeState {
    fn is_running(&self) -> bool {
        self.timestamp > Duration::ZERO || self.start_point.is_some()
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
            recording: Arc::new(Default::default()),
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
        self.recording.clear();
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

    pub fn record_control_value(
        &self,
        control_id: TimecodeControlId,
        value: f64,
    ) -> anyhow::Result<()> {
        for timecode_id in self.recording.iter() {
            let timecode_id = timecode_id.to_owned();
            let Some(state) = self.timecode_states.get(&timecode_id) else {
                continue;
            };
            let Some(start_point) = state.start_point else {
                continue;
            };
            let frame = start_point.elapsed();
            let frame = frame.as_secs_f64();
            self.update_timecode(timecode_id, |timecode| {
                if let Some(control) = timecode.controls.iter_mut().find(|c| c.id == control_id) {
                    control.spline.add_simple_step(frame, value);
                }
            })?;
        }

        Ok(())
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

        let timestamp = state.timestamp.as_secs_f64().max(0.0);

        let value = control.sample(timestamp);

        Some(value)
    }

    pub fn write_timestamp(&self, timecode_id: TimecodeId, timestamp: Duration) {
        if let Some(mut state) = self.timecode_states.get_mut(&timecode_id) {
            state.timestamp = timestamp;
            state.start_point = Some(Instant::now() - timestamp);
        }
    }

    pub fn start_timecode_track(&self, timecode_id: TimecodeId) {
        if let Some(mut state) = self.timecode_states.get_mut(&timecode_id) {
            state.start_point = Some(Instant::now());
        }
    }

    pub fn stop_timecode_track(&self, timecode_id: TimecodeId) {
        if let Some(mut state) = self.timecode_states.get_mut(&timecode_id) {
            state.start_point = None;
            state.timestamp = Duration::ZERO;
        }
    }

    pub fn start_timecode_track_recording(&self, timecode_id: TimecodeId) {
        if self.timecode_states.contains_key(&timecode_id) {
            self.recording.insert(timecode_id);
        }
    }

    pub fn stop_timecode_track_recording(&self, timecode_id: TimecodeId) {
        if self.timecode_states.contains_key(&timecode_id) {
            self.recording.remove(&timecode_id);
        }
    }

    pub(crate) fn advance_timecodes(&self) {
        for mut state in self.timecode_states.iter_mut() {
            if let Some(start_frame) = state.start_point {
                state.timestamp = start_frame.elapsed();
            }
        }
    }

    pub fn get_state_access(&self, id: TimecodeId) -> Option<TimecodeStateAccess> {
        self.timecode_states.get(&id).map(|_| TimecodeStateAccess {
            id,
            states: Arc::clone(&self.timecode_states),
        })
    }

    pub fn get_running_timecodes(&self) -> Vec<TimecodeId> {
        self.timecode_states
            .iter()
            .filter_map(|state| {
                if state.is_running() {
                    Some(*state.key())
                } else {
                    None
                }
            })
            .collect()
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
            .map(|state| state.start_point.is_some())
            .unwrap_or_default()
    }

    pub fn get_timecode(&self) -> Option<Timecode> {
        self.states
            .get(&self.id)
            .map(|state| Timecode::from_duration(state.timestamp, TIMECODE_FPS))
    }
}
