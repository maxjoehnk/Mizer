use serde::{Deserialize, Serialize};
use mizer_commander::{Query};
use mizer_docs::{get_node_description, list_node_settings};
use mizer_node::{NodeCategory, NodeType};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListAvailableNodesQuery;

impl<'a> Query<'a> for ListAvailableNodesQuery {
    type Dependencies = ();
    type Result = Vec<AvailableNodeDescriptor>;

    fn query(&self, (): ()) -> anyhow::Result<Self::Result> {
        let nodes = enum_iterator::all::<NodeType>()
            .filter(|node_type| node_type != &NodeType::TestSink)
            .map(|node_type| {
                let node: mizer_nodes::Node = node_type.into();
                let details = node.details();
                let node_type_name = node_type.get_name();
                let description = get_node_description(&node_type_name);
                let settings = list_node_settings(&node_type_name).map(|s| s.collect::<Vec<_>>());

                AvailableNodeDescriptor {
                    name: details.node_type_name,
                    category: details.category,
                    node_type,
                    node_type_name,
                    description,
                    settings: settings.unwrap_or_default(),
                }
            })
            .collect();

        Ok(nodes)
    }
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct AvailableNodeDescriptor {
    pub name: String,
    pub category: NodeCategory,
    pub node_type: NodeType,
    pub node_type_name: String,
    pub description: Option<&'static str>,
    pub settings: Vec<(&'static str, &'static str)>,
}
