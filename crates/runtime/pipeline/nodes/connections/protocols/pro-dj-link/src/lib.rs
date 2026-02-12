pub use cdj::PioneerCdjNode;
pub use clock::ProDjLinkClockNode;
use mizer_connections::{CDJView, ConnectionStorage};
use mizer_node::SelectVariant;

mod cdj;
mod clock;

pub(crate) fn get_cdjs(device_manager: &ConnectionStorage) -> Vec<SelectVariant> {
    device_manager
        .query::<CDJView>()
        .into_iter()
        .map(|(_, _, cdj)| SelectVariant::Item {
            label: format!("{} {}", cdj.device.name, cdj.device.device_id).into(),
            value: format!("{}", cdj.device.device_id).into(),
        })
        .collect()
}
