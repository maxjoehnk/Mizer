use std::time::Instant;

#[cfg(debug_assertions)]
#[macro_export]
macro_rules! stopwatch {
    ($fmt: expr) => {
        mizer_util::Stopwatch::start(format!($fmt))
    }
}

#[cfg(not(debug_assertions))]
#[macro_export]
macro_rules! stopwatch {
    ($fmt: expr) => {
        mizer_util::Stopwatch::start()
    }
}

pub struct Stopwatch {
    start: Instant,
    #[cfg(debug_assertions)]
    text: String,
}

impl Stopwatch {
    #[cfg(not(debug_assertions))]
    pub fn start() -> Self {
        Self {
            start: Instant::now(),
        }
    }

    #[cfg(debug_assertions)]
    #[must_use]
    pub fn start(text: String) -> Self {
        Self {
            start: Instant::now(),
            text,
        }
    }
}

#[cfg(debug_assertions)]
impl Drop for Stopwatch {
    fn drop(&mut self) {
        let now = Instant::now();
        let duration = now - self.start;

        tracing::info!("Stopwatch: {} took {duration:?}", self.text);
    }
}
