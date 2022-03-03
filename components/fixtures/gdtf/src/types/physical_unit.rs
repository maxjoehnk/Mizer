use std::str::FromStr;

#[derive(Debug, Clone)]
pub enum PhysicalUnit {
    None,
    Percent,
    Length,
    Mass,
    Time,
    Temperature,
    LuminousIntensity,
    Angle,
    Force,
    Frequency,
    Current,
    Voltage,
    Power,
    Energy,
    Area,
    Volume,
    Speed,
    Acceleration,
    AngularSpeed,
    AngularAccc,
    WaveLength,
    ColorComponent,
}

impl FromStr for PhysicalUnit {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "None" => Ok(Self::None),
            "Percent" => Ok(Self::Percent),
            "Length" => Ok(Self::Length),
            "Mass" => Ok(Self::Mass),
            "Time" => Ok(Self::Time),
            "Temperature" => Ok(Self::Temperature),
            "LuminousIntensity" => Ok(Self::LuminousIntensity),
            "Angle" => Ok(Self::Angle),
            "Force" => Ok(Self::Force),
            "Frequency" => Ok(Self::Frequency),
            "Current" => Ok(Self::Current),
            "Voltage" => Ok(Self::Voltage),
            "Power" => Ok(Self::Power),
            "Energy" => Ok(Self::Energy),
            "Area" => Ok(Self::Area),
            "Volume" => Ok(Self::Volume),
            "Speed" => Ok(Self::Speed),
            "Acceleration" => Ok(Self::Acceleration),
            "AngularSpeed" => Ok(Self::AngularSpeed),
            "AngularAccc" => Ok(Self::AngularAccc),
            "WaveLength" => Ok(Self::WaveLength),
            "ColorComponent" => Ok(Self::ColorComponent),
            _ => Err(format!("Unknown PhysicalUnit '{s}'"))
        }
    }
}

impl Default for PhysicalUnit {
    fn default() -> Self {
        Self::None
    }
}
