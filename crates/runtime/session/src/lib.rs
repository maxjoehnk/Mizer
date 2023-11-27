use serde::{Deserialize, Serialize};

pub use manager::SessionManager;
pub use module::SessionModule;

#[cfg(unix)]
mod discovery;
mod manager;
mod module;

// TODO: this should be moved into it's own module as it's only partially related to sessions
#[derive(Default, Debug, Clone, Deserialize, Serialize)]
pub struct ProjectInfo {
    pub project_path: Option<String>,
    pub project_history: Vec<String>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct SessionState {
    pub session: Session,
    pub project_info: ProjectInfo,
    pub available_sessions: Vec<DiscoveredSession>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Session {
    pub role: ClientRole,
    pub clients: Vec<SessionClient>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct DiscoveredSession {
    pub name: String,
    pub file_name: Option<String>,
    pub hostname: String,
    pub port: u16,
    pub addrs: Vec<String>,
}

impl Session {
    pub(crate) fn new_orchestrator() -> anyhow::Result<Self> {
        Ok(Session {
            clients: vec![SessionClient::get_self(ClientRole::Orchestrator)?],
            role: ClientRole::Orchestrator,
        })
    }

    pub(crate) fn new_remote() -> anyhow::Result<Self> {
        Ok(Session {
            clients: vec![SessionClient::get_self(ClientRole::Remote)?],
            role: ClientRole::Remote,
        })
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct SessionClient {
    pub name: String,
    pub ips: Vec<String>,
    pub role: ClientRole,
}

impl SessionClient {
    pub fn get_self(role: ClientRole) -> anyhow::Result<Self> {
        let name = hostname::get()?.into_string().unwrap();
        let ips = match default_net::get_default_interface() {
            Ok(default_interface) => default_interface
                .ipv4
                .into_iter()
                .map(|ip| ip.to_string())
                .collect(),
            Err(err) => {
                log::error!("Unable to get default network interface: {err}");
                Default::default()
            }
        };

        Ok(SessionClient { name, ips, role })
    }
}

#[derive(Default, Debug, Clone, Copy, Deserialize, Serialize)]
pub enum ClientRole {
    /// single point of truth, only client which can directly modify session
    #[default]
    Orchestrator,
    /// mobile app used to view fixture patch and highlight fixtures
    Mobile,
    /// secondary instance of Mizer joined to the session capable of interacting with fixtures system
    Remote,
}
