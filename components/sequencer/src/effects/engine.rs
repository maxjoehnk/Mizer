use super::Effect;
use crate::effects::default_effects::CIRCLE;
use crate::effects::instance::EffectInstance;
use dashmap::DashMap;
use itertools::Itertools;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{ProgrammedEffect, Programmer};
use mizer_fixtures::FixtureId;
use mizer_module::ClockFrame;
use std::collections::HashMap;
use std::sync::{Arc, Mutex};

#[derive(Default, Clone)]
pub struct EffectEngine {
    pub effects: Arc<DashMap<u32, Effect>>,
    instances: Arc<Mutex<HashMap<EffectInstanceId, EffectInstance>>>,
    programmer_effects: Arc<Mutex<HashMap<ProgrammedEffect, EffectInstanceId>>>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct EffectInstanceId(uuid::Uuid);

impl EffectInstanceId {
    fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

impl EffectEngine {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn load_defaults(&mut self) {
        self.effects.insert(1, (1, &CIRCLE).into());
    }

    pub fn delete_effect(&self, id: u32) -> Option<Effect> {
        self.effects.remove(&id).map(|(_, effect)| effect)
    }

    pub fn add_effect(&self, effect: Effect) {
        self.effects.insert(effect.id, effect);
    }

    pub(crate) fn run_programmer_effects(&self, programmer: &Programmer) {
        profiling::scope!("EffectEngine::run_programmer_effects");
        let mut effects = self.programmer_effects.lock().unwrap();

        let (effects_to_be_stopped, effects_to_be_started) = {
            let mut active_effects = programmer.active_effects();
            let effects_to_be_stopped = effects
                .iter()
                .filter(|(e, _)| !active_effects.contains(e))
                .map(|(effect, id)| (effect.clone(), *id))
                .collect::<Vec<_>>();
            let effects_to_be_started = active_effects
                .filter(|e| !effects.contains_key(e))
                .cloned()
                .collect::<Vec<_>>();

            (effects_to_be_stopped, effects_to_be_started)
        };

        for (effect, instance_id) in effects_to_be_stopped {
            self.stop_effect(&instance_id);
            effects.remove(&effect);
        }
        for effect in effects_to_be_started {
            if let Some(instance_id) = self.run_effect(effect.effect_id, effect.fixtures.clone()) {
                effects.insert(effect, instance_id);
            }
        }
    }

    pub(crate) fn process_instances(&self, fixture_manager: &FixtureManager, frame: ClockFrame) {
        profiling::scope!("EffectEngine::process_instances");
        let mut instances = self.instances.lock().unwrap();
        for (_, instance) in instances.iter_mut() {
            let effect = self.effects.get(&instance.effect).unwrap();
            instance.process(effect.value(), fixture_manager, frame);
        }
        let active_effects = instances.len();
        mizer_util::plot!("Running Effects", active_effects as f64);
    }

    pub(crate) fn run_effect(
        &self,
        effect: u32,
        fixtures: Vec<FixtureId>,
    ) -> Option<EffectInstanceId> {
        profiling::scope!("EffectEngine::run_effect");
        if let Some(effect) = self.effects.get(&effect) {
            let instance = EffectInstance::new(&effect, fixtures);
            let id = EffectInstanceId::new();
            let mut instances = self.instances.lock().unwrap();
            instances.insert(id, instance);

            Some(id)
        } else {
            None
        }
    }

    pub(crate) fn stop_effect(&self, effect_instance_id: &EffectInstanceId) {
        profiling::scope!("EffectEngine::stop_effect");
        let mut instances = self.instances.lock().unwrap();
        instances.remove(effect_instance_id);
    }

    pub fn effects(&self) -> Vec<Effect> {
        self.effects
            .iter()
            .map(|element| element.value().clone())
            .collect()
    }

    pub fn clear(&self) {
        self.effects.clear();
        let mut instances = self.instances.lock().unwrap();
        instances.clear();
    }
}
