use std::collections::HashMap;
use mizer::logger;
use mizer::{build_runtime, Flags};
use mizer_command_executor::*;
use mizer_fixtures::programmer::{PresetId, ProgrammedPreset};
use mizer_fixtures::GroupId;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodePosition, NodeType, PortType};
use mizer_nodes::*;
use serde_derive::{Deserialize, Serialize};
use std::ops::Deref;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{mpsc, Arc};
use tera::Tera;
use mizer_layouts::{ControlPosition, ControlType};

fn main() -> anyhow::Result<()> {
    let flags = Flags::default();
    let _ = logger::init(&flags);
    let tokio_rt = tokio::runtime::Runtime::new()?;

    let (tx, rx) = mpsc::channel();
    let handle = tokio_rt.handle().clone();

    let run = Arc::new(AtomicBool::new(true));
    let background_run = Arc::clone(&run);

    let background_thread = std::thread::Builder::new()
        .name("Pipeline Runtime".into())
        .spawn(move || {
            let _guard = handle.enter();

            let (mut mizer, api_handler) =
                build_runtime(handle.clone(), flags).unwrap_or_else(|e| {
                    tracing::error!("Failed to build runtime: {}", e);
                    std::process::exit(1);
                });
            tx.send(mizer.handlers.runtime.clone()).unwrap_or_else(|e| {
                tracing::error!("Failed to send runtime handle: {}", e);
                std::process::exit(1);
            });

            if mizer.project_path.is_none() {
                tracing::warn!("No project path specified, exiting.");
                std::process::exit(0);
            }

            while background_run.load(Ordering::Relaxed) {
                mizer.process(&api_handler);
            }

            mizer.save_project().unwrap();
        })?;

    let runtime = rx.recv()?;

    let config = serde_yaml::from_str::<Config>(include_str!("../color-mixer.yml"))?;

    if let Err(err) = apply_commands(&runtime, config) {
        tracing::error!("Failed to apply commands: {}", err);
        std::process::exit(1);
    }

    run.store(false, Ordering::Relaxed);

    background_thread.join().unwrap();

    Ok(())
}

fn apply_commands(executor: &impl ICommandExecutor, config: Config) -> anyhow::Result<()> {
    for color_mixer in config.color_mixer {
        let sequence_id = create_sequence(executor, &color_mixer)?;
        let container_path = create_container(executor, &color_mixer)?;
        let sequencer_node = executor.run_command(AddNodeCommand {
            parent: Some(container_path.clone()),
            node_type: NodeType::Sequencer,
            designer: Default::default(),
            node: Some(SequencerNode { sequence_id }.into()),
            template: None,
        })?;
        let constant_node = executor.run_command(AddNodeCommand {
            parent: Some(container_path.clone()),
            node_type: NodeType::ConstantNumber,
            designer: NodeDesigner {
                position: NodePosition {
                    x: -5.,
                    y: 0.
                },
                ..Default::default()
            },
            node: Some(ConstantNumberNode { value: 1. }.into()),
            template: None,
        })?;
        executor.run_command(AddLinkCommand {
            link: NodeLink {
                port_type: PortType::Single,
                target: sequencer_node.path.clone(),
                target_port: "Playback".into(),
                source: constant_node.path.clone(),
                source_port: "Value".into(),
                local: true
            }
        })?;
        let merge_node = executor.run_command(AddNodeCommand {
            parent: Some(container_path.clone()),
            node_type: NodeType::Merge,
            designer: NodeDesigner {
                position: NodePosition {
                    x: -5.,
                    y: 2.
                },
                ..Default::default()
            },
            node: Some(MergeNode {
                mode: MergeMode::Latest
            }.into()),
            template: None,
        })?;
        executor.run_command(AddLinkCommand {
            link: NodeLink {
                port_type: PortType::Single,
                target: sequencer_node.path.clone(),
                target_port: "Cue".into(),
                source: merge_node.path.clone(),
                source_port: "Output".into(),
                local: true
            }
        })?;

        let preset_nodes = create_preset_nodes(executor, &color_mixer, &container_path)?;
        let button_nodes = create_button_nodes(executor, &color_mixer, &container_path, &preset_nodes, &merge_node.path)?;
        let threshold_nodes = create_threshold_nodes(executor, &color_mixer, &container_path, &sequencer_node.path)?;

        create_osc_nodes(executor, &color_mixer, &container_path, &button_nodes, &preset_nodes, &threshold_nodes)?;

        if let Some(layout_config) = color_mixer.layout {
            let label_node = executor.run_command(AddNodeCommand {
                parent: Some(container_path.clone()),
                node_type: NodeType::Label,
                designer: NodeDesigner {
                    position: NodePosition {
                        x: -20.,
                        y: -10.
                    },
                    ..Default::default()
                },
                node: Some(LabelNode {
                    text: format!("{} Colors", color_mixer.name).into(),
                }.into()),
                template: None,
            })?;

            executor.run_command(AddLayoutControlCommand {
                control_type: ControlType::Node {
                    path: label_node.path,
                },
                position: ControlPosition {
                    x: layout_config.column as u64,
                    y: layout_config.row as u64,
                },
                layout_id: layout_config.view.clone(),
            })?;

            for (i, color) in (color_mixer.colors.from..=color_mixer.colors.to).enumerate() {
                executor.run_command(AddLayoutControlCommand {
                    control_type: ControlType::Node {
                        path: button_nodes[&color].clone(),
                    },
                    position: ControlPosition {
                        x: layout_config.column as u64 + 1 + i as u64,
                        y: layout_config.row as u64,
                    },
                    layout_id: layout_config.view.clone(),
                })?;
            }
        }

    }
    Ok(())
}

