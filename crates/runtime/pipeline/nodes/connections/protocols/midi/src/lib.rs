use std::fmt::{Display, Formatter};

use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_node::{Injector, SelectVariant};
use mizer_protocol_midi::{ControlStep, MidiConnectionManager};

pub use self::input::{MidiInputConfig, MidiInputNode};
pub use self::output::{MidiOutputConfig, MidiOutputNode};

mod input;
mod output;

#[derive(
    Clone, Debug, Serialize, Deserialize, PartialEq, Eq, Sequence, TryFromPrimitive, IntoPrimitive,
)]
#[repr(u8)]
pub enum NoteMode {
    CC,
    Note,
}

impl Display for NoteMode {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

fn get_devices(injector: &Injector) -> Vec<SelectVariant> {
    let connection_manager = injector.get::<MidiConnectionManager>().unwrap();
    let devices = connection_manager.list_available_devices();

    devices
        .into_iter()
        .map(|device| SelectVariant::from(device.name))
        .collect()
}

fn get_pages_and_controls(
    injector: &Injector,
    device: &str,
    page_name: &str,
    control_name: &str,
    input: bool,
) -> (
    Vec<SelectVariant>,
    Vec<SelectVariant>,
    Option<Vec<SelectVariant>>,
) {
    let connection_manager = injector.get::<MidiConnectionManager>().unwrap();
    let pages = connection_manager
        .request_device(device)
        .ok()
        .flatten()
        .and_then(|device| device.profile.clone())
        .map(|profile| profile.pages)
        .unwrap_or_default();
    let page = pages.iter().find(|p| p.name == page_name).cloned();
    let pages = pages
        .into_iter()
        .map(|p| SelectVariant::from(p.name))
        .collect();
    let controls = page
        .clone()
        .map(|p| {
            let groups = p
                .groups
                .into_iter()
                .map(|g| SelectVariant::Group {
                    label: g.name,
                    children: g
                        .controls
                        .into_iter()
                        .filter(|c| {
                            if input {
                                c.input.is_some()
                            } else {
                                c.output.is_some()
                            }
                        })
                        .map(|c| SelectVariant::Item {
                            label: c.name,
                            value: c.id,
                        })
                        .collect(),
                })
                .filter(|g| {
                    if let SelectVariant::Group { children, .. } = g {
                        !children.is_empty()
                    } else {
                        true
                    }
                });
            let controls = p
                .controls
                .into_iter()
                .filter(|c| {
                    if input {
                        c.input.is_some()
                    } else {
                        c.output.is_some()
                    }
                })
                .map(|c| SelectVariant::Item {
                    label: c.name,
                    value: c.id,
                });

            groups.chain(controls).collect()
        })
        .unwrap_or_default();
    let steps = page
        .and_then(|page| page.all_controls().find(|c| c.id.as_str() == control_name).cloned())
        .and_then(|control| if input { control.input } else { control.output })
        .and_then(|control| control.midi_device_control())
        .and_then(|control| control.steps)
        .map(|steps| {
            steps
                .into_iter()
                .map(|s| match s {
                    ControlStep::Single(variant) => SelectVariant::Item {
                        value: variant.value.to_string().into(),
                        label: variant.label,
                    },
                    ControlStep::Group { label, steps } => SelectVariant::Group {
                        label,
                        children: steps
                            .into_iter()
                            .map(|variant| SelectVariant::Item {
                                value: variant.value.to_string().into(),
                                label: variant.label,
                            })
                            .collect(),
                    },
                })
                .collect()
        });

    (pages, controls, steps)
}
