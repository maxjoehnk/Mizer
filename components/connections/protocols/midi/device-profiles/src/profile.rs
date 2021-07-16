use crate::scripts::outputs::OutputScript;
use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize)]
pub struct DeviceProfile {
    pub id: String,
    pub manufacturer: String,
    pub name: String,
    #[serde(default)]
    pub pages: Vec<Page>,
    pub(crate) scripts: Option<ProfileScripts>,
    #[serde(skip)]
    pub(crate) output_script: Option<OutputScript>,
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
    pub controls: Vec<Control>,
}

impl Page {
    pub fn new(name: String) -> Self {
        Page {
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
    pub channel: u8,
    pub note: u8,
    pub control_type: ControlType,
    pub has_output: bool,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
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
            channel: 1,
            note,
            control_type: ControlType::Note,
            has_output: false,
        }
    }

    pub fn cc(name: String, note: u8) -> Self {
        Control {
            id: to_id(&name),
            name,
            channel: 1,
            note,
            control_type: ControlType::ControlChange,
            has_output: false,
        }
    }

    pub fn channel(mut self, channel: u8) -> Self {
        self.channel = channel;
        self
    }

    pub fn output(mut self, id: String) -> Self {
        self.has_output = true;
        self.id = id;
        self
    }
}

fn to_id(name: &str) -> String {
    name.replace(" ", "-").to_lowercase()
}
