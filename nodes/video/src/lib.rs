use std::sync::Mutex;

use gstreamer::Pipeline;
use lazy_static::lazy_static;

mod effect;
mod file;
mod output;

pub use self::file::*;
pub use self::output::*;
pub use self::effect::*;

lazy_static! {
    pub(crate) static ref PIPELINE: Mutex<Pipeline> = {
        gstreamer::init().unwrap();
        let pipeline = Pipeline::new(None);
        Mutex::new(pipeline)
    };
}
