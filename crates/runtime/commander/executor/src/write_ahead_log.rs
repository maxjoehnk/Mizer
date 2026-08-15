use std::fs;
use std::fs::File;
use std::io::{BufRead, Write};
use std::path::PathBuf;
use mizer_module::{Inject, Injector};
use crate::{CommandExecutor, CommandHistory, CommandImpl};

pub struct WriteAheadLog;

// TODO: Encode project path in filename? Would require some way of cleanup of old wal's
const FILE_NAME: &str = "mizer.wal";

impl WriteAheadLog {
    fn log_path() -> PathBuf {
        mizer_util::cache_dir().map(|dir| dir.join(FILE_NAME)).unwrap_or_else(|| PathBuf::from(FILE_NAME))
    }

    pub fn is_empty() -> anyhow::Result<bool> {
        let path = Self::log_path();
        if !path.exists() {
            return Ok(true);
        }

        let file_size = fs::metadata(path)?.len();
        Ok(file_size == 0)
    }

    pub fn read(&self) -> anyhow::Result<Vec<CommandImpl>> {
        let path = Self::log_path();
        if !path.exists() {
            return Ok(vec![]);
        }
        let file = File::open(path)?;
        let reader = std::io::BufReader::new(file).lines();
        let mut commands = Vec::new();
        for line in reader {
            let line = line?;
            let command: CommandImpl = serde_json::from_str(&line)?;
            commands.push(command);
        }

        Ok(commands)
    }

    pub fn append(&self, command: &CommandImpl) -> anyhow::Result<()> {
        let path = Self::log_path();
        tracing::debug!("Appending command to WAL {}", path.display());
        if let Some(parent) = path.parent() {
            std::fs::create_dir_all(parent)?;
        }
        let mut file = File::options()
            .append(true)
            .create(true)
            .open(path)?;
        serde_json::to_writer(&mut file, command)?;
        file.write_all(&[b'\n'])?;
        file.flush()?;

        Ok(())
    }

    pub fn truncate(&self) -> anyhow::Result<()> {
        std::fs::remove_file(Self::log_path())?;
        Ok(())
    }

    pub fn apply_log(injector: &mut Injector) -> anyhow::Result<()> {
        tracing::info!("Applying unsaved change from last session");

        let (log, injector) = injector.get_slice_mut::<WriteAheadLog>().unwrap();
        let (executor, injector) = injector.get_slice_mut::<CommandExecutor>().unwrap();
        let log = log.read()?;

        for cmd in log {
            let (_, key) = cmd.apply(injector, executor, None)?;
            let history = injector.get_mut::<CommandHistory>().unwrap();
            history.add_entry(cmd, key);
        }

        Ok(())
    }
}