fn create_container(executor: &impl ICommandExecutor, config: &ColorMixerConfig) -> anyhow::Result<NodePath> {
    let container = executor.run_command(AddNodeCommand {
        designer: Default::default(),
        node: None,
        node_type: NodeType::Container,
        parent: None,
        template: None,
    })?;
    let container_name = NodePath::from(format!("/{}-color-picker", config.name.to_lowercase().replace(" ", "-")));
    executor.run_command(RenameNodeCommand {
        path: container.path,
        new_name: container_name.clone(),
    })?;

    Ok(container_name)
}

fn create_sequence(
    executor: &impl ICommandExecutor,
    config: &ColorMixerConfig,
) -> anyhow::Result<u32> {
    tracing::info!("Creating sequence: {} Colors", config.name);
    let sequence = executor.run_command(AddSequenceCommand {})?;
    executor.run_command(RenameSequenceCommand {
        name: format!("{} Colors", config.name),
        sequence_id: sequence.id,
    })?;
    let presets = executor.execute_query(ListColorPresetsQuery {})?;
    let groups = executor.execute_query(ListGroupsQuery {})?;
    let group = groups
        .into_iter()
        .find(|g| g.id == config.group)
        .ok_or_else(|| anyhow::anyhow!("Group not found"))?;
    for (i, color) in (config.colors.from..=config.colors.to).enumerate() {
        executor.run_command(StoreProgrammerInSequenceCommand {
            sequence_id: sequence.id,
            presets: vec![ProgrammedPreset {
                preset_id: PresetId::Color(color),
                fixtures: group.selection.deref().clone(),
            }],
            controls: Default::default(),
            cue_id: Default::default(),
            effects: Default::default(),
            store_mode: StoreMode::AddCue,
        })?;
        let cue_id = i as u32 + 1;
        let name = presets.iter().find_map(|(id, preset)| {
            let PresetId::Color(c) = id else {
                return None;
            };
            if *c == color {
                    preset.label.clone()
            } else {
                None
            }
        });
        if let Some(name) = name {
            executor.run_command(RenameCueCommand {
                sequence_id: sequence.id,
                cue_id,
                name,
            })?;
        }
    }

    Ok(sequence.id)
}

fn create_preset_nodes(
    executor: &impl ICommandExecutor,
    config: &ColorMixerConfig,
    parent: &NodePath,
) -> anyhow::Result<HashMap<u32, NodePath>> {
    let mut preset_nodes = HashMap::new();

    for color in config.colors.from..=config.colors.to {
        let node = executor.run_command(AddNodeCommand {
            parent: Some(parent.clone()),
            node_type: NodeType::Preset,
            designer: NodeDesigner {
                position: NodePosition {
                    x: -25.,
                    y: (color as f64 - 1.) * 3. + 1.5,
                },
                ..Default::default()
            },
            node: Some(PresetNode {
                id: PresetId::Color(color)
            }.into()),
            template: None,
        })?;

        preset_nodes.insert(color, node.path);
    }

    Ok(preset_nodes)
}

