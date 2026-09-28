use mizer_node::mocks::{MockNodeContext, MockNodeSetting};
use mizer_node::{NodeSetting, ProcessingNode};
use mizer_pipeline_nodes::IsCueActiveNode;
use mizer_sequencer::{Cue, Sequence, Sequencer, SequenceState};
use std::collections::{HashMap, HashSet};
use mizer_node::Injector;

#[test]
fn test_is_cue_active_node_active_cue() {
    let mut node = IsCueActiveNode {
        sequence_id: 1,
        cue_id: 101,
    };

    let mut sequencer = Sequencer::default();
    sequencer.add_sequence(Sequence {
        id: 1,
        name: "Test Sequence".to_string(),
        cues: vec![Cue {
            id: 101,
            name: "Test Cue".to_string(),
            ..Default::default()
        }],
        ..Default::default()
    });

    let mut sequence_state_map = HashMap::new();
    sequence_state_map.insert(
        1,
        SequenceState {
            active: true,
            cue_id: Some(101),
            active_cues: HashSet::from([101]),
            ..Default::default()
        },
    );
    sequencer.set_sequencer_view(sequence_state_map);

    let mut injector = Injector::new();
    injector.provide(sequencer);


    let mut context = MockNodeContext::new(&injector);
    let mut state = node.create_state();

    node.process(&context, &mut state).unwrap();

    assert_eq!(context.read_written_port("Active"), Some(1.0));
}

#[test]
fn test_is_cue_active_node_inactive_cue() {
    let mut node = IsCueActiveNode {
        sequence_id: 1,
        cue_id: 102, // Different cue
    };

    let mut sequencer = Sequencer::default();
    sequencer.add_sequence(Sequence {
        id: 1,
        name: "Test Sequence".to_string(),
        cues: vec![
            Cue { id: 101, name: "Active Cue".to_string(), ..Default::default() },
            Cue { id: 102, name: "Inactive Cue".to_string(), ..Default::default() },
        ],
        ..Default::default()
    });

    let mut sequence_state_map = HashMap::new();
    sequence_state_map.insert(
        1,
        SequenceState {
            active: true,
            cue_id: Some(101), // Active cue is 101
            active_cues: HashSet::from([101]),
            ..Default::default()
        },
    );
    sequencer.set_sequencer_view(sequence_state_map);

    let mut injector = Injector::new();
    injector.provide(sequencer);

    let mut context = MockNodeContext::new(&injector);
    let mut state = node.create_state();

    node.process(&context, &mut state).unwrap();

    assert_eq!(context.read_written_port("Active"), Some(0.0));
}

#[test]
fn test_is_cue_active_node_sequence_not_found() {
    let mut node = IsCueActiveNode {
        sequence_id: 99, // Non-existent sequence
        cue_id: 101,
    };

    let sequencer = Sequencer::default(); // Empty sequencer
    let mut injector = Injector::new();
    injector.provide(sequencer);


    let mut context = MockNodeContext::new(&injector);
    let mut state = node.create_state();

    node.process(&context, &mut state).unwrap();

    assert_eq!(context.read_written_port("Active"), Some(0.0));
}

#[test]
fn test_is_cue_active_node_cue_not_in_sequence_state() {
    let mut node = IsCueActiveNode {
        sequence_id: 1,
        cue_id: 103, // Cue exists in sequence definition but not in current active_cues
    };

    let mut sequencer = Sequencer::default();
    sequencer.add_sequence(Sequence {
        id: 1,
        name: "Test Sequence".to_string(),
        cues: vec![
            Cue { id: 101, name: "Cue 1".to_string(), ..Default::default() },
            Cue { id: 103, name: "Cue 3".to_string(), ..Default::default() },
        ],
        ..Default::default()
    });

    let mut sequence_state_map = HashMap::new();
    sequence_state_map.insert( // Sequence is active, but cue 103 is not in active_cues
        1,
        SequenceState {
            active: true,
            cue_id: Some(101),
            active_cues: HashSet::from([101]), // Only cue 101 is active
            ..Default::default()
        },
    );
    sequencer.set_sequencer_view(sequence_state_map);

    let mut injector = Injector::new();
    injector.provide(sequencer);

    let mut context = MockNodeContext::new(&injector);
    let mut state = node.create_state();

    node.process(&context, &mut state).unwrap();

    assert_eq!(context.read_written_port("Active"), Some(0.0));
}

#[test]
fn test_is_cue_active_node_settings_update() {
    let mut node = IsCueActiveNode::default();
    let mut injector = Injector::new();
    injector.provide(Sequencer::default()); // Provide a default sequencer for settings

    let setting_sequence = MockNodeSetting::id("Sequence", 1).into_setting();
    node.update_setting(setting_sequence).unwrap();
    assert_eq!(node.sequence_id, 1);

    let setting_cue = MockNodeSetting::id("Cue", 101).into_setting();
    node.update_setting(setting_cue).unwrap();
    assert_eq!(node.cue_id, 101);
}
