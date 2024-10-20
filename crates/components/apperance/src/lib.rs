use serde_derive::{Deserialize, Serialize};
use derive_more::{Display, FromStr};

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct Appearance {
    pub icon: Option<Icon>,
    pub color: Option<Color>,
    pub background: Option<Color>,
}

impl Default for Appearance {
    fn default() -> Self {
        Self {
            icon: None,
            color: Some(Color {
                red: 1.0,
                green: 1.0,
                blue: 1.0,
                alpha: 1.0,
            }),
            background: Some(Color {
                red: 1.0,
                green: 1.0,
                blue: 1.0,
                alpha: 0.0,
            }),
        }
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Display, FromStr)]
#[serde(rename_all = "kebab-case")]
pub enum Icon {
    #[display("blinder2")]
    Blinder2,
    #[display("blinder4")]
    Blinder4,
    #[display("blinder8")]
    Blinder8,
    #[display("scanner")]
    Scanner,
    #[display("blades")]
    Blades,
    #[display("pixel-bar")]
    PixelBar,
    #[display("pixel-matrix")]
    PixelMatrix,
    #[display("moving-head")]
    MovingHead,
    #[display("smoke")]
    Smoke,
    #[display("fan")]
    Fan,
    #[display("par")]
    Par,
    #[display("flat-par")]
    FlatPar,
    #[display("strobe")]
    Strobe,
    #[display("tube")]
    Tube,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct Color {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
    pub alpha: f64,
}
