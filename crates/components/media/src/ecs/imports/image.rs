use mizer_ecs::*;
use crate::ecs::models::{MediaContentType, MediaId, MediaImportStatus};

pub fn image_added(query: Query<(Entity, Ref<MediaId>, &MediaContentType)>, mut commands: Commands) {
    for (entity, id, _content_type) in query.iter()
        .filter(|(_, id, _)| id.is_added())
        .filter(|(_, _, content_type)| content_type.0.starts_with("image")) {
        tracing::debug!("Image added: {:?}", id);
        commands.entity(entity).insert(MediaImportStatus::Success);
    }
}