fn create_button_nodes(
    executor: &impl ICommandExecutor,
    config: &ColorMixerConfig,
    parent: &NodePath,
    preset_nodes: &HashMap<u32, NodePath>,
    target_path: &NodePath,
) -> anyhow::Result<HashMap<u32, NodePath>> {
    let mut button_nodes = HashMap::new();

    for (i, color) in (config.colors.from..=config.colors.to).enumerate() {
        let node = executor.run_command(AddNodeCommand {
            parent: Some(parent.clone()),
            node_type: NodeType::Button,
            designer: NodeDesigner {
                position: NodePosition {
                    x: -20.,
                    y: (color as f64 - 1.) * 3.,
                },
                ..Default::default()
            },
            node: Some(ButtonNode {
                high_value: i as f64 + 1.,
                ..Default::default()
            }.into()),
            template: None,
        })?;

        button_nodes.insert(color, node.path.clone());

        executor.run_command(AddLinkCommand {
            link: NodeLink {
                port_type: PortType::Color,
                source: preset_nodes[&color].clone(),
                source_port: "Color".into(),
                target: node.path.clone(),
                target_port: "Color".into(),
                local: true
            }
        })?;
        executor.run_command(AddLinkCommand {
            link: NodeLink {
                port_type: PortType::Single,
                source: node.path.clone().clone(),
                source_port: "Output".into(),
                target: target_path.clone(),
                target_port: "Inputs".into(),
                local: true
            }
        })?;
    }

    Ok(button_nodes)
}

fn create_threshold_nodes(
    executor: &impl ICommandExecutor,
    config: &ColorMixerConfig,
    parent: &NodePath,
    sequencer_path: &NodePath,
) -> anyhow::Result<HashMap<u32, NodePath>> {
    let mut threshold_nodes = HashMap::new();

    for (i, color) in (config.colors.from..=config.colors.to).enumerate() {
        tracing::info!("Creating threshold node for color {}", color);
        let node = executor.run_command(AddNodeCommand {
            parent: Some(parent.clone()),
            node_type: NodeType::Threshold,
            designer: NodeDesigner {
                position: NodePosition {
                    x: 5.,
                    y: (color as f64 - 1.) * 3.,
                },
                ..Default::default()
            },
            node: Some(ThresholdNode {
                lower_threshold: i as f64 + 1.,
                upper_threshold: i as f64 + 2.,
                ..Default::default()
            }.into()),
            template: None,
        })?;

        executor.run_command(AddLinkCommand {
            link: NodeLink {
                port_type: PortType::Single,
                source: sequencer_path.clone(),
                source_port: "Cue".into(),
                target: node.path.clone(),
                target_port: "Input".into(),
                local: true
            }
        })?;

        threshold_nodes.insert(color, node.path.clone());
    }

    Ok(threshold_nodes)
}

