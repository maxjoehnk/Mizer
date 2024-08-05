use std::convert::TryInto;
use std::fmt::{Display, Formatter};
use std::path::PathBuf;
use std::sync::Arc;

use serde::{Deserialize, Serialize};

use mizer_midi_messages::{Channel, MidiMessage};
use mizer_util::{ErrorCollector, LerpExt};

use crate::scripts::outputs::{Color, OutputEngine, OutputScript};

#[derive(Clone)]
pub struct DeviceProfile {
    pub id: String,
    pub manufacturer: String,
    pub name: String,
    /// Keyword to detect the device by
    pub keyword: Option<String>,
    pub pages: Vec<Page>,
    pub(crate) output_script: Option<OutputScript>,
    pub layout: Option<String>,
    pub(crate) engine: OutputEngine,
    pub errors: ErrorCollector<ProfileErrors>,
    pub file_path: PathBuf,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ControlGrid {
    rows: u32,
    columns: u32,
    pub grid: Vec<Control>,
}

impl ControlGrid {
    pub fn rows(&self) -> u32 {
        self.rows
    }

    pub fn cols(&self) -> u32 {
        self.columns
    }

    fn view(&self, min_x: u32, min_y: u32, columns: u32, rows: u32) -> GridRef {
        let max_x = min_x + columns;
        let max_y = min_y + rows;
        GridRef(
            self.grid
                .iter()
                .enumerate()
                .filter(|(i, _c)| {
                    let i = *i;
                    let x = i as u32 % self.columns;
                    let y = i as u32 / self.columns;

                    (x >= min_x && x < max_x) && (y >= min_y && y < max_y)
                })
                .map(|(_i, c)| c)
                .collect(),
        )
    }
}

#[derive(Clone, Deserialize, Serialize)]
pub(crate) struct DeviceProfileConfig {
    pub id: String,
    pub manufacturer: String,
    pub name: String,
    /// Keyword to detect the device by
    #[serde(default)]
    pub keyword: Option<String>,
    #[serde(default)]
    pub pages: Vec<Page>,
    pub(crate) scripts: Option<ProfileScripts>,
    #[serde(rename = "layout")]
    pub(crate) layout_file: Option<String>,
}

#[derive(Debug, Clone)]
pub enum ProfileErrors {
    PagesLoadingError(String),
    OutputScriptLoadingError(String),
    OutputScriptWritingError(String),
    LayoutLoadingError(String),
}

impl Display for ProfileErrors {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            ProfileErrors::PagesLoadingError(err) => write!(f, "Pages loading error: {}", err),
            ProfileErrors::OutputScriptLoadingError(err) => {
                write!(f, "Output script loading error: {}", err)
            }
            ProfileErrors::OutputScriptWritingError(err) => {
                write!(f, "Output script writing error: {}", err)
            }
            ProfileErrors::LayoutLoadingError(err) => write!(f, "Layout loading error: {}", err),
        }
    }
}

pub struct GridRef<'a>(Vec<&'a Control>);

impl<'a> GridRef<'a> {
    pub fn controls(&self) -> impl Iterator<Item = &Control> {
        self.0.iter().copied()
    }

    pub fn len(&self) -> usize {
        self.0.len()
    }

    pub fn write(
        &self,
        values: &[f64],
        on_step: Option<u8>,
        off_step: Option<u8>,
    ) -> Vec<MidiMessage> {
        self.0
            .iter()
            .zip(values.iter())
            .filter_map(|(control, value)| control.send_value(*value, on_step, off_step))
            .collect()
    }
}

impl DeviceProfile {
    pub fn matches(&self, name: &str) -> bool {
        if let Some(keyword) = &self.keyword {
            name.contains(keyword)
        } else {
            false
        }
    }

