use super::{Laser};
use crate::laser::{LaserFrame, LaserPoint};
use ::ether_dream::dac::stream;
use ::ether_dream::protocol::DacPoint;
use std::time::Duration;

pub struct EtherDreamLaser {
    device: stream::Stream,
}

impl EtherDreamLaser {
    pub fn find_devices() -> anyhow::Result<impl Iterator<Item = anyhow::Result<EtherDreamLaser>>> {
        let broadcasts = ::ether_dream::recv_dac_broadcasts()?;
        broadcasts.set_timeout(Some(Duration::from_secs(5)))?;

        Ok(broadcasts
            .into_iter()
            .map(|dac_broadcast| {
                let (dac_broadcast, addr) = dac_broadcast?;
                log::debug!("Found ether dream {:?} on {:?}", &dac_broadcast, &addr);
                let device = stream::connect(&dac_broadcast, addr.ip())?;

                Ok(EtherDreamLaser { device })
            }))
    }
}

impl Laser for EtherDreamLaser {
    fn write_frame(&mut self, frame: LaserFrame) -> anyhow::Result<()> {
        self.device
            .queue_commands()
            .prepare_stream()
            .data(frame.points.into_iter().map(DacPoint::from))
            .begin(0, 30000)
            .submit()?;

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
