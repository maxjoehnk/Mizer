use crate::protos::SessionApi;
use grpc::{
    ServerHandlerContext, ServerRequestSingle, ServerResponseSink, ServerResponseUnarySink,
};
use mizer_proto::session::*;

pub struct SessionApiImpl;

impl SessionApiImpl {
    pub fn new() -> Self {
        SessionApiImpl
    }
}

impl SessionApi for SessionApiImpl {
    fn get_session(
        &self,
        _: ServerHandlerContext,
        req: ServerRequestSingle<SessionRequest>,
        mut resp: ServerResponseSink<Session>,
    ) -> grpc::Result<()> {
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

        resp.send_data(session)
    }
}
