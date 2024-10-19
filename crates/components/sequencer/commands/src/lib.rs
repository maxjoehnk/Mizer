pub use add_sequence::*;
pub use delete_sequence::*;
pub use duplicate_sequence::*;
pub use effects::*;
use mizer_sequencer::{Cue, CueControl, CueEffect, Sequence};
pub use rename_cue::*;
pub use rename_sequence::*;
pub use stop_sequence::*;
pub use store_programmer_in_sequence::*;
pub use update_control_delay_time::*;
pub use update_control_fade_time::*;
pub use update_cue_effect_offset::*;
pub use update_cue_trigger::*;
pub use update_cue_trigger_time::*;
pub use update_cue_value::*;
pub use update_priority::*;
pub use update_stop_on_last_cue::*;
pub use update_wrap_around::*;

mod add_sequence;
mod delete_sequence;
mod duplicate_sequence;
mod effects;
mod rename_cue;
mod rename_sequence;
mod stop_sequence;
mod store_programmer_in_sequence;
mod update_control_delay_time;
mod update_control_fade_time;
mod update_cue_effect_offset;
mod update_cue_trigger;
mod update_cue_trigger_time;
mod update_cue_value;
mod update_priority;
mod update_stop_on_last_cue;
mod update_wrap_around;

fn get_cue(sequence: &mut Sequence, cue_id: u32) -> anyhow::Result<&mut Cue> {
    sequence
        .cues
        .iter_mut()
        .find(|cue| cue.id == cue_id)
        .ok_or_else(|| anyhow::anyhow!("Unknown Cue {}", cue_id))
}

fn get_control(
    sequence: &mut Sequence,
    cue_id: u32,
    control_index: u32,
) -> anyhow::Result<&mut CueControl> {
    let cue = get_cue(sequence, cue_id)?;
    cue.controls
        .get_mut(control_index as usize)
        .ok_or_else(|| anyhow::anyhow!("Control index out of bounds {}", control_index))
}

fn get_effect(cue: &mut Cue, effect_id: u32) -> anyhow::Result<&mut CueEffect> {
    cue.effects
        .iter_mut()
        .find(|effect| effect.effect == effect_id)
        .ok_or_else(|| anyhow::anyhow!("Unknown Effect {}", effect_id))
}
