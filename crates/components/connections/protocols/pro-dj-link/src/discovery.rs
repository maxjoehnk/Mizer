use std::collections::HashMap;
use std::sync::{Arc};

use tokio::sync::Mutex;
use pro_dj_link::{
    AsyncSearchService, AsyncTrackBpmService, AsyncVirtualCdj, DeviceType, StatusPacket,
};
use mizer_connection_contracts::{RemoteConnectionStorageHandle, StorageCommandId};
use crate::{CDJView, DJMView, DeviceView};

pub(crate) struct ProDJLinkDiscoveryService {
    cdj_sender: RemoteConnectionStorageHandle<CDJView>,
    djm_sender: RemoteConnectionStorageHandle<DJMView>,
    virtual_cdj: AsyncVirtualCdj,
    search: AsyncSearchService,
    tempo: AsyncTrackBpmService,
    devices: Arc<Mutex<HashMap<u8, StorageCommandId>>>,
}

impl ProDJLinkDiscoveryService {
    pub(crate) async fn new(cdj_sender: RemoteConnectionStorageHandle<CDJView>, djm_sender: RemoteConnectionStorageHandle<DJMView>) -> anyhow::Result<Self> {
        let network_interface =
            netdev::get_default_interface().map_err(|err| anyhow::anyhow!("{err}"))?;
        let ip = network_interface
            .ipv4
            .first()
            .ok_or(anyhow::anyhow!("No IPv4 address found"))?;
        let ip = ip.addr();
        let mac_addr = network_interface
            .mac_addr
            .ok_or(anyhow::anyhow!("No MAC address found"))?;
        tracing::info!("Starting ProDJLink discovery service on ip {ip} ({mac_addr})...");
        let virtual_cdj = AsyncVirtualCdj::new(ip, mac_addr.octets()).await?;
        let search = AsyncSearchService::new().await?;
        let tempo = AsyncTrackBpmService::new().await?;

        Ok(Self {
            cdj_sender,
            djm_sender,
            virtual_cdj,
            search,
            tempo,
            devices: Default::default(),
        })
    }

    pub(crate) async fn run(mut self) {
        tracing::debug!("Discovering ProDJLink devices...");
        let devices = self.devices.clone();
        let sender = self.cdj_sender.clone();
        let virtual_cdj_handle = tokio::spawn(async move {
            loop {
                if let Err(err) = self.virtual_cdj.send_keep_alive().await {
                    tracing::error!("Failed to send keep alive: {err:?}");
                }
                tokio::time::sleep(std::time::Duration::from_millis(150)).await;
                match self.virtual_cdj.recv().await {
                    Ok(Some(StatusPacket::CdjStatus(packet))) => {
                        tracing::trace!("Virtual CDJ Packet: {packet:?}");
                        let devices = devices.lock().await;
                        if let Some(id) = devices.get(&packet.device_id)
                        {
                            if let Err(err) = sender.update_connection(*id, move |cdj| {
                                cdj.state = packet.state;
                            }) {
                                tracing::error!("Failed to update cdj with status packet: {err:?}");
                            }
                        }
                    }
                    Ok(Some(StatusPacket::MixerStatus(packet))) => {
                        tracing::trace!("Virtual CDJ Packet: {packet:?}");
                    }
                    Ok(None) => continue,
                    Err(err) => tracing::error!("Virtual CDJ error: {err:?}"),
                }
            }
        });
        let devices = self.devices.clone();
        let sender = self.cdj_sender.clone();
        let tempo_handle = tokio::spawn(async move {
            loop {
                match self.tempo.recv().await {
                    Ok(None) => continue,
                    Ok(Some(packet)) => {
                        tracing::trace!("Tempo Packet: {packet:?}");
                        let devices = devices.lock().await;
                        if let Some(id) = devices.get(&packet.device_id) {
                            if let Err(err) = sender.update_connection(*id, move |cdj| {
                                cdj.speed = packet.speed;
                                cdj.beat = packet.beat;
                            }) {
                                tracing::error!("Failed to update cdj with tempo packet: {err:?}");
                            }
                        }
                    }
                    Err(err) => tracing::error!("Virtual CDJ error: {err:?}"),
                }
            }
        });
        let devices = self.devices.clone();
        let cdj_sender = self.cdj_sender.clone();
        let djm_sender = self.djm_sender.clone();
        let search_handle = tokio::spawn(async move {
            loop {
                match self.search.recv().await {
                    Ok(None) => {
                        tracing::warn!("Ignoring invalid search packet");
                        continue;
                    }
                    Ok(Some(keep_alive)) => {
                        tracing::trace!("Search Packet: {keep_alive:?}");
                        if keep_alive.device_type == DeviceType::Rekordbox
                            || keep_alive.is_virtual_cdj()
                        {
                            tracing::trace!("Ignoring rekordbox and virtual cdj packets");
                            continue;
                        }
                        let mut devices = devices.lock().await;
                        if let Some(id) = devices.get(&keep_alive.device_id) {
                            let ping = std::time::Instant::now();
                            let result = if keep_alive.device_type == DeviceType::CDJ {
                                cdj_sender.update_connection(*id, move |cdj| {
                                    cdj.device.last_ping = ping;
                                })
                            }else if keep_alive.device_type == DeviceType::Mixer {
                                djm_sender.update_connection(*id, move |djm| {
                                    djm.device.last_ping = ping;
                                })
                            }else {
                                continue;
                            };
                            if let Err(err) = result {
                                tracing::error!("Unable to update device ping {err:?}");
                            }
                        }else {
                            let device = DeviceView {
                                name: keep_alive.name.to_string(),
                                device_id: keep_alive.device_id,
                                last_ping: std::time::Instant::now(),
                                mac_addr: keep_alive.mac,
                                ip_addr: keep_alive.ip,
                            };
                            let result = if keep_alive.device_type == DeviceType::CDJ {
                                cdj_sender.add_connection(device, Some(keep_alive.name.to_string()))
                            } else if keep_alive.device_type == DeviceType::Mixer {
                                djm_sender.add_connection(device, Some(keep_alive.name.to_string()))
                            } else {
                                continue;
                            };
                            match result {
                                Err(err) => {
                                    tracing::error!("Failed to add connection: {err:?}");
                                }
                                Ok(id) => {
                                    devices.insert(keep_alive.device_id, id);
                                }
                            }
                        }
                    }
                    Err(err) => tracing::error!("Search error: {err:?}"),
                }
            }
        });

        if let Err(err) = search_handle.await {
            tracing::error!("Search handle error: {err:?}");
        }
        if let Err(err) = tempo_handle.await {
            tracing::error!("Tempo handle error: {err:?}");
        }
        if let Err(err) = virtual_cdj_handle.await {
            tracing::error!("Virtual CDJ handle error: {err:?}");
        }
    }
}
