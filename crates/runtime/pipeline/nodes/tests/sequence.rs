use mizer_nodes::SequenceNode;

mod node_grapher;

#[test]
fn sequence() -> anyhow::Result<()> {
    let node = SequenceNode {
        steps: vec![
            (0., 0.).into(),
            (1., 0.5, true).into(),
            (2., 1.).into(),
            (3., 0.75).into(),
            (3.5, 1.).into(),
        ],
    };

    node_grapher::graph_node(node, "sequence")
}
