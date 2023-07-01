use std::cmp::Ordering;
use std::collections::HashMap;
use std::ops::Deref;

use itertools::Itertools;
use serde::{Deserialize, Serialize};

use mizer_node::{NodeLink, NodePath, PortId, PortType, ProcessingNode};
use mizer_util::HashMapExtension;

#[derive(Default, Debug, Clone, PartialOrd, PartialEq, Eq, Deserialize, Serialize)]
pub struct ExecutionPlan {
    pub executors: Vec<PlannedExecutor>,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub enum ExecutorCommand {
    AddLink(NodeLink),
    AddNode(ExecutionNode),
    RemoveLink(NodeLink),
    RemoveNode(NodePath),
    RenameNode(NodePath, NodePath),
}

impl ExecutionPlan {
    pub fn get_executor(&self, id: &ExecutorId) -> Option<PlannedExecutor> {
        self.executors
            .iter()
            .find(|executor| &executor.id == id)
            .cloned()
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct PlannedExecutor {
    pub id: ExecutorId,
    pub associated_nodes: Vec<ExecutionNode>,
    pub links: Vec<ExecutorLink>,
    pub commands: Vec<ExecutorCommand>,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct ExecutorLink {
    pub source: ExecutorLinkPort,
    pub target: ExecutorLinkPort,
    pub port_type: PortType,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct ExecutorLinkPort {
    pub executor: ExecutorId,
    pub node: NodePath,
    pub port: PortId,
}

impl PartialOrd for PlannedExecutor {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.id.cmp(&other.id))
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct Executor {
    pub id: ExecutorId,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct ExecutionNode {
    pub path: NodePath,
    pub attached_executor: Option<ExecutorId>,
}

impl<T: ProcessingNode> From<(NodePath, &T)> for ExecutionNode {
    fn from((path, _): (NodePath, &T)) -> Self {
        ExecutionNode {
            path,
            attached_executor: None,
        }
    }
}

impl PartialOrd for ExecutionNode {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.path.cmp(&other.path))
    }
}

#[derive(Debug, Clone, Hash, PartialOrd, Ord, PartialEq, Eq, Deserialize, Serialize)]
pub struct ExecutorId(pub String);

impl From<String> for ExecutorId {
    fn from(path: String) -> Self {
        Self(path)
    }
}

impl From<&str> for ExecutorId {
    fn from(path: &str) -> Self {
        Self(path.to_string())
    }
}

impl Deref for ExecutorId {
    type Target = String;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

#[derive(Debug, Clone, Default)]
pub struct ExecutionPlanner {
    pub(crate) executors: HashMap<ExecutorId, Executor>,
    pub(crate) nodes: HashMap<NodePath, ExecutionNode>,
    pub(crate) links: Vec<NodeLink>,
    commands: Vec<ExecutorCommand>,
    last_plan: Option<ExecutionPlan>,
}

impl ExecutionPlanner {
    pub fn should_rebuild(&self) -> bool {
        !self.commands.is_empty()
    }
}

impl ExecutionPlanner {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn add_executor(&mut self, executor: Executor) {
        self.executors.insert(executor.id.clone(), executor);
    }

    pub fn remove_executor(&mut self, id: &ExecutorId) {
        self.executors.remove(id);
    }

    pub fn add_node(&mut self, node: ExecutionNode) {
        log::trace!("add_node {:?}", node);
        self.commands.push(ExecutorCommand::AddNode(node.clone()));
        self.nodes.insert(node.path.clone(), node);
    }

    pub fn rename_node(&mut self, from: &NodePath, to: NodePath) {
        log::trace!("rename_node {from} to {to}");
        let node = self.nodes.get_mut(from).unwrap();
        node.path = to.clone();
        self.nodes
            .rename_key(from, to.clone())
            .then_some(())
            .unwrap_or_else(|| panic!("Unknown node {to}"));
        for link in self.links.iter_mut() {
            if &link.source == from {
                link.source = to.clone();
            }
            if &link.target == from {
                link.target = to.clone();
            }
        }
        self.commands
            .push(ExecutorCommand::RenameNode(from.clone(), to));
    }

    pub fn add_link(&mut self, link: NodeLink) {
        log::trace!("add_link {:?}", link);
        self.commands.push(ExecutorCommand::AddLink(link.clone()));
        self.links.push(link);
    }

    pub fn remove_link(&mut self, link: &NodeLink) {
        self.commands
            .push(ExecutorCommand::RemoveLink(link.clone()));
        self.links.retain(|l| l != link);
    }

    pub fn remove_node(&mut self, path: &NodePath) {
        log::trace!("remove_node {:?}", path);
        self.commands
            .push(ExecutorCommand::RemoveNode(path.clone()));
        self.nodes.remove(path);
    }

    pub fn clear(&mut self) {
        log::trace!("clear");
        self.nodes.clear();
        self.links.clear();
        self.commands.clear();
        self.last_plan.take();
    }

    pub fn plan(&mut self) -> ExecutionPlan {
        profiling::scope!("ExecutionPlanner::plan");
        let last_plan = self.last_plan.clone().unwrap_or_default();
        let mut executors = self
            .executors
            .values()
            .sorted_by_key(|e| e.id.clone())
            .map(|executor| PlannedExecutor {
                id: executor.id.clone(),
                associated_nodes: Vec::new(),
                links: Default::default(),
                commands: Default::default(),
            })
            .collect::<Vec<_>>();
        let nodes = self.group_nodes();

        let mut i = 0;
        for linked_nodes in nodes {
            for node in linked_nodes.0 {
                if let Some(executor) = node
                    .attached_executor
                    .as_ref()
                    .and_then(|id| executors.iter_mut().find(|e| &e.id == id))
                {
                    executor.associated_nodes.push(node);
                } else {
                    executors[i].associated_nodes.push(node);
                }
            }
            i += 1;
            if i >= executors.len() {
                i = 0;
            }
        }
        for executor in &mut executors {
            for link in &self.links {
                if executor
                    .associated_nodes
                    .iter()
                    .any(|n| link.source == n.path || link.target == n.path)
                {
                    executor.links.push(ExecutorLink {
                        source: ExecutorLinkPort {
                            node: link.source.clone(),
                            port: link.source_port.clone(),
                            executor: executor.id.clone(),
                        },
                        target: ExecutorLinkPort {
                            node: link.target.clone(),
                            port: link.target_port.clone(),
                            executor: executor.id.clone(),
                        },
                        port_type: link.port_type,
                    });
                }
            }
        }

        let mut plan = ExecutionPlan { executors };

        for executor in &mut plan.executors {
            let previous_executor = last_plan
                .executors
                .iter()
                .find(|e| e.id == executor.id)
                .cloned()
                .unwrap_or_else(|| PlannedExecutor {
                    id: executor.id.clone(),
                    associated_nodes: Default::default(),
                    commands: Default::default(),
                    links: Default::default(),
                });
            for node in &executor.associated_nodes {
                if !previous_executor.associated_nodes.contains(node) {
                    executor
                        .commands
                        .push(ExecutorCommand::AddNode(node.clone()));
                } else if let Some(ExecutorCommand::RenameNode(from, to)) =
                    self.commands.iter().find(|command| {
                        if let ExecutorCommand::RenameNode(from, _) = command {
                            from == &node.path
                        } else {
                            false
                        }
                    })
                {
                    executor
                        .commands
                        .push(ExecutorCommand::RenameNode(from.clone(), to.clone()));
                }
            }
            for node in previous_executor.associated_nodes {
                if !executor.associated_nodes.contains(&node) {
                    executor
                        .commands
                        .push(ExecutorCommand::RemoveNode(node.path));
                }
            }
            for link in &executor.links {
                if !previous_executor.links.contains(link) {
                    executor.commands.push(ExecutorCommand::AddLink(NodeLink {
                        source: link.source.node.clone(),
                        source_port: link.source.port.clone(),
                        target: link.target.node.clone(),
                        target_port: link.target.port.clone(),
                        local: true,
                        port_type: link.port_type,
                    }));
                }
            }
            for link in previous_executor.links {
                if !executor.links.contains(&link) {
                    executor
                        .commands
                        .push(ExecutorCommand::RemoveLink(NodeLink {
                            source: link.source.node.clone(),
                            source_port: link.source.port.clone(),
                            target: link.target.node.clone(),
                            target_port: link.target.port.clone(),
                            local: true,
                            port_type: link.port_type,
                        }));
                }
            }
        }

        self.commands.clear();

        self.last_plan = Some(plan.clone());

        plan
    }

    fn group_nodes(&self) -> Vec<LinkedNodes> {
        let mut nodes = vec![];

        let mut local_links = self
            .links
            .iter()
            .filter(|l| l.local)
            .flat_map(|l| vec![l.source.clone(), l.target.clone()]);

        let mut node_group = LinkedNodes(Vec::new());
        for (path, node) in self.nodes.iter().sorted_by_key(|(path, _)| (*path).clone()) {
            if local_links.contains(path) {
                node_group.0.push(node.clone());
            } else {
                nodes.push(LinkedNodes(vec![node.clone()]));
            }
        }
        nodes.push(node_group);
        nodes
    }
}

#[derive(Debug)]
struct LinkedNodes(Vec<ExecutionNode>);

#[cfg(test)]
mod tests {
    use mizer_node::PortType;
    use test_case::test_case;

    use super::*;

    #[test_case("orchestrator")]
    #[test_case("main")]
    fn add_executor_should_add_executor(executor_id: &str) {
        let mut planner = ExecutionPlanner::new();
        let id: ExecutorId = executor_id.into();
        let executor = Executor { id: id.clone() };

        planner.add_executor(executor);

        assert!(planner.executors.contains_key(&id));
    }

    #[test_case("orchestrator")]
    #[test_case("main")]
    fn remove_executor_should_remove_executor(executor_id: &str) {
        let mut planner = ExecutionPlanner::new();
        let id: ExecutorId = executor_id.into();
        let executor = Executor { id: id.clone() };
        planner.add_executor(executor);

        planner.remove_executor(&id);

        assert!(!planner.executors.contains_key(&id));
    }

    #[test_case("/test")]
    #[test_case("/project/node")]
    fn add_node_should_add_node(node_path: &str) {
        let mut planner = ExecutionPlanner::new();
        let path: NodePath = node_path.into();
        let node = ExecutionNode {
            path: path.clone(),
            attached_executor: None,
        };

        planner.add_node(node);

        assert!(planner.nodes.contains_key(&path));
    }

    #[test]
    fn planning_twice_should_not_add_node_twice() {
        let mut planner = ExecutionPlanner::new();
        planner.add_executor(Executor {
            id: ExecutorId("executor".into()),
        });
        let node = ExecutionNode {
            path: "/node".into(),
            attached_executor: None,
        };
        planner.add_node(node);
        planner.plan();

        let plan = planner.plan();

        assert_eq!(Vec::<ExecutorCommand>::new(), plan.executors[0].commands);
    }

    #[test_case("/test")]
    #[test_case("/project/node")]
    fn remove_node_should_remove_node(node_path: &str) {
        let mut planner = ExecutionPlanner::new();
        let path: NodePath = node_path.into();
        let node = ExecutionNode {
            path: path.clone(),
            attached_executor: None,
        };
        planner.add_node(node);

        planner.remove_node(&path);

        assert!(!planner.nodes.contains_key(&path));
    }

    #[test_case("/test", "orchestrator")]
    #[test_case("/project/node", "main")]
    fn single_executor_single_node(node_path: &str, executor_id: &str) {
        let mut planner = ExecutionPlanner::new();
        let node = ExecutionNode {
            path: node_path.into(),
            attached_executor: None,
        };
        planner.add_node(node.clone());
        let executor_id: ExecutorId = executor_id.into();
        planner.add_executor(Executor {
            id: executor_id.clone(),
        });
        let expected = ExecutionPlan {
            executors: vec![PlannedExecutor {
                id: executor_id,
                associated_nodes: vec![node.clone()],
                links: vec![],
                commands: vec![ExecutorCommand::AddNode(node)],
            }],
        };

        let mut plan = planner.plan();
        order_plan(&mut plan);

        assert_eq!(plan, expected);
    }

    #[test]
    fn multiple_executors_one_node_each() {
        let mut planner = ExecutionPlanner::new();
        let node1 = ExecutionNode {
            path: "/node1".into(),
            attached_executor: None,
        };
        let node2 = ExecutionNode {
            path: "/node2".into(),
            attached_executor: None,
        };
        planner.add_node(node1.clone());
        planner.add_node(node2.clone());
        planner.add_executor(Executor {
            id: "executor1".into(),
        });
        planner.add_executor(Executor {
            id: "executor2".into(),
        });
        let expected = ExecutionPlan {
            executors: vec![
                PlannedExecutor {
                    id: "executor1".into(),
                    associated_nodes: vec![node1.clone()],
                    links: vec![],
                    commands: vec![ExecutorCommand::AddNode(node1)],
                },
                PlannedExecutor {
                    id: "executor2".into(),
                    associated_nodes: vec![node2.clone()],
                    links: vec![],
                    commands: vec![ExecutorCommand::AddNode(node2)],
                },
            ],
        };

        let mut plan = planner.plan();
        order_plan(&mut plan);

        assert_eq!(plan, expected);
    }

    #[test]
    fn multiple_nodes_one_executor() {
        let mut planner = ExecutionPlanner::new();
        let node1 = ExecutionNode {
            path: "/node1".into(),
            attached_executor: None,
        };
        let node2 = ExecutionNode {
            path: "/node2".into(),
            attached_executor: None,
        };
        planner.add_node(node1.clone());
        planner.add_node(node2.clone());
        planner.add_executor(Executor {
            id: "orchestrator".into(),
        });
        let expected = ExecutionPlan {
            executors: vec![PlannedExecutor {
                id: "orchestrator".into(),
                associated_nodes: vec![node1.clone(), node2.clone()],
                links: vec![],
                commands: vec![
                    ExecutorCommand::AddNode(node1),
                    ExecutorCommand::AddNode(node2),
                ],
            }],
        };

        let mut plan = planner.plan();
        order_plan(&mut plan);

        assert_eq!(plan, expected);
    }

    #[test]
    fn multiple_executors_attached_nodes() {
        let mut planner = ExecutionPlanner::new();
        let node1 = ExecutionNode {
            path: "/node1".into(),
            attached_executor: Some("executor1".into()),
        };
        let node2 = ExecutionNode {
            path: "/node2".into(),
            attached_executor: Some("executor1".into()),
        };
        planner.add_node(node1.clone());
        planner.add_node(node2.clone());
        planner.add_executor(Executor {
            id: "executor1".into(),
        });
        planner.add_executor(Executor {
            id: "executor2".into(),
        });
        let expected = ExecutionPlan {
            executors: vec![
                PlannedExecutor {
                    id: "executor1".into(),
                    associated_nodes: vec![node1.clone(), node2.clone()],
                    links: vec![],
                    commands: vec![
                        ExecutorCommand::AddNode(node1),
                        ExecutorCommand::AddNode(node2),
                    ],
                },
                PlannedExecutor {
                    id: "executor2".into(),
                    associated_nodes: vec![],
                    links: vec![],
                    commands: vec![],
                },
            ],
        };

        let mut plan = planner.plan();
        order_plan(&mut plan);

        assert_eq!(plan, expected);
    }

    #[test]
    fn multiple_executors_local_linked_nodes() {
        let mut planner = ExecutionPlanner::new();
        let node1 = ExecutionNode {
            path: "/node1".into(),
            attached_executor: None,
        };
        let node2 = ExecutionNode {
            path: "/node2".into(),
            attached_executor: None,
        };
        planner.add_node(node1.clone());
        planner.add_node(node2.clone());
        let link = NodeLink {
            source: "/node1".into(),
            source_port: "".into(),
            target: "/node2".into(),
            target_port: "".into(),
            local: true,
            port_type: PortType::Single,
        };
        planner.add_link(link.clone());
        planner.add_executor(Executor {
            id: "executor1".into(),
        });
        planner.add_executor(Executor {
            id: "executor2".into(),
        });
        let expected = ExecutionPlan {
            executors: vec![
                PlannedExecutor {
                    id: "executor1".into(),
                    associated_nodes: vec![node1.clone(), node2.clone()],
                    links: vec![ExecutorLink {
                        source: ExecutorLinkPort {
                            node: "/node1".into(),
                            executor: "executor1".into(),
                            port: "".into(),
                        },
                        target: ExecutorLinkPort {
                            node: "/node2".into(),
                            executor: "executor1".into(),
                            port: "".into(),
                        },
                        port_type: PortType::Single,
                    }],
                    commands: vec![
                        ExecutorCommand::AddNode(node1),
                        ExecutorCommand::AddNode(node2),
                        ExecutorCommand::AddLink(link),
                    ],
                },
                PlannedExecutor {
                    id: "executor2".into(),
                    associated_nodes: vec![],
                    links: vec![],
                    commands: vec![],
                },
            ],
        };

        let mut plan = planner.plan();
        order_plan(&mut plan);

        assert_eq!(plan, expected);
    }

    #[test]
    fn planning_twice_should_not_add_link_twice() {
        let mut planner = ExecutionPlanner::new();
        planner.add_executor(Executor {
            id: ExecutorId("executor".into()),
        });
        let node1 = ExecutionNode {
            path: "/node1".into(),
            attached_executor: None,
        };
        let node2 = ExecutionNode {
            path: "/node2".into(),
            attached_executor: None,
        };
        planner.add_node(node1);
        planner.add_node(node2);
        let link = NodeLink {
            source: "/node1".into(),
            source_port: "".into(),
            target: "/node2".into(),
            target_port: "".into(),
            local: true,
            port_type: PortType::Single,
        };
        planner.add_link(link);
        planner.plan();

        let plan = planner.plan();

        assert_eq!(Vec::<ExecutorCommand>::new(), plan.executors[0].commands);
    }

    #[test]
    fn removing_link_should_remove_link() {
        let mut planner = ExecutionPlanner::new();
        planner.add_executor(Executor {
            id: ExecutorId("executor".into()),
        });
        let node1 = ExecutionNode {
            path: "/node1".into(),
            attached_executor: None,
        };
        let node2 = ExecutionNode {
            path: "/node2".into(),
            attached_executor: None,
        };
        planner.add_node(node1);
        planner.add_node(node2);
        let link = NodeLink {
            source: "/node1".into(),
            source_port: "".into(),
            target: "/node2".into(),
            target_port: "".into(),
            local: true,
            port_type: PortType::Single,
        };
        planner.add_link(link.clone());
        planner.plan();
        planner.remove_link(&link);

        let plan = planner.plan();

        assert!(!planner.links.contains(&link));
        assert_eq!(
            vec![ExecutorCommand::RemoveLink(link)],
            plan.executors[0].commands
        );
    }

    #[test]
    fn clear_should_not_add_remove_commands_for_nodes() {
        let mut planner = ExecutionPlanner::new();
        planner.add_executor(Executor {
            id: ExecutorId("executor".into()),
        });
        let node = ExecutionNode {
            path: "/node".into(),
            attached_executor: None,
        };
        planner.add_node(node);
        planner.plan();

        planner.clear();
        let plan = planner.plan();

        assert!(plan.executors[0].commands.is_empty());
    }

    #[test]
    fn clear_should_not_add_remove_commands_for_links() {
        let mut planner = ExecutionPlanner::new();
        planner.add_executor(Executor {
            id: ExecutorId("executor".into()),
        });
        let node1 = ExecutionNode {
            path: "/node1".into(),
            attached_executor: None,
        };
        let node2 = ExecutionNode {
            path: "/node2".into(),
            attached_executor: None,
        };
        planner.add_node(node1);
        planner.add_node(node2);
        let link = NodeLink {
            source: "/node1".into(),
            source_port: "".into(),
            target: "/node2".into(),
            target_port: "".into(),
            local: true,
            port_type: PortType::Single,
        };
        planner.add_link(link);
        planner.plan();

        planner.clear();
        let plan = planner.plan();

        assert!(plan.executors[0].commands.is_empty());
    }

    #[test_case("/test", "orchestrator")]
    #[test_case("/project/node", "main")]
    fn remove_single_node_single_executor(node_path: &str, executor_id: &str) {
        let mut planner = ExecutionPlanner::new();
        let node = ExecutionNode {
            path: node_path.into(),
            attached_executor: None,
        };
        planner.add_node(node);
        let executor_id: ExecutorId = executor_id.into();
        planner.add_executor(Executor {
            id: executor_id.clone(),
        });
        planner.plan();
        planner.remove_node(&node_path.into());
        let expected = ExecutionPlan {
            executors: vec![PlannedExecutor {
                id: executor_id,
                associated_nodes: vec![],
                links: vec![],
                commands: vec![ExecutorCommand::RemoveNode(node_path.into())],
            }],
        };

        let mut plan = planner.plan();
        order_plan(&mut plan);

        assert_eq!(plan, expected);
    }

    fn order_plan(plan: &mut ExecutionPlan) {
        plan.executors.sort_by_key(|e| e.id.clone());
        for executor in plan.executors.iter_mut() {
            executor.associated_nodes.sort_by_key(|n| n.path.clone());
        }
    }
}
