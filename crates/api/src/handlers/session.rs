use crate::proto::session::*;
use crate::RuntimeApi;
use futures::{Stream, StreamExt};
use mizer_module::{ProjectLoadingError, ProjectLoadingResult};

#[derive(Clone)]
pub struct SessionHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> SessionHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn watch_session(&self) -> anyhow::Result<impl Stream<Item = Session>> {
        let stream = self
            .runtime
            .observe_session()?
            .into_stream()
            .map(|state| Session {
                file_path: state.project_path,
                project_history: state.project_history,
                devices: vec![SessionDevice {
                    name: "max-arch".into(),
                    ping: 0f64,
                    ips: vec!["192.168.1.13".to_string()],
                    clock: Some(DeviceClock {
                        drift: 0f64,
                        master: true,
                    }),
                }],
            });

        Ok(stream)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn new_project(&self) -> anyhow::Result<()> {
        self.runtime.new_project()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn load_project(&self, path: String) -> LoadProjectResult {
        let result = self.runtime.load_project(path);

        let (state, error) = match result.error {
            None => (load_project_result::State::Ok, None),
            Some(ProjectLoadingError::MissingFile) => (load_project_result::State::MissingFile, None),
            Some(ProjectLoadingError::InvalidFile) => (load_project_result::State::InvalidFile, None),
            Some(ProjectLoadingError::UnsupportedFileType) => (load_project_result::State::UnsupportedFileType, None),
            Some(ProjectLoadingError::MigrationIssue(err)) => (load_project_result::State::MigrationIssue, Some(err.to_string())),
            Some(ProjectLoadingError::Unknown(err)) => (load_project_result::State::Unknown, Some(err.to_string())),
        };

        LoadProjectResult {
            state: state as i32,
            error,
            migration: result.migration_result.map(|(from, to)| load_project_result::MigrationResult {
                from,
                to,
            }),
            issues: result.warnings,
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn save_project(&self) -> anyhow::Result<()> {
        self.runtime.save_project()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn save_project_as(&self, path: String) -> anyhow::Result<()> {
        self.runtime.save_project_as(path)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn undo(&self) -> anyhow::Result<()> {
        self.runtime.undo()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn redo(&self) -> anyhow::Result<()> {
        self.runtime.redo()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn watch_history(&self) -> impl Stream<Item = History> {
        self.runtime
            .observe_history()
            .into_stream()
            .map(|(items, cursor)| {
                let items = items
                    .into_iter()
                    .map(|(label, timestamp)| HistoryItem {
                        label,
                        timestamp: timestamp as u64,
                        ..Default::default()
                    })
                    .collect();

                History {
                    items,
                    pointer: cursor as u64,
                    ..Default::default()
                }
            })
    }
}
