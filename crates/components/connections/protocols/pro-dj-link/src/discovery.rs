use std::collections::HashMap;
use std::sync::Arc;

use flume::{Receiver, Sender};
use futures::Stream;
use pro_dj_link::{
    AsyncSearchService, AsyncTrackBpmService, AsyncVirtualCdj, DeviceType, StatusPacket,
};
use tokio::sync::Mutex;

use crate::{CDJView, DJMView, DeviceView, ProDJLinkDevice};

struct ProDJLinkDiscoveryService {
    sender: Sender<ProDJLinkDevice>,
    virtual_cdj: AsyncVirtualCdj,
    search: AsyncSearchService,
    tempo: AsyncTrackBpmService,
    devices: Arc<Mutex<HashMap<u8, ProDJLinkDevice>>>,
}

impl ProDJLinkDiscoveryService {
    async fn new(sender: Sender<ProDJLinkDevice>) -> anyhow::Result<Self> {
        let network_interface =
            netdev::get_default_interface().map_err(|err| anyhow::anyhow!("{err}"))?;
        let ip = network_interface
            .ipv4
            .first()
            .ok_or(anyhow::anyhow!("No IPv4 address found"))?;
        let ip = ip.addr;
        let mac_addr = network_interface
            .mac_addr
            .ok_or(anyhow::anyhow!("No MAC address found"))?;
        tracing::info!("Starting ProDJLink discovery service on ip {ip} ({mac_addr})...");
        let virtual_cdj = AsyncVirtualCdj::new(ip, mac_addr.octets()).await?;
        let search = AsyncSearchService::new().await?;
        let tempo = AsyncTrackBpmService::new().await?;

        Ok(Self {
            sender,
            virtual_cdj,
            search,
            tempo,
            devices: Default::default(),
        })
    }

    async fn run(mut self) {
        tracing::debug!("Discovering ProDJLink devices...");
        let devices = self.devices.clone();
        let sender = self.sender.clone();
        let virtual_cdj_handle = tokio::spawn(async move {
            loop {
                if let Err(err) = self.virtual_cdj.send_keep_alive().await {
                    tracing::error!("Failed to send keep alive: {err:?}");
                }
                tokio::time::sleep(std::time::Duration::from_millis(150)).await;
                match self.virtual_cdj.recv().await {
                    Ok(Some(StatusPacket::CdjStatus(packet))) => {
                        tracing::trace!("Virtual CDJ Packet: {packet:?}");
                        let mut devices = devices.lock().await;
                        if let Some(ProDJLinkDevice::CDJ(cdj)) = devices.get_mut(&packet.device_id)
                        {
                            cdj.state = packet.state;
                            sender.send(ProDJLinkDevice::CDJ(cdj.clone())).unwrap();
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
        let sender = self.sender.clone();
        let tempo_handle = tokio::spawn(async move {
            loop {
                match self.tempo.recv().await {
                    Ok(None) => continue,
                    Ok(Some(packet)) => {
                        tracing::trace!("Tempo Packet: {packet:?}");
                        let mut devices = devices.lock().await;
                        if let Some(device) = devices.get_mut(&packet.device_id) {
                            if let ProDJLinkDevice::CDJ(cdj) = device {
                                cdj.speed = packet.speed;
                                cdj.beat = packet.beat;
                                if let Err(err) = sender.send(ProDJLinkDevice::CDJ(cdj.clone())) {
                                    tracing::error!("Failed to send CDJ device: {err:?}");
                                }
                            }
                        }
                    }
                    Err(err) => tracing::error!("Virtual CDJ error: {err:?}"),
                }
            }
        });
        let devices = self.devices.clone();
        let sender = self.sender.clone();
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
                        let entry = devices.entry(keep_alive.device_id).or_insert_with(|| {
                            let device = DeviceView {
                                name: keep_alive.name.to_string(),
                                device_id: keep_alive.device_id,
                                last_ping: std::time::Instant::now(),
                                mac_addr: keep_alive.mac,
                                ip_addr: keep_alive.ip,
                            };
                            if keep_alive.device_type == DeviceType::CDJ {
                                ProDJLinkDevice::CDJ(CDJView {
                                    device,
                                    speed: Default::default(),
                                    beat: 1,
                                    state: Default::default(),
                                })
                            } else {
                                ProDJLinkDevice::DJM(DJMView { device })
                            }
                        });
                        entry.last_ping = std::time::Instant::now();
                        if let Err(err) = sender.send(entry.clone()) {
                            tracing::error!("Failed to send ProDJ Link device: {err:?}");
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

pub struct ProDJLinkDiscovery {
    devices: Receiver<ProDJLinkDevice>,
}

impl ProDJLinkDiscovery {
    pub async fn new() -> anyhow::Result<Self> {
        let (sender, receiver) = flume::unbounded();
        let service = ProDJLinkDiscoveryService::new(sender).await?;
        tokio::spawn(service.run());

        Ok(Self { devices: receiver })
    }

    pub fn into_stream(self) -> impl Stream<Item = ProDJLinkDevice> {
        self.devices.into_stream()
    }
}
