use std::collections::HashMap;
use dashmap::DashMap;
use super::Effect;
use crate::effects::default_effects::CIRCLE;
use std::sync::{Arc, Mutex};
use crate::effects::instance::EffectInstance;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixtureId;
use mizer_module::ClockFrame;

#[derive(Default, Clone)]
pub struct EffectEngine {
    pub effects: Arc<DashMap<u32, Effect>>,
    instances: Arc<Mutex<HashMap<EffectInstanceId, EffectInstance>>>
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

    #[profiling::function]
    pub(crate) fn process_instances(&self, fixture_manager: &FixtureManager, frame: ClockFrame) {
        let mut instances = self.instances.lock().unwrap();
        for (_, instance) in instances.iter_mut() {
            let effect = self.effects.get(&instance.effect).unwrap();
            instance.process(effect.value(), fixture_manager, frame);
        }
    }

    #[profiling::function]
    pub(crate) fn run_effect(&self, effect: u32, fixtures: Vec<FixtureId>) -> Option<EffectInstanceId> {
        if let Some(effect) = self.effects.get(&effect) {
            let instance = EffectInstance::new(&effect, fixtures);
            let id = EffectInstanceId::new();
            let mut instances = self.instances.lock().unwrap();
            instances.insert(id, instance);

            Some(id)
        }else {
            None
        }
    }

    #[profiling::function]
    pub(crate) fn stop_effect(&self, effect_instance_id: &EffectInstanceId) {
        let mut instances = self.instances.lock().unwrap();
        instances.remove(effect_instance_id);
    }

    pub fn effects(&self) -> Vec<Effect> {
        self.effects.iter().map(|element| element.value().clone()).collect()
    }

    pub fn clear(&self) {
        self.effects.clear();
        let mut instances = self.instances.lock().unwrap();
        instances.clear();
    }
}
