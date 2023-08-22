pub use cdj::PioneerCdjNode;
pub use clock::ProDjLinkClockNode;
use mizer_devices::{DeviceManager, DeviceRef};
use mizer_node::SelectVariant;

mod cdj;
mod clock;

pub(crate) fn get_cdjs(device_manager: &DeviceManager) -> Vec<SelectVariant> {
    device_manager
        .current_devices()
        .into_iter()
        .filter_map(|device| {
            if let DeviceRef::PioneerCDJ(cdj) = device {
                Some(cdj)
            } else {
                None
            }
        })
        .map(|cdj| SelectVariant::Item {
            label: format!("{} {}", cdj.device.name, cdj.device.device_id).into(),
            value: cdj.id().into(),
        })
        .collect()
}
