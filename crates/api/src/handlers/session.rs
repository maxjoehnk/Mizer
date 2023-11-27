use futures::{Stream, StreamExt};

use mizer_session::SessionManager;

use crate::proto::session::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct SessionHandler<R: RuntimeApi> {
    runtime: R,
    session_manager: SessionManager,
}

impl<R: RuntimeApi> SessionHandler<R> {
    pub fn new(runtime: R, session_manager: SessionManager) -> Self {
        Self {
            runtime,
            session_manager,
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn watch_session(&self) -> anyhow::Result<impl Stream<Item = SessionState>> {
        let stream = self
            .runtime
            .observe_session()?
            .into_stream()
            .map(|state| SessionState {
                current_session: Some(Session {
                    file_path: state.project_info.project_path,
                    devices: state
                        .session
                        .clients
                        .into_iter()
                        .map(|client| SessionDevice {
                            name: client.name,
                            ips: client.ips,
                            role: ClientRole::from(client.role) as i32,
                            clock: Some(DeviceClock { drift: 0f64 }),
                            ping: 0.,
                        })
                        .collect(),
                }),
                role: ClientRole::from(state.session.role) as i32,
                available_sessions: state
                    .available_sessions
                    .into_iter()
                    .map(|session| DiscoveredSession {
                        name: session.name,
                        file_name: session.file_name,
                        hostname: session.hostname,
                        ips: session.addrs,
                        port: session.port as u32,
                    })
                    .collect(),
                project_history: state.project_info.project_history,
            });

        Ok(stream)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn join_session(&self, session: DiscoveredSession) -> anyhow::Result<()> {
        self.session_manager.join_session(session.into())?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn new_project(&self) -> anyhow::Result<()> {
        self.runtime.new_project()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn load_project(&self, path: String) -> anyhow::Result<()> {
        self.runtime.load_project(path)
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
                }
            })
    }
}
