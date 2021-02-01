use super::*;
use ::helios_dac::NativeHeliosDac;
use pinboard::Pinboard;
use std::sync::{Condvar, Arc, Mutex};
use std::thread;
use std::time::Duration;

pub struct HeliosLaser {
    current_frame: Arc<Pinboard<LaserFrame>>,
    lock: Arc<(Mutex<bool>, Condvar)>,
}

impl HeliosLaser {
    pub fn find_devices() -> anyhow::Result<Vec<HeliosLaser>> {
        let controller = helios_dac::NativeHeliosDacController::new()?;
        let devices = controller.list_devices()?;
        let mut lasers = vec![];
        for device in devices {
            let device = device.open()?;
            lasers.push(device.into());
        }

        Ok(lasers)
    }
}

impl Laser for HeliosLaser {
    fn write_frame(&mut self, frame: LaserFrame) -> anyhow::Result<()> {
        log::debug!("Queuing frame");
        self.current_frame.set(frame);
        let (lock, cvar) = &*self.lock;
        let mut frame_available = lock.lock().unwrap();
        *frame_available = true;
        cvar.notify_one();
        Ok(())
    }
}

impl std::fmt::Debug for HeliosLaser {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct("HeliosLaser").finish()
    }
}

struct HeliosLaserContext {
    current_frame: Arc<Pinboard<LaserFrame>>,
    lock: Arc<(Mutex<bool>, Condvar)>,
}

impl HeliosLaserContext {
    fn new(lock: &Arc<(Mutex<bool>, Condvar)>, current_frame: &Arc<Pinboard<LaserFrame>>) -> Self {
        HeliosLaserContext {
            current_frame: Arc::clone(current_frame),
            lock: Arc::clone(lock),
        }
    }

    fn wait_for_frame(&self) -> LaserFrame {
        let (lock, cvar) = &*self.lock;

        let mut available = lock.lock().unwrap();
        while !*available {
            available = cvar.wait(available).unwrap();
        }
        let frame = self.current_frame.read().unwrap();
        *available = false;

        frame
    }
}

impl From<helios_dac::NativeHeliosDac> for HeliosLaser {
    fn from(dac: NativeHeliosDac) -> Self {
        let lock = Arc::new((Mutex::new(false), Condvar::new()));
        let frame_board = Arc::new(Pinboard::<LaserFrame>::new_empty());
        let context = HeliosLaserContext::new(&lock, &frame_board);

        thread::Builder::new()
            .name("HeliosLaserWorker".to_string())
            .spawn(move || {
                let mut device = dac;

                loop {
                    let frame = context.wait_for_frame();
                    log::debug!("Writing frame");
                    device.write_frame(frame.into()).unwrap();
                    thread::sleep(Duration::from_millis(100));
                }
            });

        HeliosLaser { lock, current_frame: frame_board }
    }
}

impl From<LaserFrame> for helios_dac::Frame {
    fn from(frame: LaserFrame) -> Self {
        helios_dac::Frame {
            points: frame
                .points
                .into_iter()
                .map(helios_dac::Point::from)
                .collect(),
            pps: 30000, // TODO
            flags: helios_dac::WriteFrameFlags::empty(),
        }
    }
}

impl From<LaserPoint> for helios_dac::Point {
    fn from(point: LaserPoint) -> Self {
        helios_dac::Point {
            coordinate: point.coordinate.into(),
            color: point.color.into(),
            intensity: 0xff,
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
            y: coordinate.y as u16,
        }
    }
}
