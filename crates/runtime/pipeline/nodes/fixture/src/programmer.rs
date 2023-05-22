use mizer_fixtures::definition::FixtureControlValue;
use mizer_fixtures::manager::FixtureManager;
use serde::{Deserialize, Serialize};

use mizer_node::edge::Edge;
use mizer_node::*;

#[derive(Debug, Default, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub struct ProgrammerNode;

impl ConfigurableNode for ProgrammerNode {}

impl PipelineNode for ProgrammerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(ProgrammerNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!("Intensity", PortType::Single),
            input_port!("Shutter", PortType::Single),
            input_port!("Color", PortType::Color),
            input_port!("Pan", PortType::Single),
            input_port!("Tilt", PortType::Single),
            input_port!("Focus", PortType::Single),
            input_port!("Zoom", PortType::Single),
            input_port!("Prism", PortType::Single),
            input_port!("Iris", PortType::Single),
            input_port!("Frost", PortType::Single),
            input_port!("Gobo", PortType::Single),
            input_port!("Highlight", PortType::Single),
            input_port!("Clear", PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Programmer
    }
}

impl ProcessingNode for ProgrammerNode {
    type State = (Edge, Edge);

    fn process(
        &self,
        context: &impl NodeContext,
        (highlight_edge, clear_edge): &mut Self::State,
    ) -> anyhow::Result<()> {
        if let Some(fixture_manager) = context.inject::<FixtureManager>() {
            let mut programmer = fixture_manager.get_programmer();
            if let Some(intensity) = context.read_port_changes::<_, f64>("Intensity") {
                programmer.write_control(FixtureControlValue::Intensity(intensity));
            }
            if let Some(shutter) = context.read_port_changes::<_, f64>("Shutter") {
                programmer.write_control(FixtureControlValue::Shutter(shutter));
            }
            if let Some(color) = context.read_port_changes::<_, Color>("Color") {
                programmer.write_control(FixtureControlValue::ColorMixer(
                    color.red,
                    color.green,
                    color.blue,
                ));
            }
            if let Some(pan) = context.read_port_changes::<_, f64>("Pan") {
                programmer.write_control(FixtureControlValue::Pan(pan));
            }
            if let Some(tilt) = context.read_port_changes::<_, f64>("Tilt") {
                programmer.write_control(FixtureControlValue::Tilt(tilt));
            }
            if let Some(focus) = context.read_port_changes::<_, f64>("Focus") {
                programmer.write_control(FixtureControlValue::Focus(focus));
            }
            if let Some(zoom) = context.read_port_changes::<_, f64>("Zoom") {
                programmer.write_control(FixtureControlValue::Zoom(zoom));
            }
            if let Some(prism) = context.read_port_changes::<_, f64>("Prism") {
                programmer.write_control(FixtureControlValue::Prism(prism));
            }
            if let Some(iris) = context.read_port_changes::<_, f64>("Iris") {
                programmer.write_control(FixtureControlValue::Iris(iris));
            }
            if let Some(frost) = context.read_port_changes::<_, f64>("Frost") {
                programmer.write_control(FixtureControlValue::Frost(frost));
            }
            if let Some(gobo) = context.read_port_changes::<_, f64>("Gobo") {
                programmer.write_control(FixtureControlValue::Gobo(gobo));
            }
            if let Some(highlight) = context.read_port_changes::<_, f64>("Highlight") {
                if let Some(highlight) = highlight_edge.update(highlight) {
                    programmer.set_highlight(highlight);
                }
            }
            if let Some(clear) = context.read_port_changes::<_, f64>("Clear") {
                if let Some(true) = clear_edge.update(clear) {
                    programmer.clear();
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
