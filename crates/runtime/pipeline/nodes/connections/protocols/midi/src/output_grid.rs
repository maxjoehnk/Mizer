use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_midi::*;

use crate::{get_devices, get_pages_and_grid};

const INPUT_PORT: &str = "Input";

const DEVICE_SETTING: &str = "Device";
const PAGE_SETTING: &str = "Page";
const ROWS_SETTING: &str = "Rows";
const COLUMNS_SETTING: &str = "Columns";
const X_SETTING: &str = "X";
const Y_SETTING: &str = "Y";
const OFF_STEP_SETTING: &str = "Value Off";
const ON_STEP_SETTING: &str = "Value On";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct MidiOutputGridNode {
    pub device: String,
    pub page: String,
    pub rows: u32,
    pub columns: u32,
    pub x: u32,
    pub y: u32,
    #[serde(default)]
    pub off_step: Option<u8>,
    #[serde(default)]
    pub on_step: Option<u8>,
}

impl ConfigurableNode for MidiOutputGridNode {
    fn settings(&self, injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        let devices = get_devices(injector);
        let (pages, grid_size, mut steps) = get_pages_and_grid(injector, &self.device, &self.page);
        let (max_rows, max_cols) = grid_size.unwrap_or((u32::MAX, u32::MAX));

        let mut settings = vec![
            setting!(select DEVICE_SETTING, &self.device, devices),
            setting!(select PAGE_SETTING, &self.page, pages),
            setting!(ROWS_SETTING, self.rows).max(max_rows).min(0u32),
            setting!(COLUMNS_SETTING, self.columns)
                .max(max_cols)
                .min(0u32),
            setting!(X_SETTING, self.x).min(0u32).max(max_cols),
            setting!(Y_SETTING, self.y).min(0u32).max(max_rows),
        ];
        if let Some(steps) = steps.as_mut() {
            steps.insert(
                0,
                SelectVariant::Item {
                    value: Default::default(),
                    label: Default::default(),
                },
            );
        }

        let selected_on_step = self
            .on_step
            .map(|value| value.to_string())
            .unwrap_or_default();
        let selected_off_step = self
            .off_step
            .map(|value| value.to_string())
            .unwrap_or_default();

        if let Some(steps) = steps {
            settings.push(setting!(select ON_STEP_SETTING, selected_on_step, steps.clone()));
            settings.push(setting!(select OFF_STEP_SETTING, selected_off_step, steps));
        }

        settings
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device);
        update!(select setting, PAGE_SETTING, self.page);
        update!(uint setting, ROWS_SETTING, self.rows);
        update!(uint setting, COLUMNS_SETTING, self.columns);
        update!(uint setting, X_SETTING, self.x);
        update!(uint setting, Y_SETTING, self.y);
        update!(select setting, ON_STEP_SETTING, self.on_step, |value: String| {
            if value.is_empty() {
                Ok(None)
            } else {
                Some(value.parse::<u8>()).transpose()
            }
        });
        update!(select setting, OFF_STEP_SETTING, self.off_step, |value: String| {
            if value.is_empty() {
                Ok(None)
            } else {
                Some(value.parse::<u8>()).transpose()
            }
        });

        update_fallback!(setting)
    }
}

impl PipelineNode for MidiOutputGridNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "MIDI Output Grid".into(),
            preview_type: PreviewType::Multiple,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(INPUT_PORT, PortType::Multi)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MidiOutputGrid
    }
}

impl ProcessingNode for MidiOutputGridNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let Some(connection_manager) = context.try_inject::<MidiConnectionManager>() else {
            return Ok(());
        };
        if let Some(values) = context.multi_input(INPUT_PORT).read_changes() {
            if let Some(mut device) = connection_manager.request_device(&self.device)? {
                let messages = if let Some(grid) = device.profile.as_ref().and_then(|profile| {
                    profile.get_grid(&self.page, self.x, self.y, self.columns, self.rows)
                }) {
                    if grid.len() != values.len() {
                        // TODO: report issue to ui, but we don't have to pad anything because of how the grid implementation works
                        tracing::warn!("Mismatch between grid size and input values size");
                    }
                    grid.write(&values, self.on_step, self.off_step)
                } else {
                    Default::default()
                };

                for message in messages {
                    device.write(message)?;
                }

                context.write_multi_preview(values);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
