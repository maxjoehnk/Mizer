pub use crate::command::ExecuteNodeTemplateCommand;
use mizer_node::NodePath;
use mizer_nodes::Node;
use mizer_ports::PortId;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::hash::{Hash, Hasher};

mod command;
pub mod mappings;

#[derive(Debug, Clone, Hash, Eq, PartialEq, Serialize, Deserialize)]
#[repr(transparent)]
pub struct TemplateRef(String);

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NodeTemplate {
    pub nodes: HashMap<TemplateRef, NodeRequest>,
    pub links: Vec<LinkTemplate>,
}

impl Hash for NodeTemplate {
    fn hash<H: Hasher>(&self, state: &mut H) {
        for (template_ref, node) in self.nodes.iter() {
            template_ref.hash(state);
            node.hash(state);
        }
        for link in self.links.iter() {
            link.hash(state);
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct LinkTemplate {
    pub from: (TemplateRef, PortId),
    pub to: (TemplateRef, PortId),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum NodeRequest {
    Existing(NodePath),
    New(Node),
}

impl Hash for NodeRequest {
    fn hash<H: Hasher>(&self, state: &mut H) {
        match self {
            Self::Existing(path) => {
                state.write_u8(0);
                path.hash(state);
            }
            Self::New(node) => {
                state.write_u8(1);
                node.node_type().hash(state);
            }
        }
    }
}

#[macro_export]
macro_rules! node_templates {
    ($( $key: expr => $val: expr ),*) => {{
         let mut map = ::std::collections::HashMap::new();
         $( map.insert(TemplateRef($key.into()), $val); )*
         map
    }}
}

#[macro_export]
macro_rules! link_template {
    ($from_node: expr, $from_port: expr => $to_node: expr, $to_port: expr) => {{
        let from = (TemplateRef($from_node.into()), PortId($from_port.into()));
        let to = (TemplateRef($to_node.into()), PortId($to_port.into()));

        LinkTemplate { from, to }
    }};
}
