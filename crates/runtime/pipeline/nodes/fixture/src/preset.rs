use serde::{Deserialize, Serialize};

use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{Preset, PresetId};
use mizer_node::edge::Edge;
use mizer_node::*;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct PresetNode {
    pub id: PresetId,
}

impl Default for PresetNode {
    fn default() -> Self {
        Self {
            id: PresetId::Intensity(0),
        }
    }
}

impl ConfigurableNode for PresetNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let manager = injector.get::<FixtureManager>().unwrap();
        let intensities = convert_presets_to_select_variants(manager.presets.intensity_presets());
        let shutters = convert_presets_to_select_variants(manager.presets.shutter_presets());
        let colors = convert_presets_to_select_variants(manager.presets.color_presets());
        let positions = convert_presets_to_select_variants(manager.presets.position_presets());
        let presets = vec![
            SelectVariant::Group {
                label: "Intensity".to_string().into(),
                children: intensities,
            },
            SelectVariant::Group {
                label: "Shutter".to_string().into(),
                children: shutters,
            },
            SelectVariant::Group {
                label: "Color".to_string().into(),
                children: colors,
            },
            SelectVariant::Group {
                label: "Position".to_string().into(),
                children: positions,
            },
        ];

        let id = self.id.to_string();

        vec![setting!(select "Preset", id, presets).disabled()]
    }
}

impl PipelineNode for PresetNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Preset".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!("Call", PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Preset
    }
}

impl ProcessingNode for PresetNode {
    type State = Edge;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(fixture_manager) = context.inject::<FixtureManager>() {
            let mut programmer = fixture_manager.get_programmer();
            if let Some(value) = context.read_port("Call") {
                if let Some(true) = state.update(value) {
                    programmer.call_preset(&fixture_manager.presets, self.id);
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

fn convert_presets_to_select_variants<TValue>(
    presets: Vec<(PresetId, Preset<TValue>)>,
) -> Vec<SelectVariant> {
    presets
        .into_iter()
        .map(|(id, preset)| SelectVariant::Item {
            value: id.to_string().into(),
            label: preset.label.unwrap_or_else(|| id.to_string()).into(),
        })
        .collect()
}
