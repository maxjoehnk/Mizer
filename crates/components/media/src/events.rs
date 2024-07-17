use crate::documents::MediaId;

#[derive(Debug, Clone, Copy)]
pub enum MediaEvent {
    FileAdded(MediaId),
    FileUpdated(MediaId),
}
