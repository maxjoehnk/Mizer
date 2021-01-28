use super::Laser;
use crate::laser::{LaserFrame, LaserPoint};
use ::ether_dream::dac::stream;
use ::ether_dream::protocol::DacPoint;
use std::time::Duration;

pub struct EtherDreamLaser {
    device: stream::Stream,
}

impl Laser for EtherDreamLaser {
    fn find_devices() -> anyhow::Result<Vec<EtherDreamLaser>> {
        let broadcasts = ::ether_dream::recv_dac_broadcasts()?;
        // broadcasts.set_nonblocking(true);
        broadcasts.set_timeout(Some(Duration::from_secs(5)))?;
        let mut lasers = vec![];
        for dac_broadcast in broadcasts {
            let (dac_broadcast, addr) = dac_broadcast?;

            let device = stream::connect(&dac_broadcast, addr.ip().clone())?;
            lasers.push(EtherDreamLaser { device });

            return Ok(lasers);
        }

        Ok(lasers)
    }

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
