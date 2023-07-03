use enum_iterator::{all, Sequence};
use mizer_util::Spline;
use serde::{Deserialize, Serialize};
use std::fmt::{Debug, Display};
use std::hash::{Hash, Hasher};

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize, Hash)]
pub struct NodeSetting {
    pub label: String,
    pub description: String,
    pub disabled: bool,
    pub value: NodeSettingValue,
    pub optional: bool,
}

impl NodeSetting {
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
}

impl NumericSettings<u32> for NodeSetting {
    fn min(mut self, value: u32) -> Self {
        if let NodeSettingValue::Int { min, .. } = &mut self.value {
            *min = Some(value);
        }
        self
    }

    fn max(mut self, value: u32) -> Self {
        if let NodeSettingValue::Int { max, .. } = &mut self.value {
            *max = Some(value);
        }
        self
    }

    fn min_hint(mut self, value: u32) -> Self {
        if let NodeSettingValue::Int { min_hint, .. } = &mut self.value {
            *min_hint = Some(value);
        }
        self
    }

    fn max_hint(mut self, value: u32) -> Self {
        if let NodeSettingValue::Int { max_hint, .. } = &mut self.value {
            *max_hint = Some(value);
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
    },
    Int {
        value: u32,
        min: Option<u32>,
        min_hint: Option<u32>,
        max: Option<u32>,
        max_hint: Option<u32>,
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
            Self::Int {
                value,
                min,
                min_hint,
                max,
                max_hint,
            } => {
                state.write_u8(2);
                value.hash(state);
                min.hash(state);
                min_hint.hash(state);
                max.hash(state);
                max_hint.hash(state);
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
        }
    }
}

impl From<u32> for NodeSettingValue {
    fn from(value: u32) -> Self {
        Self::Int {
            value,
            max: None,
            min: None,
            max_hint: None,
            min_hint: None,
        }
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

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize, Hash)]
pub enum SelectVariant {
    Group {
        label: String,
        children: Vec<SelectVariant>,
    },
    Item {
        label: String,
        value: String,
    },
}

impl From<String> for SelectVariant {
    fn from(value: String) -> Self {
        Self::Item {
            value: value.clone(),
            label: value,
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
