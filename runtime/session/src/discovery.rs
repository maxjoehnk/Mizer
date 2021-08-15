use std::any::Any;
use std::sync::Arc;
use std::thread;
use std::time::Duration;

use serde::{Deserialize, Serialize};
use zeroconf::prelude::*;
use zeroconf::{MdnsBrowser, MdnsService, ServiceDiscovery, TxtRecord};

const MIZER_SESSION_SERVICE: &str = "_mizer._tcp";

const POLL_TIMEOUT: u64 = 1;

pub(crate) fn announce_device() {
    thread::Builder::new()
        .name("Session MDNS Broadcast".into())
        .spawn(|| {
            let mut service = MdnsService::new(MIZER_SESSION_SERVICE, 50051);
            let mut txt_record = TxtRecord::new();
            txt_record.insert("project", "video.yml").unwrap();
            service.set_txt_record(txt_record);
            let event_loop = service.register().unwrap();
            loop {
                event_loop.poll(Duration::from_secs(POLL_TIMEOUT)).unwrap();
                #[cfg(target_os = "linux")]
                    // poll doesn't sleep in avahi implementation
                    thread::sleep(Duration::from_secs(POLL_TIMEOUT));
            }
        })
        .unwrap();
}

pub fn discover_sessions() -> anyhow::Result<()> {
    let mut browser = MdnsBrowser::new(MIZER_SESSION_SERVICE);

    browser.set_service_discovered_callback(Box::new(on_service_discovered));

    let event_loop = browser.browse_services().unwrap();
    loop {
        event_loop.poll(Duration::from_secs(POLL_TIMEOUT)).unwrap();
    }
}

fn on_service_discovered(
    result: zeroconf::Result<ServiceDiscovery>,
    _context: Option<Arc<dyn Any>>,
) {
    println!("service: {:?}", result);
}
