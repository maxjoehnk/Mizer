pub use mizer_clock::*;

pub struct TestClock {
    speed: f64,
    frame: f64,
    beat: f64,
    frames: u64,
}

impl Default for TestClock {
    fn default() -> Self {
        TestClock {
            speed: 60.,
            frame: 0.,
            beat: 0.,
            frames: 0,
        }
    }
}

impl Clock for TestClock {
    fn tick(&mut self) -> ClockFrame {
        let delta: f64 = 16.6f64 * (self.speed / 60000f64);
        self.frame += delta;
        self.beat += delta;
        let downbeat = self.beat > 4f64;
        while self.beat > 4f64 {
            self.beat -= 4f64;
        }
        self.frames += 1;

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
            speed: 1.0,
            time: Timecode::new(1),
            state: ClockState::Playing,
        }
    }

    fn set_state(&mut self, _: ClockState) {
        unimplemented!()
    }

    fn state(&self) -> ClockState {
        unimplemented!()
    }
}
