use mizer_clock::SystemClock;

pub use self::api::*;
pub use self::coordinator::CoordinatorRuntime;

pub type DefaultRuntime = CoordinatorRuntime<SystemClock>;

mod api;
mod coordinator;
