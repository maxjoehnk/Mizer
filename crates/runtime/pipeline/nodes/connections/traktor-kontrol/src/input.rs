use std::sync::Arc;

use serde::{Deserialize, Serialize};
use mizer_connections::ConnectionStorage;
use mizer_node::*;
use mizer_traktor_kontrol_x1::*;

use crate::{ConvertVariant, X1InjectorExt};

const VALUE_PORT: &str = "Value";

const DEVICE_SETTING: &str = "Device";
const ELEMENT_SETTING: &str = "Element";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct TraktorKontrolX1InputNode {
    #[serde(rename = "device")]
    pub device_id: String,
    pub element: String,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Element {
    Button(Button),
    Knob(Knob),
    Encoder(Encoder),
}

impl ConvertVariant for Element {
    fn to_id_with_prefix(&self, prefix: &str) -> String {
        match self {
            Element::Button(button) => button.to_id_with_prefix(&format!("{prefix}button-")),
            Element::Knob(knob) => knob.to_id_with_prefix(&format!("{prefix}knob-")),
            Element::Encoder(encoder) => encoder.to_id_with_prefix(&format!("{prefix}encoder-")),
        }
    }

    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self> {
        match variant {
            ["button", tail @ ..] => Ok(Element::Button(Button::try_from_id(tail)?)),
            ["knob", tail @ ..] => Ok(Element::Knob(Knob::try_from_id(tail)?)),
            ["encoder", tail @ ..] => Ok(Element::Encoder(Encoder::try_from_id(tail)?)),
            _ => anyhow::bail!("Invalid variant"),
        }
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant> {
        vec![
            SelectVariant::Group {
                label: arc("Buttons"),
                children: Button::list_variants(&format!("{prefix}button-")),
            },
            SelectVariant::Group {
                label: arc("Knobs"),
                children: Knob::list_variants(&format!("{prefix}knob-")),
            },
            SelectVariant::Group {
                label: arc("Encoders"),
                children: Encoder::list_variants(&format!("{prefix}encoder-")),
            },
        ]
    }
}

impl ConfigurableNode for TraktorKontrolX1InputNode {
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let devices = injector.get_devices();
        let elements = Element::list_variants("");

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

impl PipelineNode for TraktorKontrolX1InputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Traktor Kontrol X1 Input".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TraktorKontrolX1Input
    }
}

impl ProcessingNode for TraktorKontrolX1InputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if self.device_id.is_empty() || self.element.is_empty() {
            return Ok(());
        }
        let connection_storage = context.inject::<ConnectionStorage>();
        let id = self.device_id.parse()?;
        if let Some(x1) = connection_storage.get_connection_by_stable::<TraktorX1Ref>(&id) {
            let element = Element::try_from_str(&self.element)?;
            let value: Option<f32> = match element {
                Element::Button(button) => {
                    x1.is_button_pressed(button).then_some(1.).or(Some(0.))
                }
                Element::Knob(knob) => x1.read_knob(knob).map(|value| value as f32 / 4090.),
                _ => todo!(),
            };
            if let Some(value) = value {
                let value = value as f64;
                context.write_port(VALUE_PORT, value);
                context.push_history_value(value);
            }
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

fn arc(text: impl ToString) -> Arc<String> {
    Arc::new(text.to_string())
}
