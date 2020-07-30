use mizer_node_api::*;
use rhai::{Engine, AST, Scope, Map};
use rhai::packages::{BasicMapPackage, Package, CorePackage};

pub struct ScriptingNode<'a> {
    engine: Engine,
    scope: Scope<'a>,
    ast: AST,
    outputs: Vec<NumericSender>,
    inputs: Vec<NumericChannel>,
}

impl<'a> ScriptingNode<'a> {
    pub fn new(script: &str) -> Self {
        let mut engine = Engine::new();
        let ast = engine.compile(script).unwrap();
        let mut scope = Scope::new();
        scope.set_value("state", Map::new());
        scope.set_value("outputs", Map::new());

        ScriptingNode {
            engine,
            ast,
            scope,
            outputs: Vec::new(),
            inputs: Vec::new(),
        }
    }
}

impl<'a> ProcessingNode for ScriptingNode<'a> {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("ScriptingNode")
    }

    fn process(&mut self) {
        let mut input = None;
        for channel in &self.inputs {
            input = channel.recv_all().unwrap().last().copied();
        }
        if let Some(input) = input {
            self.scope.set_value("input", input);
        }
        match self.engine.call_fn::<_, f64>(&mut self.scope, &self.ast, "main", ()) {
            Ok(result) => {
                for sender in &self.outputs {
                    sender.send(result);
                }
            },
            Err(e) => eprintln!("{:?}", e)
        }
    }
}
impl<'a> InputNode for ScriptingNode<'a> {
    fn connect_numeric_input(&mut self, channel: NumericChannel) {
        self.inputs.push(channel);
    }
}
impl<'a> OutputNode for ScriptingNode<'a> {
    fn connect_to_numeric_input(&mut self, input: &mut impl InputNode) {
        let (sender, channel) = NumericChannel::new();
        input.connect_numeric_input(channel);
        self.outputs.push(sender);
    }
}
