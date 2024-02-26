use crate::WebcamRef;
use flume::{unbounded, Receiver, Sender};
use futures::Stream;
use nokhwa::utils::ApiBackend;
use nokhwa::{nokhwa_check, nokhwa_initialize};

struct DiscoveryService {
    backend: ApiBackend,
    sender: Sender<WebcamRef>,
}

impl DiscoveryService {
    fn new(sender: Sender<WebcamRef>) -> Self {
        let backend = nokhwa::native_api_backend().unwrap();

        Self { backend, sender }
    }

    fn run(&self) {
        tracing::trace!("Discovering attached webcams...");
        match nokhwa::query(self.backend) {
            Ok(cameras) => {
                for camera in cameras {
                    tracing::trace!("Found webcam: {camera:?}");
                    let camera = WebcamRef::new(camera);
                    if let Err(err) = self.sender.send(camera) {
                        tracing::error!("Unable to notify of new device {err:?}");
                    }
                }
            }
            Err(err) => tracing::error!("Error querying cameras: {err:?}"),
        }
    }
}

pub struct WebcamDiscovery {
    cameras: Receiver<WebcamRef>,
}

impl WebcamDiscovery {
    pub fn new() -> Self {
        let (sender, receiver) = unbounded();

        if !nokhwa_check() {
            nokhwa_initialize(move |success| {
                if success {
                    start_discovery(sender.clone());
                }
            })
        } else {
            start_discovery(sender);
        }

        Self { cameras: receiver }
    }

    pub fn into_stream(self) -> impl Stream<Item = WebcamRef> {
        self.cameras.into_stream()
    }
}

fn start_discovery(sender: Sender<WebcamRef>) {
    std::thread::spawn(move || {
        let service = DiscoveryService::new(sender);

        service.run();
    });
}
