use mizer_commander::{Query, Ref};
use mizer_connections::*;
use mizer_protocol_midi::MidiConnectionManager;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListConnectionsQuery;

impl<'a> Query<'a> for ListConnectionsQuery {
    type Dependencies = (
        Ref<MidiConnectionManager>,
        Ref<ConnectionStorage>,
    );
    type Result = Vec<ConnectionView>;

    fn query(
        &self,
        (midi_manager, connection_storage): (
            &MidiConnectionManager,
            &ConnectionStorage,
        ),
    ) -> anyhow::Result<Self::Result> {
        let mut connections = Vec::new();
        connections.extend(self.midi_connections(midi_manager));
        connections.extend(self.connection_storage_views(connection_storage));

        Ok(connections)
    }
}

impl ListConnectionsQuery {
    fn midi_connections(
        &self,
        midi_manager: &MidiConnectionManager,
    ) -> impl Iterator<Item =ConnectionView> {
        midi_manager
            .list_available_devices()
            .into_iter()
            .map(|device| MidiView {
                name: device.name,
                device_profile: device.profile.as_ref().map(|profile| profile.id.clone()),
            })
            .map(ConnectionView::from)
    }

    fn connection_storage_views<'a>(
        &self,
        connection_storage: &'a ConnectionStorage,
    ) -> impl Iterator<Item =ConnectionView> + 'a {
        connection_storage.get_connection_views().into_iter()
    }
}
