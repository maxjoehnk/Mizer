use std::sync::Mutex;

use gstreamer::{Element, Pipeline};
use lazy_static::lazy_static;

pub use self::color_balance::*;
pub use self::effect::*;
pub use self::file::*;
pub use self::output::*;
pub use self::transform::*;

mod color_balance;
mod effect;
mod file;
mod output;
mod transform;

lazy_static! {
    pub(crate) static ref PIPELINE: Mutex<Pipeline> = {
        gstreamer::init().unwrap();
        let pipeline = Pipeline::new(None);
        Mutex::new(pipeline)
    };
}

pub trait GstreamerNode {
    fn link_to(&self, target: &dyn GstreamerNode) -> anyhow::Result<()>;

    fn sink(&self) -> &Element;
}
