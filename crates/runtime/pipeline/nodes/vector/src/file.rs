use serde::{Deserialize, Serialize};

use mizer_media::documents::MediaId;
use mizer_media::MediaServer;
use mizer_node::*;
use mizer_vector::{parse_svg, VectorData};

const MEDIA_ID_SETTING: &str = "File";

const VECTOR_OUTPUT_PORT: &str = "Vector";

#[derive(Debug, Clone, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct VectorFileNode {
    pub media_id: Option<MediaId>,
}

impl ConfigurableNode for VectorFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        let media_id = self.media_id.map(|id| id.to_string()).unwrap_or_default();

        vec![setting!(media MEDIA_ID_SETTING, media_id, vec![MediaContentType::Vector])]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(media setting, MEDIA_ID_SETTING, self.media_id, |id| {
            MediaId::try_from(id).ok()
        });

        update_fallback!(setting)
    }
}

impl PipelineNode for VectorFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Vector File".to_string(),
            category: NodeCategory::Vector,
            preview_type: PreviewType::None,
        }
    }

    fn display_name(&self, injector: &Injector) -> String {
        if let Some(document) = injector
            .get::<MediaServer>()
            .zip(self.media_id.as_ref())
            .and_then(|(media_server, media_id)| media_server.get_media_file(media_id))
        {
            format!("Vector File ({})", document.name)
        } else if let Some(id) = self.media_id.as_ref() {
            format!("Vector File (ID {id})")
        } else {
            "Vector File".to_string()
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VECTOR_OUTPUT_PORT, PortType::Vector)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VectorFile
    }
}

impl ProcessingNode for VectorFileNode {
    type State = VectorFileNodeState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if state.media_id != self.media_id {
            state.media_id = self.media_id;
            state.vector_data = None;
        }

        let Some(media_id) = self.media_id.as_ref() else {
            return Ok(());
        };

        if state.vector_data.is_none() {
            let Some(media_server) = context.inject::<MediaServer>() else {
                tracing::warn!("Media server not available");
                return Ok(());
            };

            let Some(file) = media_server.get_media_file(media_id) else {
                tracing::error!("Media file not available");
                return Ok(());
            };

            if !file.file_path.exists() {
                tracing::error!("Media file does not exist");
                return Ok(());
            }

            // TODO: read in background/async?
            let svg_data = std::fs::read(file.file_path)?;
            let svg_data = parse_svg(&svg_data)?;
            state.vector_data = Some(svg_data);
        }

        let Some(vector_data) = state.vector_data.clone() else {
            return Ok(());
        };

        context.write_port(VECTOR_OUTPUT_PORT, vector_data);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default)]
pub struct VectorFileNodeState {
    media_id: Option<MediaId>,
    vector_data: Option<VectorData>,
}
