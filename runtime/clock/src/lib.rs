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
    /// Frame per beat
    frame: f64,
    /// Total frame count
    frames: u64,
    state: ClockState,
}

impl Default for SystemClock {
    fn default() -> Self {
        SystemClock {
            speed: 90.,
            last_tick: 0,
            frame: 0.,
            frames: 0,
            state: ClockState::Playing,
        }
    }
}

impl Clock for SystemClock {
    fn tick(&mut self) -> ClockFrame {
        if self.last_tick == 0 {
            self.last_tick = now();
        }
        let mut delta: f64 = 0.;
        if self.state == ClockState::Playing {
            let tick = now();
            delta = (tick - self.last_tick) as f64 * (self.speed / 60000f64);
            self.frame += delta;
            while self.frame > 4f64 {
                self.frame -= 4f64;
            }
            self.last_tick = tick;
            self.frames += 1;
        }
        let downbeat = self.frame > 4f64;

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

    fn snapshot(&self) -> ClockSnapshot {
        ClockSnapshot {
            speed: self.speed,
            state: self.state,
            time: Timecode::new(self.frames),
        }
    }

    fn set_state(&mut self, state: ClockState) {
        self.state = state;
        self.last_tick = 0;
        if state == ClockState::Stopped {
            self.frame = 0.;
            self.frames = 0;
        }
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

    fn snapshot(&self) -> ClockSnapshot;

    fn set_state(&mut self, state: ClockState);
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum ClockState {
    Stopped,
    Paused,
    Playing,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct ClockSnapshot {
    pub speed: f64,
    pub time: Timecode,
    pub state: ClockState,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Timecode {
    pub hours: u64,
    pub minutes: u64,
    pub seconds: u64,
    pub frames: u64,
}

impl Timecode {
    pub fn new(frames: u64) -> Self {
        let seconds = frames / 60;
        let minutes = seconds / 60;
        let hours = minutes / 60;

        let frames = frames - (seconds * 60);
        let seconds = seconds - (minutes * 60);
        let minutes = minutes - (hours * 60);

        Self {
            frames,
            seconds,
            minutes,
            hours,
        }
    }
}
