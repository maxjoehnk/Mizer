#[macro_export]
macro_rules! info {
    ($category:expr, $($arg:tt)*) => {{
        mizer_console::info($category, format!($($arg)*))
    }};
}

#[macro_export]
macro_rules! debug {
    ($category:expr, $($arg:tt)*) => {{
        mizer_console::debug($category, format!($($arg)*))
    }};
}

#[macro_export]
macro_rules! warn {
    ($category:expr, $($arg:tt)*) => {{
        mizer_console::warning($category, format!($($arg)*))
    }};
}

#[macro_export]
macro_rules! error {
    ($category:expr, $($arg:tt)*) => {{
        mizer_console::error($category, format!($($arg)*))
    }};
}
