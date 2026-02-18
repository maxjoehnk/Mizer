use std::sync::{Arc, Mutex};

use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct TestSink {
    frames: Arc<Mutex<Vec<f64>>>,
}

impl PartialEq for TestSink {
    fn eq(&self, other: &Self) -> bool {
        Arc::ptr_eq(&self.frames, &other.frames)
    }
}

impl ConfigurableNode for TestSink {}

impl PipelineNode for TestSink {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: stringify!(TestSink).into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!("input", PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TestSink
    }
}

impl ProcessingNode for TestSink {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port("input") {
            let mut frames = self.frames.lock().unwrap();
            frames.push(value);
        } else {
            println!("got no value in input port");
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {}
}

impl TestSink {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn frames(&self) -> Vec<f64> {
        self.frames.lock().unwrap().clone()
    }
}
