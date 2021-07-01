use crate::models::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct SessionHandler<R: RuntimeApi> {
    runtime: R
}

impl<R: RuntimeApi> SessionHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self {
            runtime
        }
    }

    pub fn get_session(&self) -> Session {
        let mut session = Session::new();
        let desktop = {
            let mut desktop = SessionDevice::new();
            desktop.name = "max-arch".into();
            desktop.ping = 0f64;
            desktop.set_ips(vec!["192.168.1.13".to_string()].into());
            let mut clock = DeviceClock::new();
            clock.drift = 0f64;
            clock.master = true;
            desktop.set_clock(clock);
            desktop
        };
        let dmx_node = {
            let mut dmx_node = SessionDevice::new();
            dmx_node.name = "dmx-node-1".into();
            dmx_node.ping = 0.4;
            dmx_node.set_ips(vec!["192.168.1.14".to_string()].into());
            let mut clock = DeviceClock::new();
            clock.drift = 0f64;
            clock.master = false;
            dmx_node.set_clock(clock);
            dmx_node
        };
        session.set_devices(vec![desktop, dmx_node].into());

        session
    }

    pub fn new_project(&self) -> anyhow::Result<()> {
        self.runtime.new_project();

        Ok(())
    }

    pub fn load_project(&self, path: String) -> anyhow::Result<()> {
        self.runtime.load_project(path)
    }

    pub fn save_project(&self) -> anyhow::Result<()> {
        self.runtime.save_project()
    }
}
