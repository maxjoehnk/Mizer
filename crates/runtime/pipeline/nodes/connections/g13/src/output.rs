use mizer_connections::ConnectionStorage;
use mizer_node::*;
use serde::{Deserialize, Serialize};
use mizer_g13::G13Ref;
use crate::G13InjectorExt;

const KEY_COLOR: &str = "Key Color";
const M1: &str = "M1";
const M2: &str = "M2";
const M3: &str = "M3";
const MR: &str = "MR";

const DEVICE_SETTING: &str = "Device";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct G13OutputNode {
    #[serde(rename = "device")]
    pub device_id: String,
}

impl ConfigurableNode for G13OutputNode {
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let devices = injector.get_devices();

        vec![setting!(select DEVICE_SETTING, &self.device_id, devices)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for G13OutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "G13 Output".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(KEY_COLOR, PortType::Color),
            input_port!(M1, PortType::Single),
            input_port!(M2, PortType::Single),
            input_port!(M3, PortType::Single),
            input_port!(MR, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::G13Output
    }
}

impl ProcessingNode for G13OutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if self.device_id.is_empty() {
            return Ok(());
        }
        let connection_storage = context.inject::<ConnectionStorage>();
        let id = self.device_id.parse()?;
        if let Some(g13) = connection_storage.get_connection_by_stable::<G13Ref>(&id) {
            if let Some(color) = context.read_port::<_, Color>(KEY_COLOR) {
                g13.write_key_color(color.red, color.green, color.blue)?;
            }
            let m1 = context
                .read_port::<_, f64>(M1)
                .map(|value| value > 0.)
                .unwrap_or_default();
            let m2 = context
                .read_port::<_, f64>(M2)
                .map(|value| value > 0.)
                .unwrap_or_default();
            let m3 = context
                .read_port::<_, f64>(M3)
                .map(|value| value > 0.)
                .unwrap_or_default();
            let mr = context
                .read_port::<_, f64>(MR)
                .map(|value| value > 0.)
                .unwrap_or_default();

            g13.set_key_state(m1, m2, m3, mr)?;
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
