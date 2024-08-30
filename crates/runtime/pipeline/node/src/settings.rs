use std::borrow::Cow;
use std::fmt::{Debug, Display};
use std::hash::{Hash, Hasher};
use std::sync::Arc;

use enum_iterator::{all, Sequence};
use serde::{Deserialize, Serialize};

use mizer_util::Spline;

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize, Hash)]
pub struct NodeSetting {
    pub id: Cow<'static, str>,
    pub label: Option<Cow<'static, str>>,
    pub description: String,
    pub disabled: bool,
    pub value: NodeSettingValue,
    pub optional: bool,
}

impl NodeSetting {
    pub fn label(mut self, label: impl Into<Cow<'static, str>>) -> Self {
        self.label = Some(label.into());

        self
    }

    pub fn description(mut self, description: String) -> Self {
        self.description = description;

        self
    }

    pub fn disabled(mut self) -> Self {
        self.disabled = true;

        self
    }

    pub fn multiline(mut self) -> Self {
        if let NodeSettingValue::Text { multiline, .. } = &mut self.value {
            *multiline = true;
        }

        self
    }

    pub fn optional(mut self) -> Self {
        self.optional = true;

        self
    }
}

pub trait NumericSettings<T> {
    fn min(self, min: T) -> Self;
    fn max(self, max: T) -> Self;
    fn min_hint(self, min_hint: T) -> Self;
    fn max_hint(self, max_hint: T) -> Self;
    fn step_size(self, step_size: T) -> Self;
}

impl NumericSettings<f64> for NodeSetting {
    fn min(mut self, value: f64) -> Self {
        if let NodeSettingValue::Float { min, .. } = &mut self.value {
            *min = Some(value);
        }
        self
    }

    fn max(mut self, value: f64) -> Self {
        if let NodeSettingValue::Float { max, .. } = &mut self.value {
            *max = Some(value);
        }
        self
    }

    fn min_hint(mut self, value: f64) -> Self {
        if let NodeSettingValue::Float { min_hint, .. } = &mut self.value {
            *min_hint = Some(value);
        }
        self
    }

    fn max_hint(mut self, value: f64) -> Self {
        if let NodeSettingValue::Float { max_hint, .. } = &mut self.value {
            *max_hint = Some(value);
        }
        self
    }

    fn step_size(mut self, value: f64) -> Self {
        if let NodeSettingValue::Float { step_size, .. } = &mut self.value {
            *step_size = Some(value);
        }
        self
    }
}

impl NumericSettings<u32> for NodeSetting {
    fn min(mut self, value: u32) -> Self {
        if let NodeSettingValue::Uint { min, .. } = &mut self.value {
            *min = Some(value);
        }
        self
    }

    fn max(mut self, value: u32) -> Self {
        if let NodeSettingValue::Uint { max, .. } = &mut self.value {
            *max = Some(value);
        }
        self
    }

    fn min_hint(mut self, value: u32) -> Self {
        if let NodeSettingValue::Uint { min_hint, .. } = &mut self.value {
            *min_hint = Some(value);
        }
        self
    }

    fn max_hint(mut self, value: u32) -> Self {
        if let NodeSettingValue::Uint { max_hint, .. } = &mut self.value {
            *max_hint = Some(value);
        }
        self
    }

    fn step_size(mut self, value: u32) -> Self {
        if let NodeSettingValue::Uint { step_size, .. } = &mut self.value {
            *step_size = Some(value);
        }
        self
    }
}

impl NumericSettings<i64> for NodeSetting {
    fn min(mut self, value: i64) -> Self {
        if let NodeSettingValue::Int { min, .. } = &mut self.value {
            *min = Some(value);
        }
        self
    }

    fn max(mut self, value: i64) -> Self {
        if let NodeSettingValue::Int { max, .. } = &mut self.value {
            *max = Some(value);
        }
        self
    }

    fn min_hint(mut self, value: i64) -> Self {
        if let NodeSettingValue::Int { min_hint, .. } = &mut self.value {
            *min_hint = Some(value);
        }
        self
    }

    fn max_hint(mut self, value: i64) -> Self {
        if let NodeSettingValue::Int { max_hint, .. } = &mut self.value {
            *max_hint = Some(value);
        }
        self
    }

    fn step_size(mut self, value: i64) -> Self {
        if let NodeSettingValue::Int { step_size, .. } = &mut self.value {
            *step_size = Some(value);
        }
        self
    }
}

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub enum NodeSettingValue {
    Text {
        value: String,
        multiline: bool,
    },
    Float {
        value: f64,
        min: Option<f64>,
        min_hint: Option<f64>,
        max: Option<f64>,
        max_hint: Option<f64>,
        step_size: Option<f64>,
    },
    Uint {
        value: u32,
        min: Option<u32>,
        min_hint: Option<u32>,
        max: Option<u32>,
        max_hint: Option<u32>,
        step_size: Option<u32>,
    },
    Int {
        value: i64,
        min: Option<i64>,
        min_hint: Option<i64>,
        max: Option<i64>,
        max_hint: Option<i64>,
        step_size: Option<i64>,
    },
    Bool {
        value: bool,
    },
    Select {
        value: String,
        variants: Vec<SelectVariant>,
    },
    Enum {
        value: u8,
        variants: Vec<EnumVariant>,
    },
    Id {
        value: u32,
        variants: Vec<IdVariant>,
    },
    Spline(Spline),
    Media {
        value: String,
        content_types: Vec<MediaContentType>,
    },
    Steps(Vec<bool>),
    Button,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Deserialize, Serialize)]
