use std::time::Duration;

use flume::{unbounded, Receiver, Sender};
use futures::Stream;
use ndi::Find;

use crate::NdiSourceRef;

struct DiscoveryService {
    find: Find,
    sender: Sender<Vec<NdiSourceRef>>,
}

impl DiscoveryService {
    fn new(sender: Sender<Vec<NdiSourceRef>>) -> anyhow::Result<Self> {
        let find = ndi::find::FindBuilder::new().build()?;

        Ok(Self { find, sender })
    }

    fn run(&self) {
        tracing::trace!("Discovering ndi devices...");
        loop {
            std::thread::sleep(Duration::from_secs(5));
            match self.find.current_sources(u128::MAX) {
                Ok(sources) => {
                    let sources = sources
                        .into_iter()
                        .map(|source| {
                            tracing::trace!("Found source: {source:?}");

                            NdiSourceRef::new(source)
                        })
                        .collect::<Vec<_>>();
                    if let Err(err) = self.sender.send(sources) {
                        tracing::error!("Unable to notify of new devices {err:?}");
                    }
                }
                Err(err) => tracing::error!("Error querying ndi devices: {err:?}"),
            }
        }
    }
}

pub struct NdiSourceDiscovery {
    devices: Receiver<Vec<NdiSourceRef>>,
}

impl NdiSourceDiscovery {
    pub fn new() -> anyhow::Result<Self> {
        let (sender, receiver) = unbounded();

        start_discovery(sender)?;

        Ok(Self { devices: receiver })
    }

    pub fn into_stream(self) -> impl Stream<Item = Vec<NdiSourceRef>> {
        self.devices.into_stream()
    }
}

fn start_discovery(sender: Sender<Vec<NdiSourceRef>>) -> anyhow::Result<()> {
    let service = DiscoveryService::new(sender)?;
    std::thread::spawn(move || service.run());

    Ok(())
}
