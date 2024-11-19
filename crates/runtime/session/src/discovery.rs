use std::any::Any;
use std::sync::Arc;
use std::thread;
use std::time::Duration;

use crate::{Session, SessionState};
use mizer_message_bus::MessageBus;
use zeroconf::prelude::*;
use zeroconf::{
    MdnsBrowser, MdnsService, ServiceDiscovery, ServiceRegistration, ServiceType, TxtRecord,
};

const POLL_TIMEOUT: u64 = 1;

pub(crate) fn announce_device(port: u16, bus: MessageBus<SessionState>) {
    let service_type = build_service_type().unwrap();
    thread::Builder::new()
        .name("Session MDNS Broadcast".into())
        .spawn(move || {
            tracing::info!("Announcing api on mdns");
            loop {
                announce_service(service_type.clone(), port, &bus).unwrap();
            }
        })
        .unwrap();
}

fn announce_service(
    service_type: ServiceType,
    port: u16,
    bus: &MessageBus<SessionState>,
) -> anyhow::Result<()> {
    let subscriber = bus.subscribe();
    let mut service = MdnsService::new(service_type, port);
    let mut txt_record = TxtRecord::new();
    if let Some(path) = subscriber.read_last().and_then(|s| s.project_path) {
        txt_record.insert("project", &path)?;
    }
    service.set_name("Mizer");
    service.set_txt_record(txt_record);
    service.set_registered_callback(Box::new(on_service_registered));
    let event_loop = service.register()?;
    loop {
        if subscriber.read_last().is_some() {
            break Ok(());
        }

        event_loop.poll(Duration::from_secs(POLL_TIMEOUT))?;
        // poll doesn't sleep in avahi implementation
        #[cfg(target_os = "linux")]
        thread::sleep(Duration::from_secs(POLL_TIMEOUT));
    }
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
    tracing::debug!("service discovered: {:?}", result);
}

pub fn on_service_registered(
    result: zeroconf::Result<ServiceRegistration>,
    _context: Option<Arc<dyn Any>>,
) {
    tracing::info!("service registered: {:?}", result);
}
