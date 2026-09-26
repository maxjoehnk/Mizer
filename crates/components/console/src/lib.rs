pub use history::ConsoleHistory;
pub use message::*;

use crate::bus::{get_bus, init_bus, ConsoleBus};
pub use module::ConsoleModule;

mod aggregator;
mod bus;
mod history;
mod macros;
mod message;
mod module;

#[doc(hidden)]
pub fn __init() {
    let (tx, rx) = flume::unbounded();
    init_bus(ConsoleBus::new(tx)).unwrap();
    std::mem::forget(rx);
}

pub fn info(category: ConsoleCategory, message: impl Into<String>) {
    let bus = get_bus();
    bus.log(ConsoleLevel::Info, category, message.into());
}

pub fn debug(category: ConsoleCategory, message: impl Into<String>) {
    let bus = get_bus();
    bus.log(ConsoleLevel::Debug, category, message.into());
}

pub fn warning(category: ConsoleCategory, message: impl Into<String>) {
    let bus = get_bus();
    bus.log(ConsoleLevel::Warning, category, message.into());
}

pub fn error(category: ConsoleCategory, message: impl Into<String>) {
    let bus = get_bus();
    bus.log(ConsoleLevel::Error, category, message.into());
}
