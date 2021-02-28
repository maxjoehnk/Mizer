use std::cmp::Ordering;
use std::collections::HashMap;
use std::ops::Deref;

use itertools::Itertools;
use serde::{Deserialize, Serialize};

use mizer_node::{NodeLink, NodePath, ProcessingNode};

#[derive(Debug, Clone, PartialOrd, PartialEq, Eq, Deserialize, Serialize)]
pub struct ExecutionPlan {
    pub executors: Vec<PlannedExecutor>,
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
        self.nodes.insert(node.path.clone(), node);
    }

    pub fn add_link(&mut self, link: NodeLink) {
        self.links.push(link);
    }

    pub fn remove_node(&mut self, path: &NodePath) {
        self.nodes.remove(path);
    }

    pub fn plan(&self) -> ExecutionPlan {
        let mut executors = self
            .executors
            .values()
            .sorted_by_key(|e| e.id.clone())
            .map(|executor| PlannedExecutor {
                id: executor.id.clone(),
                associated_nodes: Vec::new(),
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

        ExecutionPlan { executors }
    }

    fn group_nodes(&self) -> Vec<LinkedNodes> {
        let mut nodes = vec![];

        let local_links = self
            .links
            .iter()
            .filter(|l| l.local)
            .flat_map(|l| vec![l.source.clone(), l.target.clone()])
            .collect::<Vec<_>>();

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
                id: executor_id.clone(),
                associated_nodes: vec![node],
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
                    associated_nodes: vec![node1],
                },
                PlannedExecutor {
                    id: "executor2".into(),
                    associated_nodes: vec![node2],
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
                associated_nodes: vec![node1, node2],
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
                    associated_nodes: vec![node1, node2],
                },
                PlannedExecutor {
                    id: "executor2".into(),
                    associated_nodes: vec![],
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
        planner.add_link(NodeLink {
            source: "/node1".into(),
            source_port: "".into(),
            target: "/node2".into(),
            target_port: "".into(),
            local: true,
            port_type: PortType::Single,
        });
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
                    associated_nodes: vec![node1, node2],
                },
                PlannedExecutor {
                    id: "executor2".into(),
                    associated_nodes: vec![],
                },
            ],
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
