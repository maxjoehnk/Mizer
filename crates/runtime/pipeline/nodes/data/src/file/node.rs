use std::fs::File;
use std::path::PathBuf;
use serde::{Deserialize, Serialize};
use mizer_media::documents::{MediaDocument, MediaId};
use mizer_media::MediaServer;
use mizer_node::*;
use mizer_util::StructuredData;

const FILE_SETTING: &str = "File";

const CSV_HEADER_SETTING: &str = "Header";
const CSV_DELIMITER: &str = "Delimiter";

const OUTPUT_DATA_PORT: &str = "Output";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct DataFileNode {
    pub file: String,
    #[serde(default)]
    pub csv_settings: CsvLoadSettings,
}

impl ConfigurableNode for DataFileNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(media FILE_SETTING, &self.file, vec![MediaContentType::Data]),
            setting!(CSV_HEADER_SETTING, self.csv_settings.header),
            setting!(CSV_DELIMITER, self.csv_settings.delimiter.to_string())
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(media setting, FILE_SETTING, self.file);
        update!(bool setting, CSV_HEADER_SETTING, self.csv_settings.header);
        update!(text setting, CSV_DELIMITER, self.csv_settings.delimiter, |t: String| {
            if t.is_empty() {
                anyhow::bail!("Empty input");
            }

            Ok(t.chars().next().unwrap())
        });

        update_fallback!(setting)
    }
}

impl PipelineNode for DataFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Data File".into(),
            category: NodeCategory::Data,
            preview_type: PreviewType::Data,
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::DataFile
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            output_port!(OUTPUT_DATA_PORT, PortType::Data),
        ]
    }
}

impl ProcessingNode for DataFileNode {
    type State = DataFileNodeState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some(media_server) = context.inject::<MediaServer>() else {
            return Ok(());
        };

        if self.file.is_empty() {
            return Ok(());
        }
        let media_id = MediaId::try_from(self.file.as_str())?;
        let Some(file) = media_server.get_media_file(media_id) else {
            return Ok(());
        };

        state.load_if_necessary(file, self.csv_settings)?;

        if let Some(data) = state.data.as_ref() {
            context.write_data_preview(data.clone());
            context.write_port(OUTPUT_DATA_PORT, data.clone());
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default)]
pub struct DataFileNodeState {
    data: Option<StructuredData>,
    loader: BackgroundLoader,
}

impl DataFileNodeState {
    fn load_if_necessary(&mut self, file: MediaDocument, settings: CsvLoadSettings) -> anyhow::Result<()> {
        self.loader.load_if_necessary(file, settings)?;
        if let Some(data) = self.loader.handle_loaded_data() {
            let data = data?;

            self.data = Some(data);
        }

        Ok(())
    }
}

struct BackgroundLoader {
    recv: flume::Receiver<anyhow::Result<StructuredData>>,
    send: flume::Sender<anyhow::Result<StructuredData>>,
    loaded_file: Option<(PathBuf, CsvLoadSettings)>,
    is_loading: bool,
}

impl Default for BackgroundLoader {
    fn default() -> Self {
        let (send, recv) = flume::bounded(1);

        Self {
            send,
            recv,
            loaded_file: None,
            is_loading: false,
        }
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub struct CsvLoadSettings {
    header: bool,
    delimiter: char,
}

impl Default for CsvLoadSettings {
    fn default() -> Self {
        CsvLoadSettings {
            header: false,
            delimiter: ',',
        }
    }
}

impl BackgroundLoader {
    fn load_if_necessary(&mut self, file: MediaDocument, settings: CsvLoadSettings) -> anyhow::Result<()> {
        if !matches!(self.loaded_file.as_ref(), Some((path, s)) if path == &file.file_path && settings == *s) {
            self.queue_loading(file, settings);
        }

        Ok(())
    }

    fn handle_loaded_data(&mut self) -> Option<anyhow::Result<StructuredData>> {
        let data = self.recv.try_recv().ok()?;
        self.is_loading = false;

        Some(data)
    }

    fn queue_loading(&mut self, file: MediaDocument, settings: CsvLoadSettings) {
        if self.is_loading {
            return;
        }
        self.is_loading = true;
        self.loaded_file = Some((file.file_path.clone(), settings));
        let sender = self.send.clone();
        std::thread::spawn(move || {
            let result = Self::load(file, settings);

            sender.send(result).unwrap();
        });
    }

    fn load(file: MediaDocument, settings: CsvLoadSettings) -> anyhow::Result<StructuredData> {
        let file = File::open(file.file_path)?;
        let mut reader = csv::ReaderBuilder::new()
            .has_headers(settings.header)
            .delimiter(settings.delimiter as u8)
            .from_reader(file);
        let mut errors = Vec::new();
        let headers = reader.headers()?.into_iter().map(|h| h.to_string()).collect::<Vec<_>>();
        let rows = reader
            .into_records()
            .flat_map(|record| match record {
                Ok(record) => {
                    if !settings.header {
                        let cells = record
                            .into_iter()
                            .map(|cell| StructuredData::Text(cell.to_string()))
                            .collect();

                        Some(StructuredData::Array(cells))
                    } else {
                        let cells = record
                            .into_iter()
                            .enumerate()
                            .map(|(i, cell)| (
                                headers.get(i).map(|name| name.to_string()).unwrap_or_else(|| format!("Column {}", i + 1)),
                                StructuredData::Text(cell.to_string())))
                            .collect();

                        Some(StructuredData::Object(cells))
                    }

                }
                Err(err) => {
                    errors.push(err);
                    None
                }
            })
            .collect::<Vec<_>>();

        let data = StructuredData::Array(rows);

        Ok(data)
    }
}
