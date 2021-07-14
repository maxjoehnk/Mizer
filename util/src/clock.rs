pub use mizer_clock::*;

pub struct TestClock {
    speed: f64,
    frame: f64,
}

impl Default for TestClock {
    fn default() -> Self {
        TestClock {
            speed: 60.,
            frame: 0.,
        }
    }
}

impl Clock for TestClock {
    fn tick(&mut self) -> ClockFrame {
        let delta: f64 = 16.6f64 * (self.speed / 60000f64);
        self.frame += delta;
        let downbeat = self.frame > 4f64;
        while self.frame > 4f64 {
            self.frame -= 4f64;
        }

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
            speed: 1.0,
            time: Timecode::new(1),
            state: ClockState::Playing
        }
    }

    fn set_state(&mut self, state: ClockState) {
        unimplemented!()
    }
}
