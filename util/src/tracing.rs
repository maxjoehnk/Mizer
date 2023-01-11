pub use self::tracing_impl::*;

#[cfg(feature = "tracing")]
mod tracing_impl {
    pub fn init() {
        profiling::tracy_client::Client::start();
    }

    #[macro_export]
    macro_rules! plot {
        ($name: expr, $value: expr) => {
            profiling::tracy_client::plot!($name, $value);
        };
    }

    #[macro_export]
    macro_rules! message {
        ($message: expr, $callstack_depth: expr) => {
            profiling::tracy_client::Client::running()
                .unwrap()
                .message($message, $callstack_depth);
        };
    }
}

#[cfg(not(feature = "tracing"))]
mod tracing_impl {
    pub fn init() {}

    #[macro_export]
    macro_rules! plot {
        ($name: expr, $value: expr) => {
            let _value = $value;
        };
    }

    #[macro_export]
    macro_rules! message {
        ($message: expr, $callstack_depth: expr) => {};
    }
}