    pub fn get_grid(&self, page: &str, x: u32, y: u32, columns: u32, rows: u32) -> Option<GridRef> {
        tracing::trace!(
            "Getting grid for page {page} at {x}, {y} with {columns} columns and {rows} rows"
        );

        let page = self.pages.iter().find(|p| p.name == page)?;
        let grid = page.grid.as_ref()?;

        Some(grid.view(x, y, columns, rows))
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
                // TODO: Report write_rgb script errors back
                // self.errors.push(ProfileErrors::OutputScriptWritingError(err.to_string()));
                tracing::error!("Unable to write rgb to control {control:?}: {err:?}");
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
    #[serde(default)]
    pub grid: Option<ControlGrid>,
}

impl Page {
    pub fn new(name: String) -> Self {
        Page {
            name,
            groups: Default::default(),
            controls: Default::default(),
            grid: Default::default(),
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

    pub fn define_grid(
        &mut self,
        rows: u32,
        columns: u32,
        get_control_id: impl Fn(u32, u32) -> String,
    ) {
        let get_id = &get_control_id;
        let grid = ControlGrid {
            rows,
            columns,
            grid: (0..rows)
                .flat_map(|y| (0..columns).map(move |x| get_id(x, y)))
                .filter_map(|id| self.all_controls().find(|c| c.id.as_str() == id).cloned())
                .collect(),
        };
        self.grid = Some(grid);
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
    pub range: (u16, u16),
    pub steps: Option<Vec<ControlStep>>,
    pub resolution: MidiResolution,
}

#[derive(Debug, Default, Clone, Deserialize, Serialize)]
pub enum MidiResolution {
    #[default]
    // 7-Bit
    Default,
    // 14-Bit
    HighRes,
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
                range: None,
                steps: Default::default(),
                resolution: Default::default(),
            },
            Some(DeviceControl::MidiCC(control)) => ControlBuilder {
                control: self,
                input: true,
                control_type: ControlType::ControlChange,
                channel: control.channel,
                note: control.note,
                range: None,
                steps: Default::default(),
                resolution: Default::default(),
            },
            _ => ControlBuilder {
                control: self,
                input: true,
                channel: Default::default(),
                note: Default::default(),
                range: None,
                control_type: Default::default(),
                steps: Default::default(),
                resolution: Default::default(),
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
                range: None,
                steps: Default::default(),
                resolution: Default::default(),
            },
            Some(DeviceControl::MidiCC(control)) => ControlBuilder {
                control: self,
                input: false,
                control_type: ControlType::ControlChange,
                channel: control.channel,
                note: control.note,
                range: None,
                steps: Default::default(),
                resolution: Default::default(),
            },
            _ => ControlBuilder {
                control: self,
                input: false,
                channel: Default::default(),
                note: Default::default(),
                range: None,
                control_type: Default::default(),
                steps: Default::default(),
                resolution: Default::default(),
            },
        }
    }

    pub fn send_value(
        &self,
        value: f64,
        on_step: Option<u8>,
        off_step: Option<u8>,
    ) -> Option<MidiMessage> {
        match self.output {
            Some(DeviceControl::MidiNote(MidiDeviceControl {
                channel,
                note,
                range,
                ..
            })) => Some(MidiMessage::NoteOn(
                channel,
                note,
                convert_value(value, range, on_step, off_step),
            )),
            Some(DeviceControl::MidiCC(MidiDeviceControl {
                channel,
                note,
                range,
                ..
            })) => Some(MidiMessage::ControlChange(
                channel,
                note,
                convert_value(value, range, on_step, off_step),
            )),
            _ => None,
        }
    }
}

fn convert_value(value: f64, range: (u16, u16), on_step: Option<u8>, off_step: Option<u8>) -> u8 {
    if let Some(on_step) = on_step {
        if value > 0f64 + f64::EPSILON {
            return on_step;
        }
    }
    if let Some(off_step) = off_step {
        if value > 0f64 - f64::EPSILON && value < 0f64 + f64::EPSILON {
            return off_step;
        }
    }

    value.linear_extrapolate(
        (0f64, 1f64),
        (
            range.0.min(u8::MAX as u16) as u8,
            range.1.min(u8::MAX as u16) as u8,
        ),
    )
}

#[derive(Debug, Clone)]
pub struct ControlBuilder {
    input: bool,
    control: Control,
    pub channel: Channel,
    pub note: u8,
    pub range: Option<(u16, u16)>,
    pub control_type: ControlType,
    pub steps: Vec<ControlStep>,
    pub resolution: MidiResolution,
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

    pub fn range(mut self, from: u16, to: u16) -> Self {
        self.range = Some((from, to));
        self
    }

    pub fn resolution(mut self, resolution: MidiResolution) -> Self {
        self.resolution = resolution;
        self
    }

    pub fn build(mut self) -> Control {
        let control = if let ControlType::Rgb(name) = self.control_type {
            DeviceControl::RGBSysEx(name)
        } else {
            let control = MidiDeviceControl {
                note: self.note,
                range: self.range.unwrap_or(match self.resolution {
                    MidiResolution::Default => (0, 127),
                    MidiResolution::HighRes => (0, 16383),
                }),
                channel: self.channel,
                resolution: self.resolution,
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
