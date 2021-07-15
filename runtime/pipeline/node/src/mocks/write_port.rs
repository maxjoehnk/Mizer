use std::any::Any;
use std::cell::RefCell;

use mizer_ports::PortValue;

use crate::PortId;

use super::NodeContextMock;

impl NodeContextMock {
    pub fn expect_write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V) {
        self.write_port_fn.expect(port, value)
    }
}

struct WritePortCall {
    port: PortId,
    value: Box<dyn Any>,
}

impl std::fmt::Debug for WritePortCall {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        let mut builder = f.debug_struct("WritePortCall");
        builder.field("port", &self.port);
        if let Some(value) = self.value.downcast_ref::<f64>() {
            builder.field("value", value);
        } else {
            builder.field("value", &self.value);
        }

        builder.finish()
    }
}

#[derive(Default)]
pub struct WritePortFunction {
    calls: RefCell<Vec<WritePortCall>>,
}

impl WritePortFunction {
    pub fn call<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V) {
        let port = port.into();
        self.calls.borrow_mut().push(WritePortCall {
            port,
            value: Box::new(value),
        });
    }

    fn expect<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V) {
        let calls = self.calls.borrow();
        let port = port.into();
        let call = calls
            .iter()
            .find(|call| call.port == port && call.value.downcast_ref() == Some(&value));
        if call.is_none() {
            panic!("No matching call found, got {:?}", calls)
        }
    }
}
