use std::convert::TryInto;
use std::sync::Arc;

use serde::{Deserialize, Serialize};

use mizer_midi_messages::{Channel, MidiMessage};

use crate::scripts::outputs::{Color, OutputEngine, OutputScript};

#[derive(Clone, Deserialize, Serialize)]
pub struct DeviceProfile {
    pub id: String,
    pub manufacturer: String,
    pub name: String,
    /// Keyword to detect the device by
    pub keyword: String,
    #[serde(default)]
    pub pages: Vec<Page>,
    pub(crate) scripts: Option<ProfileScripts>,
    #[serde(skip)]
    pub(crate) output_script: Option<OutputScript>,
    #[serde(rename = "layout")]
    pub(crate) layout_file: Option<String>,
    #[serde(skip)]
    pub layout: Option<String>,
    #[serde(default, skip)]
    pub(crate) engine: OutputEngine,
}

impl DeviceProfile {
    pub fn matches(&self, name: &str) -> bool {
        name.contains(&self.keyword)
    }

    pub fn get_control(&self, page: &str, control: &str) -> Option<&Control> {
        let page = self.pages.iter().find(|p| p.name == page);

        page.and_then(|page| page.all_controls().find(|c| c.id.as_str() == control))
    }

    pub fn write_rgb(&self, control: &Control, color: (f64, f64, f64)) -> Option<MidiMessage> {
        let script = self.output_script.as_ref()?;

        match script.write_rgb(&self.engine, control, Color(color)) {
            Ok(msg) => Some(msg),
            Err(err) => {
                log::error!("Unable to write rgb to control {control:?}: {err:?}");
                None
            }
        }
    }
}

