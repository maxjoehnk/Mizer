use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, InjectorRef, RefMut, sub_command};
use mizer_node::{Injector, NodeLink};
use mizer_ports::PortType;
use mizer_runtime::commands::{AddLinkCommand, AddNodeCommand};
use mizer_runtime::{Pipeline};

use crate::{NodeRequest, NodeTemplate};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ExecuteNodeTemplateCommand {
    pub template: NodeTemplate,
}

impl<'a> Command<'a> for ExecuteNodeTemplateCommand {
    type Dependencies = (RefMut<Pipeline>, InjectorRef);
    type State = (
        Vec<sub_command!(AddNodeCommand)>,
        Vec<sub_command!(AddLinkCommand)>,
    );
    type Result = ();

    fn label(&self) -> String {
        format!("Add node template {:?}", self.template)
    }

    fn apply(
        &self,
        (pipeline, injector): (&mut Pipeline, &Injector),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut node_paths = HashMap::new();
        let mut new_nodes = vec![];
        let mut links = vec![];
        for (template_ref, node) in self.template.nodes.iter() {
            match node {
                NodeRequest::New(node) => new_nodes.push((
                    template_ref.clone(),
                    AddNodeCommand {
                        node_type: node.node_type(),
                        node: Some(node.clone()),
                        designer: Default::default(),
                        parent: None,
                        template: None,
                    },
                )),
                NodeRequest::Existing(path) => {
                    if !pipeline.contains_node(path) {
                        anyhow::bail!("Unknown node {path}");
                    }
                    node_paths.insert(template_ref.clone(), path.clone());
                }
            }
        }
        let nodes = new_nodes
            .into_iter()
            .map(|(template, cmd)| {
                let (_, state) = cmd.apply((pipeline, injector))?;

                node_paths.insert(template, state.clone());

                Ok((cmd, state))
            })
            .collect::<anyhow::Result<Vec<_>>>()?;

        for link in &self.template.links {
            let from_path = node_paths
                .get(&link.from.0)
                .ok_or_else(|| anyhow::anyhow!("Invalid template ref. This is probably a bug."))?;
            let to_path = node_paths
                .get(&link.to.0)
                .ok_or_else(|| anyhow::anyhow!("Invalid template ref. This is probably a bug."))?;
            let cmd = AddLinkCommand {
                link: NodeLink {
                    source: from_path.clone(),
                    source_port: link.from.1.clone(),
                    target: to_path.clone(),
                    target_port: link.to.1.clone(),
                    port_type: PortType::Single, // TODO: get port type from nodes
                    local: false,
                },
            };

            let (_, state) = cmd.apply(pipeline)?;

            links.push((cmd, state));
        }

        Ok(((), (nodes, links)))
    }

    fn revert(
        &self,
        (pipeline, injector): (&mut Pipeline, &Injector),
        (nodes, links): Self::State,
    ) -> anyhow::Result<()> {
        for (link_cmd, link_state) in links {
            link_cmd.revert(pipeline, link_state)?;
        }
        for (node_cmd, node_state) in nodes {
            node_cmd.revert((pipeline, injector), node_state)?;
        }

        Ok(())
    }
}
