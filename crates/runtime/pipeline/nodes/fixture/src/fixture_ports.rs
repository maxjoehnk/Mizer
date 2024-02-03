use std::collections::HashMap;

use mizer_fixtures::definition::{
    ColorChannel, FixtureControl, FixtureControlType, FixtureFaderControl,
};
use mizer_node::*;

pub(crate) fn write_ports(
    ports: HashMap<PortId, PortMetadata>,
    context: &impl NodeContext,
    send_zero: bool,
    mut write_fader_control: impl FnMut(FixtureFaderControl, f64),
) {
    for port in context.input_ports() {
        if let Some(port_metadata) = ports.get(&port) {
            match port_metadata.port_type {
                PortType::Color => {
                    if let Some(value) = context.read_port::<_, Color>(port.clone()) {
                        write_fader_control(
                            FixtureFaderControl::ColorMixer(ColorChannel::Red),
                            value.red,
                        );
                        write_fader_control(
                            FixtureFaderControl::ColorMixer(ColorChannel::Green),
                            value.green,
                        );
                        write_fader_control(
                            FixtureFaderControl::ColorMixer(ColorChannel::Blue),
                            value.blue,
                        );
                    }
                }
                PortType::Single => {
                    if let Some(value) = context.read_port(port.clone()) {
                        let is_zero = value < f64::EPSILON && value > -f64::EPSILON;
                        if is_zero && !send_zero {
                            continue;
                        }
                        let control = FixtureControl::from(port.as_str());
                        write_fader_control(control.try_into().unwrap(), value);
                    }
                }
                _ => unimplemented!(),
            }
        }
    }
}

pub(crate) trait FixtureControlPorts {
    fn get_ports(self) -> Vec<(PortId, PortMetadata)>;
}

impl FixtureControlPorts for Vec<(FixtureControl, FixtureControlType)> {
    fn get_ports(self) -> Vec<(PortId, PortMetadata)> {
        self.into_iter()
            .map(|(name, control_type)| {
                input_port!(
                    name.to_string(),
                    if control_type == FixtureControlType::Color {
                        PortType::Color
                    } else {
                        PortType::Single
                    }
                )
            })
            .collect()
    }
}
