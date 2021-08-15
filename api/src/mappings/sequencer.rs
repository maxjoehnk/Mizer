use crate::models::*;

impl From<mizer_sequencer::Sequence> for Sequence {
    fn from(sequence: mizer_sequencer::Sequence) -> Self {
        Self {
            id: sequence.id,
            name: sequence.name,
            cues: sequence.cues.into_iter().map(Cue::from).collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::Cue> for Cue {
    fn from(cue: mizer_sequencer::Cue) -> Self {
        Self {
            id: cue.id,
            name: cue.name,
            trigger: cue.trigger.into(),
            field_loop: false,
            channels: cue.channels.into_iter().map(CueChannel::from).collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_sequencer::CueTrigger> for CueTrigger {
    fn from(trigger: mizer_sequencer::CueTrigger) -> Self {
        use mizer_sequencer::CueTrigger::*;

        match trigger {
            Go => CueTrigger::GO,
            Follow => CueTrigger::FOLLOW,
            Beats => CueTrigger::BEATS,
            Timecode => CueTrigger::TIMECODE,
        }
    }
}

impl From<mizer_sequencer::CueChannel> for CueChannel {
    fn from(channel: mizer_sequencer::CueChannel) -> Self {
        Self {
            // fixture: channel.fixture_id,
            channel: channel.channel,
            ..Default::default()
        }
    }
}
