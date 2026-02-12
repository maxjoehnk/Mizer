use std::collections::{HashMap, HashSet};
use std::time::Duration;

use ndi::Find;
use mizer_connection_contracts::RemoteConnectionStorageHandle;
use crate::NdiSourceRef;

struct DiscoveryService {
    find: Find,
    sender: RemoteConnectionStorageHandle<NdiSourceRef>,
}

impl DiscoveryService {
    fn new(sender: RemoteConnectionStorageHandle<NdiSourceRef>) -> anyhow::Result<Self> {
        let find = ndi::find::FindBuilder::new().build()?;

        Ok(Self { find, sender })
    }

    fn run(&self) {
        tracing::trace!("Discovering ndi devices...");
        let mut current_sources = HashMap::new();
        let mut found_names = HashSet::new();
        loop {
            std::thread::sleep(Duration::from_secs(5));
            match self.find.current_sources(u128::MAX) {
                Ok(sources) => {
                    found_names.clear();
                    for source in sources {
                        tracing::trace!("Found source: {source:?}");

                        let name = source.get_name();
                        found_names.insert(name.clone());
                        if current_sources.contains_key(&name) {
                            continue;
                        }
                        match self.sender.add_connection(source, Some(name.clone())) {
                            Err(err) => {
                                tracing::error!("Unable to add device {err:?}");
                            }
                            Ok(id) => {
                                current_sources.insert(name, id);
                            }
                        }
                    }
                    for (_, id) in current_sources.extract_if(|name, _| !found_names.contains(name)) {
                        if let Err(err) = self.sender.drop_connection(id.clone()) {
                            tracing::error!("Unable to drop device {err:?}");
                        }
                    }
                }
                Err(err) => tracing::error!("Error querying ndi devices: {err:?}"),
            }
        }
    }
}

pub(crate) fn start_discovery(sender: RemoteConnectionStorageHandle<NdiSourceRef>) -> anyhow::Result<()> {
    let service = DiscoveryService::new(sender)?;
    std::thread::Builder::new()
        .name("NDI Discovery".to_string())
        .spawn(move || service.run())?;

    Ok(())
}
