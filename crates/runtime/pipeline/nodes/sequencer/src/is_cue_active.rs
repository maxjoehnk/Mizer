use serde::{Deserialize, Serialize};

use mizer_node::{
    ConfigurableNode, IdVariant, Injector, NodeSetting, setting, update, update_fallback,
    NodeCategory, NodeDetails, NodeType, PipelineNode, PortId, PortMetadata,
    PortType, PreviewType, input_port, output_port, NodeContext, ProcessingNode,
};
use mizer_sequencer::Sequencer;

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct IsCueActiveNode {
    pub sequence_id: u32,
    pub cue_id: u32,
}

const ACTIVE: &str = "Active";

const SEQUENCE_SETTING: &str = "Sequence";
const CUE_SETTING: &str = "Cue";

impl ConfigurableNode for IsCueActiveNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let sequencer = injector.get::<Sequencer>().unwrap();
        let sequences = sequencer
            .sequences()
            .into_iter()
            .map(|sequence| IdVariant {
                value: sequence.id,
                label: sequence.name,
            })
            .collect();

        let cues = if let Some(sequence) = sequencer.sequence(self.sequence_id) {
            sequence
                .cues
                .iter()
                .map(|cue| IdVariant {
                    value: cue.id,
                    label: cue.name.clone(),
                })
                .collect()
        } else {
            vec![]
        };

        vec![
            setting!(id SEQUENCE_SETTING, self.sequence_id, sequences),
            setting!(id CUE_SETTING, self.cue_id, cues),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, SEQUENCE_SETTING, self.sequence_id);
        update!(id setting, CUE_SETTING, self.cue_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for IsCueActiveNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Is Cue Active".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(ACTIVE, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::IsCueActive // This will be added in a later step
    }
}

impl ProcessingNode for IsCueActiveNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(sequencer) = context.try_inject::<Sequencer>() {
            if let Some(sequence_state) = sequencer.get_sequencer_view().read().get(&self.sequence_id) {
                let is_active = sequence_state.active_cues.contains(&self.cue_id);
                context.write_port(ACTIVE, if is_active { 1.0 } else { 0.0 });
            } else {
                context.write_port(ACTIVE, 0.0); // Sequence not found or inactive
            }
        } else {
            tracing::warn!("Missing sequencer module");
            context.write_port(ACTIVE, 0.0); // Sequencer module not available
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        ()
    }
}
