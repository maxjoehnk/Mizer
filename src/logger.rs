use std::io::Write;

pub fn init() {
    env_logger::builder()
        .format(|buf, record| {
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
            )?;

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
