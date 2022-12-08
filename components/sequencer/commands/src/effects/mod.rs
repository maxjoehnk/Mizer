pub use add_effect::*;
pub use add_effect_channel::*;
pub use add_effect_step::*;
pub use delete_effect::*;
pub use delete_effect_channel::*;
pub use delete_effect_step::*;
use mizer_sequencer::{Effect, EffectChannel, EffectEngine, EffectStep};
use std::ops::{Deref, DerefMut};
pub use update_effect_step::*;

mod add_effect;
mod add_effect_channel;
mod add_effect_step;
mod delete_effect;
mod delete_effect_channel;
mod delete_effect_step;
mod update_effect_step;

pub fn get_effect_mut(
    effect_engine: &EffectEngine,
    effect_id: u32,
) -> anyhow::Result<impl Deref<Target = Effect> + DerefMut + '_> {
    effect_engine
        .effect_mut(effect_id)
        .ok_or_else(|| anyhow::anyhow!("Unknown effect {}", effect_id))
}

pub fn get_channel_mut(
    effect: &mut Effect,
    channel_index: usize,
) -> anyhow::Result<&mut EffectChannel> {
    let channel_count = effect.channels.len();

    effect.channels.get_mut(channel_index).ok_or_else(|| {
        anyhow::anyhow!(
            "Channel index out of bounds. index: {channel_index} channel_count: {channel_count}"
        )
    })
}

pub fn get_step_mut(
    channel: &mut EffectChannel,
    step_index: usize,
) -> anyhow::Result<&mut EffectStep> {
    let step_count = channel.steps.len();
    channel.steps.get_mut(step_index).ok_or_else(|| {
        anyhow::anyhow!("Step index out of bounds. index: {step_index} step_count: {step_count}",)
    })
}
