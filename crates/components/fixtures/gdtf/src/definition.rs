use hard_xml::XmlRead;

use crate::types::*;

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "GDTF")]
pub struct GdtfFixtureDefinition {
    #[xml(attr = "DataVersion")]
    pub data_version: String,
    #[xml(child = "FixtureType")]
    pub fixture_type: FixtureType,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "FixtureType")]
pub struct FixtureType {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(attr = "ShortName")]
    pub short_name: String,
    #[xml(attr = "LongName")]
    pub long_name: String,
    #[xml(attr = "Manufacturer")]
    pub manufacturer: String,
    #[xml(attr = "Description")]
    pub description: String,
    #[xml(attr = "FixtureTypeID")]
    pub fixture_type_id: String,
    #[xml(attr = "Thumbnail")]
    pub thumbnail: Option<String>,
    #[xml(child = "AttributeDefinitions")]
    pub attribute_definitions: AttributeDefinitions,
    #[xml(child = "Wheels", default)]
    pub wheels: Wheels,
    #[xml(child = "PhysicalDescriptions")]
    pub physical_descriptions: PhysicalDescriptions,
    #[xml(child = "DMXModes")]
    pub dmx_modes: DmxModes,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "AttributeDefinitions")]
pub struct AttributeDefinitions {
    #[xml(child = "ActivationGroups")]
    pub activation_groups: ActivationGroups,
    #[xml(child = "FeatureGroups")]
    pub feature_groups: FeatureGroups,
    #[xml(child = "Attributes")]
    pub attributes: Attributes,
}

#[derive(Default, Debug, Clone, XmlRead)]
#[xml(tag = "ActivationGroups")]
pub struct ActivationGroups {
    #[xml(child = "ActivationGroup")]
    pub groups: Vec<ActivationGroup>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "ActivationGroup")]
pub struct ActivationGroup {
    #[xml(attr = "Name")]
    pub name: String,
}

#[derive(Default, Debug, Clone, XmlRead)]
#[xml(tag = "FeatureGroups")]
pub struct FeatureGroups {
    #[xml(child = "FeatureGroup")]
    pub groups: Vec<FeatureGroup>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "FeatureGroup")]
pub struct FeatureGroup {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(attr = "Pretty")]
    pub pretty: String,
    #[xml(child = "Feature")]
    pub features: Vec<Feature>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Feature")]
pub struct Feature {
    #[xml(attr = "Name")]
    pub name: String,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Attributes")]
pub struct Attributes {
    #[xml(child = "Attribute")]
    pub attributes: Vec<Attribute>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Attribute")]
pub struct Attribute {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(attr = "Pretty")]
    pub pretty: String,
    #[xml(attr = "ActivationGroup")]
    pub activation_group: Option<String>,
    #[xml(attr = "Feature")]
    pub feature: FeatureRef,
    #[xml(attr = "MainAttribute")]
    pub main_attribute: Option<String>,
    #[xml(attr = "PhysicalUnit")]
    pub physical_unit: PhysicalUnit,
}

#[derive(Default, Debug, Clone, XmlRead)]
#[xml(tag = "Wheels")]
pub struct Wheels {
    #[xml(child = "Wheel")]
    pub wheels: Vec<Wheel>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Wheel")]
pub struct Wheel {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(child = "Slot")]
    pub slots: Vec<WheelSlot>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Slot")]
pub struct WheelSlot {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(attr = "Color")]
    pub color: String,
    #[xml(attr = "MediaFileName")]
    pub media_file_name: Option<String>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "PhysicalDescriptions")]
pub struct PhysicalDescriptions {}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "DMXModes")]
pub struct DmxModes {
    #[xml(child = "DMXMode")]
    pub modes: Vec<DmxMode>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "DMXMode")]
pub struct DmxMode {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(child = "DMXChannels", default)]
    pub channels: DmxChannels,
}

#[derive(Default, Debug, Clone, XmlRead)]
#[xml(tag = "DMXChannels")]
pub struct DmxChannels {
    #[xml(child = "DMXChannel")]
    pub channels: Vec<DmxChannel>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "DMXChannel")]
pub struct DmxChannel {
    #[xml(attr = "DMXBreak")]
    pub dmx_break: u64,
    #[xml(attr = "Offset")]
    pub offset: DmxChannelOffset,
    #[xml(attr = "Default", default)]
    pub default: DmxValue,
    #[xml(attr = "Highlight")]
    pub highlight: DmxValue,
    // This is documented as a list of channels but I haven't found a file where this is the case
    #[xml(child = "LogicalChannel")]
    pub logical_channel: LogicalChannel,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "LogicalChannel")]
pub struct LogicalChannel {
    #[xml(attr = "Attribute")]
    pub attribute: String,
}
