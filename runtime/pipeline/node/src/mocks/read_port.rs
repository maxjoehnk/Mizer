use super::NodeContextMock;
use crate::PortId;
use mizer_ports::PortValue;
use std::any::Any;
use std::collections::HashMap;

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
        self.function.mocks.insert(
            self.port,
            ReadPortMock {
                value: value.map(|value| Box::new(value) as Box<dyn Any>),
            },
        );
    }
}

#[derive(Debug)]
struct ReadPortMock {
    value: Option<Box<dyn Any>>,
}

impl ReadPortMock {
    fn call<V: PortValue + 'static>(&self) -> Option<V> {
        self.value
            .as_ref()
            .and_then(|value| value.downcast_ref().cloned())
    }
}

#[derive(Default)]
pub struct ReadPortFunction {
    mocks: HashMap<PortId, ReadPortMock>,
}

impl ReadPortFunction {
    pub fn call<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        let port = port.into();
        let mock = self.mocks.get(&port);

        if let Some(mock) = mock {
            mock.call()
        } else {
            unimplemented!()
        }
    }
}
