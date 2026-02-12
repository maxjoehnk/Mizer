use std::net::SocketAddr;
use super::Laser;
use crate::laser::{LaserFrame, LaserPoint};
use ::ether_dream::dac::stream;
use ::ether_dream::protocol::DacPoint;
use std::time::Duration;
use ether_dream::dac::MacAddress;
use ether_dream::protocol::DacBroadcast;
use mizer_connection_contracts::{IConnection, RemoteConnectionStorageHandle, TransmissionStateSender};

pub struct EtherDreamLaser {
    device: stream::Stream,
    transmission_state_sender: TransmissionStateSender,
}

impl EtherDreamLaser {
    pub fn find_devices(handler: RemoteConnectionStorageHandle<EtherDreamLaser>) -> anyhow::Result<()> {
        let broadcasts = ::ether_dream::recv_dac_broadcasts()?;
        broadcasts.set_timeout(Some(Duration::from_secs(5)))?;

        for dac in broadcasts.into_iter() {
            let dac = dac?;

            let mac = MacAddress(dac.0.mac_address);

            handler.add_connection(dac, Some(format!("EtherDream ({})", mac)))?;
        }

        Ok(())
    }

    pub fn status(&self) -> EtherDreamLaserStatus {
        let dac = self.device.dac();

        EtherDreamLaserStatus {
            mac_address: dac.mac_address.to_string(),
            hw_revision: dac.hw_revision,
            sw_revision: dac.sw_revision,
        }
    }
}

impl IConnection for EtherDreamLaser {
    type Config = (DacBroadcast, SocketAddr);
    const TYPE: &'static str = "ether-dream";

    fn create((dac_broadcast, addr): Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self> {
        tracing::debug!("Found ether dream {:?} on {:?}", &dac_broadcast, &addr);
        let device = stream::connect(&dac_broadcast, addr.ip())?;

        Ok(Self { device, transmission_state_sender: transmission_sender })
    }
}

pub struct EtherDreamLaserStatus {
    pub mac_address: String,
    pub hw_revision: u16,
    pub sw_revision: u16,
}

impl Laser for EtherDreamLaser {
    fn write_frame(&mut self, frame: LaserFrame) -> anyhow::Result<()> {
        self.device
            .queue_commands()
            .prepare_stream()
            .data(frame.points.into_iter().map(DacPoint::from))
            .begin(0, 30000)
            .submit()?;
        self.transmission_state_sender.sent_packet();

        Ok(())
    }
}

impl std::fmt::Debug for EtherDreamLaser {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct("EtherDreamLaser")
            .field("dac", self.device.dac())
            .finish()
    }
}

impl From<LaserPoint> for DacPoint {
    fn from(point: LaserPoint) -> Self {
        DacPoint {
            x: point.coordinate.x,
            y: point.coordinate.y,
            r: point.color.red as u16,
            g: point.color.green as u16,
            b: point.color.blue as u16,
            i: 0xff,
            control: 0,
            u1: 0,
            u2: 0,
        }
    }
}
