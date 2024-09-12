use std::collections::HashMap;
use mizer_fixtures::channels::{FixtureChannel, FixtureColorChannel};
use mizer_node::*;

pub(crate) fn write_ports(
    ports: HashMap<PortId, PortMetadata>,
    context: &impl NodeContext,
    send_zero: bool,
    mut write_fader_control: impl FnMut(FixtureChannel, f64),
) {
    for port in context.input_ports() {
        if let Some(port_metadata) = ports.get(&port) {
            match port_metadata.port_type {
                PortType::Color => {
                    if let Some(value) = context.read_port::<_, Color>(port.clone()) {
                        write_fader_control(
                            FixtureChannel::ColorMixer(FixtureColorChannel::Red),
                            value.red,
                        );
                        write_fader_control(
                            FixtureChannel::ColorMixer(FixtureColorChannel::Green),
                            value.green,
                        );
                        write_fader_control(
                            FixtureChannel::ColorMixer(FixtureColorChannel::Blue),
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
                        if let Ok(channel) = FixtureChannel::try_from(port.as_str()) {
                            write_fader_control(channel, value);
                        }else {
                            tracing::warn!("Could not convert port to FixtureChannel: {}", port.as_str());
                        }
                    }
                }
                _ => unimplemented!(),
            }
        }
    }
}
