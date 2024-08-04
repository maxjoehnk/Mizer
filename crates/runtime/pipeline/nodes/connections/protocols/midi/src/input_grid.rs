use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_midi::*;

use crate::{get_devices, get_pages_and_grid};

const OUTPUT_PORT: &str = "Output";

const DEVICE_SETTING: &str = "Device";
const PAGE_SETTING: &str = "Page";
const ROWS_SETTING: &str = "Rows";
const COLUMNS_SETTING: &str = "Columns";
const X_SETTING: &str = "X";
const Y_SETTING: &str = "Y";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct MidiInputGridNode {
    pub device: String,
    pub page: String,
    pub rows: u32,
    pub columns: u32,
    pub x: u32,
    pub y: u32,
}

impl ConfigurableNode for MidiInputGridNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let devices = get_devices(injector);
        let (pages, grid_size) = get_pages_and_grid(injector, &self.device, &self.page);
        let (max_rows, max_cols) = grid_size.unwrap_or((u32::MAX, u32::MAX));

        vec![
            setting!(select DEVICE_SETTING, &self.device, devices),
            setting!(select PAGE_SETTING, &self.page, pages),
            setting!(ROWS_SETTING, self.rows).max(max_rows).min(0u32),
            setting!(COLUMNS_SETTING, self.columns).max(max_cols).min(0u32),
            setting!(X_SETTING, self.x).min(0u32).max(max_cols),
            setting!(Y_SETTING, self.y).min(0u32).max(max_rows),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device);
        update!(select setting, PAGE_SETTING, self.page);
        update!(uint setting, ROWS_SETTING, self.rows);
        update!(uint setting, COLUMNS_SETTING, self.columns);
        update!(uint setting, X_SETTING, self.x);
        update!(uint setting, Y_SETTING, self.y);

        update_fallback!(setting)
    }
}

impl PipelineNode for MidiInputGridNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "MIDI Input Grid".into(),
            preview_type: PreviewType::Multiple,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Multi)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MidiInputGrid
    }
}

impl ProcessingNode for MidiInputGridNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let Some(connection_manager) = context.try_inject::<MidiConnectionManager>() else {
            return Ok(());
        };
        if let Some(device) = connection_manager.request_device(&self.device)? {
            let state = device.state();

            if let Some(grid) = device.profile.as_ref().and_then(|profile| profile.get_grid(&self.page, self.x, self.y, self.columns, self.rows)) {
                let values = state.read_grid(&grid);
                context.write_multi_preview(values.clone());
                context.write_port::<_, port_types::MULTI>(OUTPUT_PORT, values);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
