use serde::{Deserialize, Serialize};

pub mod ether_dream;
pub mod helios;

pub trait Laser: std::fmt::Debug {
    fn write_frame(&mut self, frame: LaserFrame) -> anyhow::Result<()>;
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct LaserFrame {
    pub points: Vec<LaserPoint>,
}

#[derive(Debug, Clone, PartialEq, Copy, Serialize, Deserialize)]
pub struct LaserPoint {
    pub color: LaserColor,
    pub coordinate: LaserCoordinate,
}

#[derive(Debug, Clone, PartialEq, Eq, Copy, Serialize, Deserialize)]
pub struct LaserColor {
    pub red: u8, // TODO: increase fidelity to 16bit? ether dream does support 10 bit colors
    pub green: u8,
    pub blue: u8,
}

#[derive(Debug, Clone, PartialEq, Eq, Copy, Serialize, Deserialize)]
pub struct LaserCoordinate {
    pub x: i16,
    pub y: i16,
}
