use crate::WebcamRef;
use nokhwa::utils::ApiBackend;
use nokhwa::{nokhwa_check, nokhwa_initialize};
use mizer_connection_contracts::RemoteConnectionStorageHandle;

struct DiscoveryService {
    backend: ApiBackend,
    sender: RemoteConnectionStorageHandle<WebcamRef>,
}

impl DiscoveryService {
    fn new(sender: RemoteConnectionStorageHandle<WebcamRef>) -> Self {
        let backend = nokhwa::native_api_backend().unwrap();

        Self { backend, sender }
    }

    fn run(&self) {
        tracing::trace!("Discovering attached webcams...");
        match nokhwa::query(self.backend) {
            Ok(cameras) => {
                for camera in cameras {
                    tracing::trace!("Found webcam: {camera:?}");
                    mizer_console::debug!(
                        mizer_console::ConsoleCategory::Connections,
                        "Webcam connected: {:?}",
                        camera.human_name()
                    );
                    let name = camera.human_name();
                    if let Err(err) = self.sender.add_connection(camera, Some(name)) {
                        tracing::error!("Unable to notify of new device {err:?}");
                    }
                }
            }
            Err(err) => tracing::error!("Error querying cameras: {err:?}"),
        }
    }
}

pub fn discover_devices(handle: RemoteConnectionStorageHandle<WebcamRef>) {
    if !nokhwa_check() {
        nokhwa_initialize(move |success| {
            if success {
                start_discovery(handle.clone());
            }
        })
    } else {
        start_discovery(handle);
    }
}

fn start_discovery(sender: RemoteConnectionStorageHandle<WebcamRef>) {
    std::thread::spawn(move || {
        let service = DiscoveryService::new(sender);

        service.run();
    });
}
