use crate::types::{drop_array, Array};

pub mod connections;
pub mod fixture;
pub mod layout;
pub mod node_history;
pub mod nodes;
pub mod programmer;
pub mod sequencer;
pub mod status;
pub mod timecode;
pub mod transport;

#[no_mangle]
pub extern "C" fn drop_byte_array(array: Array<u8>) {
    drop_array(array)
}

#[no_mangle]
pub extern "C" fn drop_double_array(array: Array<f64>) {
    drop_array(array)
}
