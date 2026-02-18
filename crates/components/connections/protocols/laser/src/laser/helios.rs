use super::*;
use ::helios_dac::NativeHeliosDac;
use pinboard::Pinboard;
use std::convert::{TryFrom, TryInto};
use std::sync::{Arc, Condvar, Mutex};
use std::thread;
use std::time::Duration;
use mizer_connection_contracts::{IConnection, RemoteConnectionStorageHandle, TransmissionStateSender};

pub struct HeliosLaser {
    current_frame: Arc<Pinboard<LaserFrame>>,
    lock: Arc<(Mutex<bool>, Condvar)>,
    pub name: String,
    pub firmware: u32,
}

impl IConnection for HeliosLaser {
    type Config = NativeHeliosDac;
    const TYPE: &'static str = "helios";

    fn create(device: Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self> {
        let device = device.open()?;

        device.try_into()
    }
}

impl HeliosLaser {
    pub fn find_devices(sender: RemoteConnectionStorageHandle<HeliosLaser>) -> anyhow::Result<()> {
        let controller = helios_dac::NativeHeliosDacController::new()?;
        let devices = controller.list_devices()?;
        for device in devices {
            let device = device.open()?;
            let name = device.name()?;
            sender.add_connection(device, Some(name))?;
        }

        Ok(())
    }
}

impl Laser for HeliosLaser {
    fn write_frame(&mut self, frame: LaserFrame) -> anyhow::Result<()> {
        tracing::debug!("Queuing frame");
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

impl TryFrom<helios_dac::NativeHeliosDac> for HeliosLaser {
    type Error = anyhow::Error;

    fn try_from(dac: NativeHeliosDac) -> anyhow::Result<Self> {
        let lock = Arc::new((Mutex::new(false), Condvar::new()));
        let frame_board = Arc::new(Pinboard::<LaserFrame>::new_empty());
        let context = HeliosLaserContext::new(&lock, &frame_board);
        let name = dac.name()?;
        let firmware = dac.firmware_version()?;

        thread::Builder::new()
            .name("HeliosLaserWorker".to_string())
            .spawn(move || {
                let mut device = dac;

                loop {
                    let frame = context.wait_for_frame();
                    tracing::debug!("Writing frame");
                    device.write_frame(frame.into()).unwrap();
                    thread::sleep(Duration::from_millis(100));
                }
            })?;

        Ok(HeliosLaser {
            lock,
            current_frame: frame_board,
            name,
            firmware,
        })
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
