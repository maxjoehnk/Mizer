use std::sync::Arc;

use parking_lot::RwLock;

use mizer_message_bus::{MessageBus, Subscriber};

use crate::{discovery, DiscoveredSession, ProjectInfo, Session, SessionState};

#[derive(Clone)]
pub struct SessionManager {
    available_sessions: Arc<RwLock<Vec<DiscoveredSession>>>,
    project_info: Arc<RwLock<ProjectInfo>>,
    current_session: Arc<RwLock<Session>>,
    session_events: MessageBus<SessionState>,
}

impl SessionManager {
    pub(crate) fn new() -> anyhow::Result<Self> {
        Ok(Self {
            available_sessions: Default::default(),
            project_info: Default::default(),
            current_session: Arc::new(RwLock::new(Session::new_orchestrator()?)),
            session_events: MessageBus::new(),
        })
    }

    pub(crate) fn start_discovery(&self) -> anyhow::Result<()> {
        #[cfg(unix)]
        discovery::discover_sessions(self.clone())?;

        Ok(())
    }

    pub fn announce(&self, api_port: u16) -> anyhow::Result<()> {
        #[cfg(unix)]
        discovery::announce_device(api_port);

        Ok(())
    }

    pub fn change_project(&self, project_path: Option<String>, history: Vec<String>) {
        {
            let mut info = self.project_info.write();
            *info = ProjectInfo {
                project_path,
                project_history: history,
            };
        }
        self.emit_update();
    }

    pub fn join_session(&self, session: DiscoveredSession) -> anyhow::Result<()> {
        let mut current_session = self.current_session.write();
        *current_session = Session::new_remote()?;
        self.project_info.write().project_path = session.file_name;

        self.emit_update();

        Ok(())
    }

    pub(crate) fn add_discovered_session(&self, mut session: DiscoveredSession) {
        {
            let mut available_sessions = self.available_sessions.write();
            if let Some(index) = available_sessions
                .iter()
                .position(|s| s.hostname == session.hostname)
            {
                available_sessions[index].addrs.append(&mut session.addrs);
                available_sessions[index].addrs.sort();
                available_sessions[index].addrs.dedup();
            } else {
                available_sessions.push(session);
            }
        }
        self.emit_update();
    }

    pub(crate) fn emit_update(&self) {
        let info = self.project_info.read().clone();
        let session = self.current_session.read().clone();
        let available_sessions = self.available_sessions.read().clone();

        self.session_events.send(SessionState {
            session,
            project_info: info,
            available_sessions,
        });
    }

    pub fn subscribe(&self) -> Subscriber<SessionState> {
        self.session_events.subscribe()
    }
}
