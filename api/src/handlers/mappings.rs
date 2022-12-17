use crate::models::{MappingRequest, MappingRequest_oneof_action, MappingRequest_oneof_binding};
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

    pub fn add_template(&self, mapping: MappingRequest) {
        let midi_mapping = mapping.binding.unwrap();
        let MappingRequest_oneof_binding::midi(midi_mapping) = midi_mapping;
        let midi_config = midi_mapping.config.unwrap().into();
        let template = match mapping.action.unwrap() {
            MappingRequest_oneof_action::layout_control(action) => {
                create_control_mapping(action.control_node.into(), midi_config)
            }
            MappingRequest_oneof_action::sequencer_go(action) => {
                create_sequencer_go_mapping(action.sequencer_id, midi_config)
            }
            MappingRequest_oneof_action::sequencer_stop(action) => {
                create_sequencer_stop_mapping(action.sequencer_id, midi_config)
            }
            MappingRequest_oneof_action::programmer_highlight(_) => {
                create_programmer_highlight_mapping(midi_config)
            }
            MappingRequest_oneof_action::programmer_clear(_) => {
                create_programmer_clear_mapping(midi_config)
            }
        };
        let cmd = ExecuteNodeTemplateCommand { template };

        self.runtime.run_command(cmd).unwrap();
    }
}
