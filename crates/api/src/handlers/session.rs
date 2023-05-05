use crate::models::session::*;
use crate::RuntimeApi;
use futures::{Stream, StreamExt};
use protobuf::MessageField;

#[derive(Clone)]
pub struct SessionHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> SessionHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
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
                    clock: MessageField::some(DeviceClock {
                        drift: 0f64,
                        master: true,
                        ..Default::default()
                    }),
                    ..Default::default()
                }],
                ..Default::default()
            });

        Ok(stream)
    }

    #[tracing::instrument(skip(self))]
    pub fn new_project(&self) -> anyhow::Result<()> {
        self.runtime.new_project()
    }

    #[tracing::instrument(skip(self))]
    pub fn load_project(&self, path: String) -> anyhow::Result<()> {
        self.runtime.load_project(path)
    }

    #[tracing::instrument(skip(self))]
    pub fn save_project(&self) -> anyhow::Result<()> {
        self.runtime.save_project()
    }

    #[tracing::instrument(skip(self))]
    pub fn save_project_as(&self, path: String) -> anyhow::Result<()> {
        self.runtime.save_project_as(path)
    }

    #[tracing::instrument(skip(self))]
    pub fn undo(&self) -> anyhow::Result<()> {
        self.runtime.undo()
    }

    #[tracing::instrument(skip(self))]
    pub fn redo(&self) -> anyhow::Result<()> {
        self.runtime.redo()
    }

    #[tracing::instrument(skip(self))]
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
