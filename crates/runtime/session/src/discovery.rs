use std::any::Any;
use std::sync::Arc;
use std::thread;
use std::time::Duration;

use zeroconf::prelude::*;
use zeroconf::{
    MdnsBrowser, MdnsService, ServiceDiscovery, ServiceRegistration, ServiceType, TxtRecord,
};

const POLL_TIMEOUT: u64 = 1;

pub(crate) fn announce_device(port: u16) {
    let service_type = build_service_type().unwrap();
    thread::Builder::new()
        .name("Session MDNS Broadcast".into())
        .spawn(move || {
            log::info!("Announcing api on mdns");
            let mut service = MdnsService::new(service_type, port);
            let mut txt_record = TxtRecord::new();
            txt_record.insert("project", "video.yml").unwrap();
            service.set_name("Mizer");
            service.set_txt_record(txt_record);
            service.set_registered_callback(Box::new(on_service_registered));
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
    let service_type = build_service_type()?;
    thread::Builder::new()
        .name("Session MDNS Discovery".into())
        .spawn(|| {
            let mut browser = MdnsBrowser::new(service_type);

            browser.set_service_discovered_callback(Box::new(on_service_discovered));

            let event_loop = browser.browse_services().unwrap();
            loop {
                event_loop.poll(Duration::from_secs(POLL_TIMEOUT)).unwrap();
                thread::sleep(Duration::from_secs(POLL_TIMEOUT));
            }
        })?;

    Ok(())
}

fn build_service_type() -> anyhow::Result<ServiceType> {
    let service_type = ServiceType::new("mizer", "tcp")?;

    Ok(service_type)
}

fn on_service_discovered(
    result: zeroconf::Result<ServiceDiscovery>,
    _context: Option<Arc<dyn Any>>,
) {
    log::debug!("service discovered: {:?}", result);
}

pub fn on_service_registered(
    result: zeroconf::Result<ServiceRegistration>,
    _context: Option<Arc<dyn Any>>,
) {
    log::info!("service registered: {:?}", result);
}
