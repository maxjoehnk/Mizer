use crate::scripts::outputs::OutputScript;
use mizer_midi_messages::Channel;
use serde::{Deserialize, Serialize};
use std::convert::TryInto;

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
}

impl DeviceProfile {
    pub fn matches(&self, name: &str) -> bool {
        name.contains(&self.keyword)
    }

    pub fn get_control(&self, page: &str, control: &str) -> Option<Control> {
        let page = self.pages.iter().find(|p| p.name == page);
        let control = page.and_then(|page| page.all_controls().find(|c| c.id == control).cloned());

        control
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
    pub name: String,
    pub controls: Vec<Control>,
}

impl Group {
    pub fn new(name: String) -> Self {
        Self {
            name,
            controls: Default::default(),
        }
    }

    pub fn add_control(&mut self, control: Control) {
        self.controls.push(control);
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Control {
    pub id: String,
    pub name: String,
    pub channel: Channel,
    pub note: u8,
    pub control_type: ControlType,
    pub range: (u8, u8),
    pub has_output: bool,
    pub output_range: (u8, u8),
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub enum ControlType {
    #[serde(rename = "note")]
    Note,
    #[serde(rename = "cc")]
    ControlChange,
}

impl Control {
    pub fn note(name: String, note: u8) -> Self {
        Control {
            id: to_id(&name),
            name,
            channel: Default::default(),
            note,
            control_type: ControlType::Note,
            has_output: false,
            range: (0, 255),
            output_range: (0, 255),
        }
    }

    pub fn cc(name: String, note: u8) -> Self {
        Control {
            id: to_id(&name),
            name,
            channel: Default::default(),
            note,
            control_type: ControlType::ControlChange,
            has_output: false,
            range: (0, 255),
            output_range: (0, 255),
        }
    }

    pub fn channel(mut self, channel: u8) -> Self {
        self.channel = channel.try_into().expect("Invalid midi channel");
        self
    }

    pub fn range(mut self, from: u8, to: u8) -> Self {
        self.range = (from, to);
        self
    }

    pub fn id(mut self, id: String) -> Self {
        self.id = id;
        self
    }

    pub fn output(mut self) -> Self {
        self.has_output = true;
        self
    }

    pub fn output_range(mut self, from: u8, to: u8) -> Self {
        self.output_range = (from, to);
        self
    }
}

fn to_id(name: &str) -> String {
    name.replace(" ", "-").to_lowercase()
}
