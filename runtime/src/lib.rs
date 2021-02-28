use mizer_clock::SystemClock;

pub use self::coordinator::CoordinatorRuntime;
pub use self::api::*;

pub type DefaultRuntime = CoordinatorRuntime<SystemClock>;

mod coordinator;
mod worker;
mod api;
