use grpc::{ServerHandlerContext, ServerResponseUnarySink, ServerRequestSingle, ServerResponseSink};
use mizer_proto::session::*;
use crate::protos::SessionApi;

pub struct SessionApiImpl;

impl SessionApiImpl {
    pub fn new() -> Self {
        SessionApiImpl
    }
}

impl SessionApi for SessionApiImpl {
    fn get_session(&self, _: ServerHandlerContext, req: ServerRequestSingle<SessionRequest>, mut resp: ServerResponseSink<Session>) -> grpc::Result<()> {
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
        let dmxNode = {
            let mut dmxNode = SessionDevice::new();
            dmxNode.name = "dmx-node-1".into();
            dmxNode.ping = 0.4;
            dmxNode.set_ips(vec!["192.168.1.14".to_string()].into());
            let mut clock = DeviceClock::new();
            clock.drift = 0f64;
            clock.master = false;
            dmxNode.set_clock(clock);
            dmxNode
        };
        session.set_devices(vec![desktop, dmxNode].into());

        resp.send_data(session)
    }
}