fn create_osc_nodes(
    executor: &impl ICommandExecutor,
    config: &ColorMixerConfig,
    parent: &NodePath,
    button_nodes: &HashMap<u32, NodePath>,
    preset_nodes: &HashMap<u32, NodePath>,
    threshold_nodes: &HashMap<u32, NodePath>,
) -> anyhow::Result<()> {
    if let Some(osc_config) = config.osc.as_ref() {
        for (i, color) in (config.colors.from..=config.colors.to).enumerate() {
            if let Some(input_config) = osc_config.input.as_ref() {
                tracing::info!("Creating OSC input for color {}", color);
                let node = executor.run_command(AddNodeCommand {
                    parent: Some(parent.clone()),
                    node_type: NodeType::OscInput,
                    designer: NodeDesigner {
                        position: NodePosition {
                            x: -25.,
                            y: (color as f64 - 1.) * 3.,
                        },
                        ..Default::default()
                    },
                    node: Some(OscInputNode {
                        connection: osc_config.connection.clone(),
                        path: template(input_config, TemplateContext { i })?,
                        argument_type: OscArgumentType::Float,
                    }.into()),
                    template: None,
                })?;

                executor.run_command(AddLinkCommand {
                    link: NodeLink {
                        port_type: PortType::Single,
                        source: node.path.clone(),
                        source_port: "Number".into(),
                        target: button_nodes[&color].clone(),
                        target_port: "Input".into(),
                        local: true
                    }
                })?;
            }

            if let Some(output_config) = osc_config.out.as_ref() {
                tracing::info!("Creating OSC output for color {}", color);
                let node = executor.run_command(AddNodeCommand {
                    parent: Some(parent.clone()),
                    node_type: NodeType::OscOutput,
                    designer: NodeDesigner {
                        position: NodePosition {
                            x: 10.,
                            y: (color as f64 - 1.) * 3.,
                        },
                        ..Default::default()
                    },
                    node: Some(OscOutputNode {
                        connection: osc_config.connection.clone(),
                        argument_type: OscArgumentType::Float,
                        path: template(&output_config.value, TemplateContext { i })?,
                        only_emit_changes: false,
                    }.into()),
                    template: None,
                })?;

                executor.run_command(AddLinkCommand {
                    link: NodeLink {
                        port_type: PortType::Single,
                        source: threshold_nodes[&color].clone(),
                        source_port: "Output".into(),
                        target: node.path.clone(),
                        target_port: "Number".into(),
                        local: true
                    }
                })?;

                if let Some(color_config) = &output_config.color {
                    let color_split_node = executor.run_command(AddNodeCommand {
                        parent: Some(parent.clone()),
                        node_type: NodeType::ColorToRgb,
                        designer: NodeDesigner {
                            position: NodePosition {
                                x: 15.,
                                y: (color as f64 - 1.) * 3.,
                            },
                            ..Default::default()
                        },
                        node: None,
                        template: None,
                    })?;
                    let red_osc_node = executor.run_command(AddNodeCommand {
                        parent: Some(parent.clone()),
                        node_type: NodeType::OscOutput,
                        designer: NodeDesigner {
                            position: NodePosition {
                                x: 20.,
                                y: (color as f64 - 1.) * 3. - 1.,
                            },
                            ..Default::default()
                        },
                        node: Some(OscOutputNode {
                            connection: osc_config.connection.clone(),
                            argument_type: OscArgumentType::Float,
                            path: template(&color_config.red, TemplateContext { i })?,
                            only_emit_changes: false,
                        }.into()),
                        template: None,
                    })?;
                    let green_osc_node = executor.run_command(AddNodeCommand {
                        parent: Some(parent.clone()),
                        node_type: NodeType::OscOutput,
                        designer: NodeDesigner {
                            position: NodePosition {
                                x: 20.,
                                y: (color as f64 - 1.) * 3.,
                            },
                            ..Default::default()
                        },
                        node: Some(OscOutputNode {
                            connection: osc_config.connection.clone(),
                            argument_type: OscArgumentType::Float,
                            path: template(&color_config.green, TemplateContext { i })?,
                            only_emit_changes: false,
                        }.into()),
                        template: None,
                    })?;
                    let blue_osc_node = executor.run_command(AddNodeCommand {
                        parent: Some(parent.clone()),
                        node_type: NodeType::OscOutput,
                        designer: NodeDesigner {
                            position: NodePosition {
                                x: 20.,
                                y: (color as f64 - 1.) * 3. + 1.,
                            },
                            ..Default::default()
                        },
                        node: Some(OscOutputNode {
                            connection: osc_config.connection.clone(),
                            argument_type: OscArgumentType::Float,
                            path: template(&color_config.blue, TemplateContext { i })?,
                            only_emit_changes: false,
                        }.into()),
                        template: None,
                    })?;
                    executor.run_command(AddLinkCommand {
                        link: NodeLink {
                            port_type: PortType::Color,
                            source: preset_nodes[&color].clone(),
                            source_port: "Color".into(),
                            target: color_split_node.path.clone(),
                            target_port: "Color".into(),
                            local: true
                        }
                    })?;
                    executor.run_command(AddLinkCommand {
                        link: NodeLink {
                            port_type: PortType::Single,
                            source: color_split_node.path.clone(),
                            source_port: "Red".into(),
                            target: red_osc_node.path.clone(),
                            target_port: "Number".into(),
                            local: true
                        }
                    })?;
                    executor.run_command(AddLinkCommand {
                        link: NodeLink {
                            port_type: PortType::Single,
                            source: color_split_node.path.clone(),
                            source_port: "Green".into(),
                            target: green_osc_node.path.clone(),
                            target_port: "Number".into(),
                            local: true
                        }
                    })?;
                    executor.run_command(AddLinkCommand {
                        link: NodeLink {
                            port_type: PortType::Single,
                            source: color_split_node.path.clone(),
                            source_port: "Blue".into(),
                            target: blue_osc_node.path.clone(),
                            target_port: "Number".into(),
                            local: true
                        }
                    })?;
                }
            }
        }
    }

    Ok(())
}

fn template(input: &str, context: TemplateContext) -> anyhow::Result<String> {
    let result = Tera::one_off(input, &tera::Context::from_serialize(context)?, true)
        .map_err(|e| anyhow::anyhow!("Failed to render template: {}", e))?;

    Ok(result)
}

#[derive(Debug, Clone, Copy, Serialize)]
struct TemplateContext {
    pub i: usize,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
struct Config {
    pub color_mixer: Vec<ColorMixerConfig>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
struct ColorMixerConfig {
    pub name: String,
    pub group: GroupId,
    pub colors: PresetRange,
    #[serde(default)]
    pub layout: Option<LayoutConfig>,
    #[serde(default)]
    pub osc: Option<OscConfig>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
struct PresetRange {
    pub from: u32,
    pub to: u32,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct LayoutConfig {
    pub view: String,
    pub column: u32,
    pub row: u32,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct OscConfig {
    pub connection: String,
    #[serde(alias = "in")]
    pub input: Option<String>,
    pub out: Option<OscOutputConfig>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct OscOutputConfig {
    pub value: String,
    pub color: Option<OscColorConfig>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct OscColorConfig {
    pub red: String,
    pub green: String,
    pub blue: String,
}
