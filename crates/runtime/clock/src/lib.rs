use std::fmt::{Display, Formatter};
use std::time::{Duration, Instant, SystemTime, UNIX_EPOCH};

pub type BoxedClock = Box<dyn Clock>;

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
    beat: f64,
    /// Total frame count
    frames: u64,
    state: ClockState,
    fps: f64,
    tapper: Tapper,
}

impl Default for SystemClock {
    fn default() -> Self {
        SystemClock {
            speed: 90.,
            last_tick: 0,
            frame: 0.,
            beat: 0.,
            frames: 0,
            state: ClockState::Playing,
            fps: 60.,
            tapper: Default::default(),
        }
    }
}

impl Clock for SystemClock {
    fn tick(&mut self) -> ClockFrame {
        if self.last_tick == 0 {
            self.last_tick = now();
        }
        let mut delta: f64 = 0.;
        let mut downbeat = false;
        if self.state == ClockState::Playing {
            let tick = now();
            delta = tick.saturating_sub(self.last_tick) as f64 * (self.speed / 60000f64);
            self.frame += delta;
            self.beat += delta;
            downbeat = self.beat > 4f64;
            while self.beat > 4f64 {
                self.beat -= 4f64;
            }
            self.last_tick = tick;
            self.frames += 1;
        }

        ClockFrame {
            speed: self.speed,
            frame: self.frame,
            beat: self.beat,
            delta,
            downbeat,
            frames: self.frames,
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
            fps: self.fps,
            time: Timecode::new(self.frames, self.fps),
            beat: self.beat,
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

    fn state(&self) -> ClockState {
        self.state
    }

    fn fps(&self) -> f64 {
        self.fps
    }

    fn fps_mut(&mut self) -> &mut f64 {
        &mut self.fps
    }

    fn tap(&mut self) {
        if let Some(speed) = self.tapper.tap() {
            *self.speed_mut() = speed;
        }
    }

    fn resync(&mut self) {
        self.beat = 0.;
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct ClockFrame {
    /// Speed in BPM
    pub speed: f64,
    /// Total count of beats
    pub frame: f64,
    /// Current beat from 0 to 4
    pub beat: f64,
    /// Beats passed since last frame
    pub delta: f64,
    /// Indicates whether this frame was the first beat of a new bar
    pub downbeat: bool,
    pub frames: u64,
}

impl ClockFrame {
    pub fn to_duration(&self, fps: f64) -> Duration {
        let frames = self.frames as f64;
        let seconds = frames / fps;
        let seconds = seconds as u64;
        let frames = frames - (seconds as f64 * fps);
        let nanos = (frames / fps * 1_000_000_000f64) as u32;

        Duration::new(seconds, nanos)
    }
}

impl Default for ClockFrame {
    fn default() -> Self {
        Self {
            speed: 90.,
            frame: 0.,
            beat: 0.,
            delta: 0.,
            downbeat: false,
            frames: 0,
        }
    }
}

pub trait Clock {
    fn tick(&mut self) -> ClockFrame;

    fn speed(&self) -> f64;
    fn speed_mut(&mut self) -> &mut f64;

    fn snapshot(&self) -> ClockSnapshot;

    fn set_state(&mut self, state: ClockState);
    fn state(&self) -> ClockState;

    fn fps(&self) -> f64;
    fn fps_mut(&mut self) -> &mut f64;

    fn tap(&mut self);
    fn resync(&mut self);
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
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
    pub fps: f64,
    pub beat: f64,
}

#[derive(Default, Debug, Clone, Copy, PartialEq, Eq)]
pub struct Timecode {
    pub hours: u64,
    pub minutes: u64,
    pub seconds: u64,
    pub frames: u64,
    pub negative: bool,
}

impl Display for Timecode {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{}{}:{}:{}.{}",
            if self.negative { "-" } else { "" },
            self.hours,
            self.minutes,
            self.seconds,
            self.frames
        )
    }
}

impl Timecode {
    pub const ZERO: Timecode = Timecode::build(0, false, 60);

    pub fn new(frames: u64, fps: f64) -> Self {
        let fps = fps.round() as u64;
        Self::build(frames, false, fps)
    }

    pub fn from_i128(frames: i128, fps: f64) -> Self {
        let fps = fps.round() as u64;
        if frames >= 0 {
            Self::build(frames.min(u64::MAX as i128) as u64, false, fps)
        } else {
            let frames = frames.abs();
            Self::build(frames.min(u64::MAX as i128) as u64, true, fps)
        }
    }

    pub fn from_duration(duration: Duration, fps: f64) -> Self {
        let frames = duration.as_secs_f64() * fps;
        let frames = frames.round() as u64;
        Self::build(frames, false, fps as u64)
    }

    pub fn to_duration(&self, fps: f64) -> Duration {
        let frames = self.frames as f64 / fps;
        let seconds = self.seconds as f64;
        let minutes = self.minutes as f64 * 60f64;
        let hours = self.hours as f64 * 3600f64;

        Duration::from_secs_f64(hours + minutes + seconds + frames)
    }

    const fn build(frames: u64, negative: bool, fps: u64) -> Self {
        let seconds = frames / fps;
        let minutes = seconds / 60;
        let hours = minutes / 60;

        let frames = frames - (seconds * fps);
        let seconds = seconds - (minutes * 60);
        let minutes = minutes - (hours * 60);

        Self {
            hours,
            minutes,
            seconds,
            frames,
            negative,
        }
    }
}

#[derive(Debug, Clone)]
struct Tapper {
    last_tap: Instant,
    bpm: Option<f64>,
    last_bpms: Vec<f64>,
}

impl Default for Tapper {
    fn default() -> Self {
        Self {
            last_tap: Instant::now(),
            bpm: Default::default(),
            last_bpms: Default::default(),
        }
    }
}

impl Tapper {
    fn tap(&mut self) -> Option<f64> {
        let tap = Instant::now();
        let duration = tap - self.last_tap;
        if duration.as_millis() > 2000 {
            self.last_tap = tap;
            self.last_bpms.clear();
            self.bpm = None;

            return None;
        }
        let bpm = 60000f64 / duration.as_millis() as f64;
        self.last_bpms.push(bpm);
        if self.bpm.is_none() {
            self.bpm = Some(bpm);
        } else {
            let bpm_sum: f64 = self.last_bpms.iter().copied().sum();
            let average = bpm_sum / self.last_bpms.len() as f64;

            self.bpm = Some(average);
        }
        self.last_tap = tap;

        self.bpm.map(|bpm| bpm.round())
    }
}