impl std::fmt::Debug for DeviceProfile {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("DeviceProfile")
            .field("id", &self.id)
            .field("manufacturer", &self.manufacturer)
            .field("name", &self.name)
            .field("pages", &self.pages)
            .finish()
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub(crate) struct ProfileScripts {
    pub pages: Option<String>,
    pub outputs: Option<String>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Page {
    pub name: String,
    #[serde(default)]
    pub groups: Vec<Group>,
    #[serde(default)]
    pub controls: Vec<Control>,
}

impl Page {
    pub fn new(name: String) -> Self {
        Page {
            name,
            groups: Default::default(),
            controls: Default::default(),
        }
    }

    pub fn add_group(&mut self, group: Group) {
        self.groups.push(group);
    }

    pub fn add_control(&mut self, control: Control) {
        self.controls.push(control);
    }

    pub fn all_controls(&self) -> impl Iterator<Item = &Control> {
        let controls = self.controls.iter();
        let grouped_controls = self.groups.iter().flat_map(|g| g.controls.iter());

        controls.chain(grouped_controls)
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Group {
    pub name: Arc<String>,
    pub controls: Vec<Control>,
}

impl Group {
    pub fn new(name: String) -> Self {
        Self {
            name: Arc::new(name),
            controls: Default::default(),
        }
    }

    pub fn add_control(&mut self, control: Control) {
        self.controls.push(control);
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Control {
    pub id: Arc<String>,
    pub name: Arc<String>,
    pub input: Option<DeviceControl>,
    pub output: Option<DeviceControl>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub enum DeviceControl {
    MidiNote(MidiDeviceControl),
    MidiCC(MidiDeviceControl),
    RGBSysEx(String),
}

impl DeviceControl {
    pub fn midi_device_control(self) -> Option<MidiDeviceControl> {
        match self {
            DeviceControl::MidiCC(control) | DeviceControl::MidiNote(control) => Some(control),
            _ => None,
        }
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct MidiDeviceControl {
    pub channel: Channel,
    pub note: u8,
    pub range: (u8, u8),
    pub steps: Option<Vec<ControlStep>>,
}

impl Control {
    pub fn new(name: String) -> Self {
        Self {
            id: Arc::new(to_id(&name)),
            name: Arc::new(name),
            input: None,
            output: None,
        }
    }

    pub fn id(mut self, id: String) -> Self {
        self.id = Arc::new(id);
        self
    }

    pub fn input(self) -> ControlBuilder {
        match self.output.clone() {
            Some(DeviceControl::MidiNote(control)) => ControlBuilder {
                control: self,
                input: true,
                control_type: ControlType::Note,
                channel: control.channel,
                note: control.note,
                range: control.range,
                steps: Default::default(),
            },
            Some(DeviceControl::MidiCC(control)) => ControlBuilder {
                control: self,
                input: true,
                control_type: ControlType::ControlChange,
                channel: control.channel,
                note: control.note,
                range: control.range,
                steps: Default::default(),
            },
            _ => ControlBuilder {
                control: self,
                input: true,
                channel: Default::default(),
                note: Default::default(),
                range: (0, 255),
                control_type: Default::default(),
                steps: Default::default(),
            },
        }
    }

    pub fn output(self) -> ControlBuilder {
        match self.input.clone() {
            Some(DeviceControl::MidiNote(control)) => ControlBuilder {
                control: self,
                input: false,
                control_type: ControlType::Note,
                channel: control.channel,
                note: control.note,
                range: control.range,
                steps: Default::default(),
            },
            Some(DeviceControl::MidiCC(control)) => ControlBuilder {
                control: self,
                input: false,
                control_type: ControlType::ControlChange,
                channel: control.channel,
                note: control.note,
                range: control.range,
                steps: Default::default(),
            },
            _ => ControlBuilder {
                control: self,
                input: false,
                channel: Default::default(),
                note: Default::default(),
                range: (0, 255),
                control_type: Default::default(),
                steps: Default::default(),
            },
        }
    }
}

#[derive(Debug, Clone)]
pub struct ControlBuilder {
    input: bool,
    control: Control,
    pub channel: Channel,
    pub note: u8,
    pub range: (u8, u8),
    pub control_type: ControlType,
    pub steps: Vec<ControlStep>,
}

#[derive(Debug, Default, Clone, PartialEq, Eq)]
pub enum ControlType {
    #[default]
    Note,
    ControlChange,
    Rgb(String),
}

impl ControlBuilder {
    pub fn rgb(mut self, name: String) -> Self {
        self.control_type = ControlType::Rgb(name);
        self
    }

    pub fn note(mut self, note: u8) -> Self {
        self.note = note;
        self.control_type = ControlType::Note;
        self
    }

    pub fn cc(mut self, note: u8) -> Self {
        self.note = note;
        self.control_type = ControlType::ControlChange;
        self
    }

    pub fn channel(mut self, channel: u8) -> Self {
        self.channel = channel.try_into().expect("Invalid midi channel");
        self
    }

    pub fn range(mut self, from: u8, to: u8) -> Self {
        self.range = (from, to);
        self
    }

    pub fn build(mut self) -> Control {
        let control = if let ControlType::Rgb(name) = self.control_type {
            DeviceControl::RGBSysEx(name)
        } else {
            let control = MidiDeviceControl {
                note: self.note,
                range: self.range,
                channel: self.channel,
                steps: if self.steps.is_empty() {
                    None
                } else {
                    Some(self.steps)
                },
            };
            if self.control_type == ControlType::Note {
                DeviceControl::MidiNote(control)
            } else {
                DeviceControl::MidiCC(control)
            }
        };
        if self.input {
            self.control.input = Some(control);
        } else {
            self.control.output = Some(control);
        }

        self.control
    }
}

#[derive(Default, Debug, Clone)]
pub struct StepsBuilder {
    steps: Vec<ControlStepVariant>,
}

impl StepsBuilder {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn add(&mut self, step: ControlStepVariant) {
        self.steps.push(step);
    }

    pub fn build(self) -> Vec<ControlStepVariant> {
        self.steps
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub enum ControlStep {
    Single(ControlStepVariant),
    Group {
        label: Arc<String>,
        steps: Vec<ControlStepVariant>,
    },
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ControlStepVariant {
    pub label: Arc<String>,
    pub value: u8,
}

fn to_id(name: &str) -> String {
    name.replace(' ', "-").to_lowercase()
}
