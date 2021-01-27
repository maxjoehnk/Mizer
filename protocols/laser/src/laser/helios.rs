use super::*;
use ::helios_dac::NativeHeliosDac;

pub struct HeliosLaser {
    device: NativeHeliosDac
}

impl Laser for HeliosLaser {
    fn find_devices() -> anyhow::Result<Vec<HeliosLaser>> {
        let controller = helios_dac::NativeHeliosDacController::new()?;
        let devices = controller.list_devices()?;
        let mut lasers = vec![];
        for device in devices {
            let device = device.open()?;
            lasers.push(device.into());
        }

        Ok(lasers)
    }

    fn write_frame(&mut self, frame: LaserFrame) -> anyhow::Result<()> {
        self.device.write_frame(frame.into())?;
        Ok(())
    }
}

impl From<helios_dac::NativeHeliosDac> for HeliosLaser {
    fn from(dac: NativeHeliosDac) -> Self {
        HeliosLaser {
            device: dac
        }
    }
}

impl From<LaserFrame> for helios_dac::Frame {
    fn from(frame: LaserFrame) -> Self {
        helios_dac::Frame {
            points: frame.points.into_iter().map(helios_dac::Point::from).collect(),
            pps: 30000, // TODO
            flags: helios_dac::WriteFrameFlags::empty()
        }
    }
}

impl From<LaserPoint> for helios_dac::Point {
    fn from(point: LaserPoint) -> Self {
        helios_dac::Point {
            coordinate: point.coordinate.into(),
            color: point.color.into(),
            intensity: 0xff
        }
    }
}

impl From<LaserColor> for helios_dac::Color {
    fn from(color: LaserColor) -> Self {
        helios_dac::Color {
            r: color.red,
            g: color.green,
            b: color.blue,
        }
    }
}

impl From<LaserCoordinate> for helios_dac::Coordinate {
    fn from(coordinate: LaserCoordinate) -> Self {
        helios_dac::Coordinate {
            x: coordinate.x as u16, // TODO: calculate offset
            y: coordinate.y as u16
        }
    }
}
