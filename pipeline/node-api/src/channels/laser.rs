use mizer_protocol_laser::LaserFrame;

use super::{GenericChannel, GenericSender};

pub type LaserChannel = GenericChannel<Vec<LaserFrame>>;
pub type LaserSender = GenericSender<Vec<LaserFrame>>;
