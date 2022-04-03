use env_logger::fmt::Formatter;
use log::Record;
use std::io::Write;

#[cfg(not(target_os = "macos"))]
pub fn init() {
    env_logger::builder()
        .format(|buf, record| {
            write_record(buf, record)?;

            if record.key_values().count() > 0 {
                let arguments = LogArgs {
                    source: record.key_values(),
                };
                writeln!(buf, "{:?}", arguments)?;
            }

            Ok(())
        })
        .init();
}

#[cfg(target_os = "macos")]
pub fn init() {
    use log::LevelFilter;
    use oslog::*;

    OsLogger::new("live.mizer")
        .level_filter(LevelFilter::Debug)
        .init()
        .unwrap();
}

#[cfg(debug_assertions)]
fn write_record(buf: &mut Formatter, record: &Record) -> std::io::Result<()> {
    let style = buf.style();
    let timestamp = buf.timestamp();
    let thread = std::thread::current().id();
    let file = record
        .file()
        .zip(record.line())
        .map(|(file, line)| format!("{}:{}", file, line))
        .unwrap_or_default();

    writeln!(
        buf,
        "[{} {} {} {}] {:?}: {}",
        timestamp,
        record.level(),
        record.target(),
        file,
        thread,
        style.value(record.args())
    )
}

#[cfg(not(debug_assertions))]
fn write_record(buf: &mut Formatter, record: &Record) -> std::io::Result<()> {
    let style = buf.style();
    let timestamp = buf.timestamp();
    let thread = std::thread::current().id();
    writeln!(
        buf,
        "[{} {} {}] {:?}: {}",
        timestamp,
        record.level(),
        record.target(),
        thread,
        style.value(record.args())
    )
}

struct LogArgs<T: log::kv::Source> {
    source: T,
}

impl<T: log::kv::Source> std::fmt::Debug for LogArgs<T> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let mut visitor = f.debug_map();
        self.source.visit(&mut visitor).unwrap();

        Ok(())
    }
}