pub enum MediaContentType {
    Image,
    Audio,
    Video,
    Vector,
    Data,
}

#[allow(clippy::derive_hash_xor_eq)]
impl Hash for NodeSettingValue {
    fn hash<H: Hasher>(&self, state: &mut H) {
        match self {
            Self::Text { value, multiline } => {
                state.write_u8(0);
                multiline.hash(state);
                value.hash(state);
            }
            Self::Float { value, .. } => {
                state.write_u8(1);
                value.to_bits().hash(state);
            }
            Self::Uint {
                value,
                min,
                min_hint,
                max,
                max_hint,
                step_size,
            } => {
                state.write_u8(2);
                value.hash(state);
                min.hash(state);
                min_hint.hash(state);
                max.hash(state);
                max_hint.hash(state);
                step_size.hash(state);
            }
            Self::Int {
                value,
                min,
                min_hint,
                max,
                max_hint,
                step_size,
            } => {
                state.write_u8(2);
                value.hash(state);
                min.hash(state);
                min_hint.hash(state);
                max.hash(state);
                max_hint.hash(state);
                step_size.hash(state);
            }
            Self::Bool { value } => {
                state.write_u8(3);
                value.hash(state);
            }
            Self::Select { value, .. } => {
                state.write_u8(4);
                value.hash(state);
            }
            Self::Enum { value, .. } => {
                state.write_u8(5);
                value.hash(state);
            }
            Self::Id { value, .. } => {
                state.write_u8(6);
                value.hash(state);
            }
            Self::Spline(spline) => spline.hash(state),
            Self::Media { value, .. } => {
                state.write_u8(7);
                value.hash(state);
            }
            Self::Steps(steps) => {
                state.write_u8(8);
                steps.hash(state);
            }
            Self::Button => state.write_u8(9),
        }
    }
}

impl NodeSettingValue {
    pub fn from_enum<T: Sequence + Into<u8> + Display>(value: T) -> Self {
        Self::Enum {
            value: value.into(),
            variants: get_variants::<T>(),
        }
    }

    pub fn select(value: String, values: Vec<SelectVariant>) -> Self {
        Self::Select {
            value: value.into(),
            variants: values,
        }
    }

    pub fn id(value: impl Into<u32>, values: Vec<IdVariant>) -> Self {
        Self::Id {
            value: value.into(),
            variants: values,
        }
    }

    pub fn media(value: String, content_types: Vec<MediaContentType>) -> Self {
        Self::Media {
            value,
            content_types,
        }
    }
}

impl From<bool> for NodeSettingValue {
    fn from(value: bool) -> Self {
        Self::Bool { value }
    }
}

impl From<Spline> for NodeSettingValue {
    fn from(value: Spline) -> Self {
        Self::Spline(value)
    }
}

impl From<String> for NodeSettingValue {
    fn from(value: String) -> Self {
        Self::Text {
            value,
            multiline: false,
        }
    }
}

impl From<&String> for NodeSettingValue {
    fn from(value: &String) -> Self {
        Self::Text {
            value: value.clone(),
            multiline: false,
        }
    }
}

impl From<f64> for NodeSettingValue {
    fn from(value: f64) -> Self {
        Self::Float {
            value,
            max: None,
            min: None,
            max_hint: None,
            min_hint: None,
            step_size: None,
        }
    }
}

impl From<u32> for NodeSettingValue {
    fn from(value: u32) -> Self {
        Self::Uint {
            value,
            max: None,
            min: None,
            max_hint: None,
            min_hint: None,
            step_size: None,
        }
    }
}

impl From<i64> for NodeSettingValue {
    fn from(value: i64) -> Self {
        Self::Int {
            value,
            max: None,
            min: None,
            max_hint: None,
            min_hint: None,
            step_size: None,
        }
    }
}

impl From<Vec<bool>> for NodeSettingValue {
    fn from(value: Vec<bool>) -> Self {
        Self::Steps(value)
    }
}

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize, Hash)]
pub struct EnumVariant {
    pub value: u8,
    pub label: String,
}

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize, Hash)]
pub struct IdVariant {
    pub value: u32,
    pub label: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize, Hash, PartialOrd, Ord)]
pub enum SelectVariant {
    Group {
        label: Arc<String>,
        children: Vec<SelectVariant>,
    },
    Item {
        label: Arc<String>,
        value: Arc<String>,
    },
}

impl From<String> for SelectVariant {
    fn from(value: String) -> Self {
        let value = Arc::new(value);
        Self::Item {
            label: Arc::clone(&value),
            value,
        }
    }
}

impl From<Arc<String>> for SelectVariant {
    fn from(value: Arc<String>) -> Self {
        Self::Item {
            label: Arc::clone(&value),
            value,
        }
    }
}

fn get_variants<T: Sequence + Into<u8> + Display>() -> Vec<EnumVariant> {
    all::<T>()
        .map(|variant| EnumVariant {
            label: variant.to_string(),
            value: variant.into(),
        })
        .collect()
}
