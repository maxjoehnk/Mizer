use super::NodeContextMock;
use crate::PortId;
use mizer_ports::PortValue;
use std::any::Any;

impl NodeContextMock {
    pub fn when_read_port<P: Into<PortId>>(&mut self, port: P) -> ReadPortMatcher {
        ReadPortMatcher {
            function: &mut self.read_port_fn,
            port: port.into(),
        }
    }
}

pub struct ReadPortMatcher<'a> {
    function: &'a mut ReadPortFunction,
    port: PortId,
}

impl<'a> ReadPortMatcher<'a> {
    pub fn returns<V: PortValue + 'static>(self, value: Option<V>) {
        self.function.mock = Some(ReadPortMock {
            port: self.port,
            value: value.map(|value| Box::new(value) as Box<dyn Any>),
        });
    }
}

struct ReadPortMock {
    port: PortId,
    value: Option<Box<dyn Any>>,
}

impl ReadPortMock {
    fn call<V: PortValue + 'static>(&self, port: PortId) -> Option<V> {
        if self.port != port {
            None
        } else {
            self.value
                .as_ref()
                .and_then(|value| value.downcast_ref().cloned())
        }
    }
}

#[derive(Default)]
pub struct ReadPortFunction {
    mock: Option<ReadPortMock>,
}

impl ReadPortFunction {
    pub fn call<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        if let Some(ref mock) = self.mock {
            mock.call(port.into())
        } else {
            unimplemented!()
        }
    }
}
