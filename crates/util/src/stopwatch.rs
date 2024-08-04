use std::time::{Instant, Duration};

#[cfg(debug_assertions)]
#[macro_export]
macro_rules! stopwatch {
    ($fmt: expr) => {
        mizer_util::Stopwatch::start(format!($fmt), std::time::Duration::default())
    };
    ($fmt: expr, $deadline: expr) => {
        mizer_util::Stopwatch::start(format!($fmt), $deadline)
    };
}

#[cfg(not(debug_assertions))]
#[macro_export]
macro_rules! stopwatch {
    ($fmt: expr) => {
        mizer_util::Stopwatch::start()
    }
}

#[cfg(debug_assertions)]
pub struct Stopwatch {
    start: Instant,
    text: String,
    deadline: std::time::Duration,
}

#[cfg(not(debug_assertions))]
pub struct Stopwatch;

impl Stopwatch {
    #[cfg(not(debug_assertions))]
    pub fn start() -> Self {
        Self
    }

    #[cfg(debug_assertions)]
    #[must_use]
    pub fn start(text: String, deadline: Duration) -> Self {
        Self {
            start: Instant::now(),
            text,
            deadline,
        }
    }
}

#[cfg(debug_assertions)]
impl Drop for Stopwatch {
    fn drop(&mut self) {
        let now = Instant::now();
        let duration = now - self.start;

        if duration > self.deadline {
            tracing::info!("Stopwatch: {} took {duration:?}", self.text);
        }
    }
}
