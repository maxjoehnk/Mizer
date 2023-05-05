use serde::{Deserialize, Serialize};

#[cfg(unix)]
mod discovery;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct SessionState {
    pub project_path: Option<String>,
    pub project_history: Vec<String>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Session {
    pub clients: Vec<SessionClient>,
}

impl Session {
    pub fn new() -> anyhow::Result<Self> {
        #[cfg(unix)]
        discovery::announce_device();
        Ok(Session {
            clients: vec![SessionClient::get_self()?],
        })
    }

    // TODO: discover and connect to remote session
    pub fn discover() -> anyhow::Result<Self> {
        #[cfg(unix)]
        discovery::discover_sessions()?;
        Ok(Session {
            clients: vec![SessionClient::get_self()?],
        })
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct SessionClient {
    pub name: String,
    pub ips: Vec<String>,
    pub orchestrator: bool,
}

impl SessionClient {
    pub fn get_self() -> anyhow::Result<Self> {
        let name = hostname::get()?.into_string().unwrap();

        Ok(SessionClient {
            name,
            ips: vec![],
            orchestrator: true,
        })
    }
}

#[allow(dead_code)]
enum ClientRole {
    Orchestrator, // single point of truth, only client which can directly modify session
    Replica,      // may take over the orchestrator role when it leaves the session
    Worker,       // raw number cruncher
    Edge,         // outputs video, controls dmx universe etc
}
