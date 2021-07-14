use std::any::Any;

use mizer_ports::PortValue;

use crate::{ClockFrame, PortId};

use super::NodeContextMock;

impl NodeContextMock {
    pub fn when_clock(&mut self) -> ClockMatcher {
        ClockMatcher {
            function: &mut self.clock_fn,
        }
    }
}

pub struct ClockMatcher<'a> {
    function: &'a mut ClockFunction,
}

impl<'a> ClockMatcher<'a> {
    pub fn returns(self, value: ClockFrame) {
        self.function.mock = Some(ClockMock { value });
    }
}

struct ClockMock {
    value: ClockFrame,
}

impl ClockMock {
    fn call(&self) -> ClockFrame {
        self.value.clone()
    }
}

#[derive(Default)]
pub struct ClockFunction {
    mock: Option<ClockMock>,
}

impl ClockFunction {
    pub fn call(&self) -> ClockFrame {
        if let Some(ref mock) = self.mock {
            mock.call()
        } else {
            unimplemented!()
        }
    }
}
