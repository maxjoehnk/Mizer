use mizer_node::*;
use serde::{Deserialize, Serialize};
use std::sync::{Arc, Mutex};

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct TestSink {
    frames: Arc<Mutex<Vec<f64>>>,
}

impl PartialEq for TestSink {
    fn eq(&self, other: &Self) -> bool {
        Arc::ptr_eq(&self.frames, &other.frames)
    }
}

impl PipelineNode for TestSink {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(TestSink).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
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
            println!("got no port");
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {}

    fn update(&mut self, _config: &Self) {}
}

impl TestSink {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn frames(&self) -> Vec<f64> {
        self.frames.lock().unwrap().clone()
    }
}
