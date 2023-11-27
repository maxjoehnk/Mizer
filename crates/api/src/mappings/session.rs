use crate::proto::session::*;

impl From<mizer_session::ClientRole> for ClientRole {
    fn from(value: mizer_session::ClientRole) -> Self {
        use mizer_session::ClientRole;

        match value {
            ClientRole::Orchestrator => Self::Orchestrator,
            ClientRole::Mobile => Self::Mobile,
            ClientRole::Remote => Self::Remote,
        }
    }
}

impl From<DiscoveredSession> for mizer_session::DiscoveredSession {
    fn from(value: DiscoveredSession) -> Self {
        Self {
            file_name: value.file_name,
            hostname: value.hostname,
            port: value.port as u16,
            addrs: value.ips,
            name: value.name,
        }
    }
}
