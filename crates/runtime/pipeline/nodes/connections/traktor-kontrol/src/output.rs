use serde::{Deserialize, Serialize};

use mizer_devices::DeviceManager;
use mizer_node::*;
use mizer_traktor_kontrol_x1::*;

use crate::{ConvertVariant, X1InjectorExt};

const VALUE_PORT: &str = "Value";

const DEVICE_SETTING: &str = "Device";
const ELEMENT_SETTING: &str = "Input";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct TraktorKontrolX1OutputNode {
    #[serde(rename = "device")]
    pub device_id: String,
    pub element: String,
}

impl ConfigurableNode for TraktorKontrolX1OutputNode {
    fn settings(&self, injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        let devices = injector.get_devices();
        let elements = Button::list_variants("");

        vec![
            setting!(select DEVICE_SETTING, &self.device_id, devices),
            setting!(select ELEMENT_SETTING, &self.element, elements),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device_id);
        update!(select setting, ELEMENT_SETTING, self.element);

        update_fallback!(setting)
    }
}

impl PipelineNode for TraktorKontrolX1OutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Traktor Kontrol X1 Output".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(VALUE_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TraktorKontrolX1Output
    }
}

impl ProcessingNode for TraktorKontrolX1OutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if self.device_id.is_empty() || self.element.is_empty() {
            return Ok(());
        }
        if let Some(device_manager) = context.try_inject::<DeviceManager>() {
            if let Some(x1) = device_manager.get_x1_mut(&self.device_id) {
                let button = Button::try_from_str(&self.element)?;
                if let Some(value) = context.single_input(VALUE_PORT).read_changes() {
                    x1.write_led(button, value)?;
                    context.push_history_value(value);
                }
            }
        } else {
            anyhow::bail!("Traktor Kontrol X1 Output node is missing DeviceManager");
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
