use crate::proto::mappings::{mapping_request, MappingRequest};
use crate::RuntimeApi;
use mizer_node_templates::mappings::*;
use mizer_node_templates::ExecuteNodeTemplateCommand;

#[derive(Clone)]
pub struct MappingsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> MappingsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_template(&self, mapping: MappingRequest) -> anyhow::Result<()> {
        let midi_mapping = mapping.binding.unwrap();
        let mapping_request::Binding::Midi(midi_mapping) = midi_mapping;
        let midi_config = midi_mapping.config.unwrap().into();
        let template = match mapping.action.unwrap() {
            mapping_request::Action::LayoutControl(action) => {
                create_control_mapping(action.control_node.into(), midi_config)
            }
            mapping_request::Action::SequencerGo(action) => {
                create_sequencer_go_mapping(action.sequencer_id, midi_config)
            }
            mapping_request::Action::SequencerStop(action) => {
                create_sequencer_stop_mapping(action.sequencer_id, midi_config)
            }
            mapping_request::Action::ProgrammerHighlight(_) => {
                create_programmer_highlight_mapping(midi_config)
            }
            mapping_request::Action::ProgrammerClear(_) => {
                create_programmer_clear_mapping(midi_config)
            }
        };
        let cmd = ExecuteNodeTemplateCommand { template };

        self.runtime.run_command(cmd)
    }
}
