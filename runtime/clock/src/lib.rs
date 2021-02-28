use std::time::{SystemTime, UNIX_EPOCH};

fn now() -> u128 {
    let time = SystemTime::now();
    let time = time
        .duration_since(UNIX_EPOCH)
        .expect("There shouldn't be a case where the unix epoch is after the current time");

    time.as_millis()
}

#[derive(Debug, Clone)]
pub struct SystemClock {
    /// BPM
    speed: f64,
    last_tick: u128,
    frame: f64,
}

impl Default for SystemClock {
    fn default() -> Self {
        SystemClock {
            speed: 90.,
            last_tick: 0,
            frame: 0.,
        }
    }
}

impl Clock for SystemClock {
    fn tick(&mut self) -> ClockFrame {
        if self.last_tick == 0 {
            self.last_tick = now();
        }
        let tick = now();
        let delta: f64 = (tick - self.last_tick) as f64 * (self.speed / 60000f64);
        self.frame += delta;
        let downbeat = self.frame > 4f64;
        while self.frame > 4f64 {
            self.frame -= 4f64;
        }
        self.last_tick = tick;

        ClockFrame {
            speed: self.speed,
            frame: self.frame,
            delta,
            downbeat,
        }
    }

    fn speed(&self) -> f64 {
        self.speed
    }

    fn speed_mut(&mut self) -> &mut f64 {
        &mut self.speed
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct ClockFrame {
    pub speed: f64,
    pub frame: f64,
    pub delta: f64,
    pub downbeat: bool,
}

pub trait Clock {
    fn tick(&mut self) -> ClockFrame;

    fn speed(&self) -> f64;
    fn speed_mut(&mut self) -> &mut f64;
}
