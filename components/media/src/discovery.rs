use std::path::PathBuf;

use async_walk::WalkBuilder;
use futures::{StreamExt, TryStreamExt, future};

use crate::api::{MediaServerApi, MediaServerCommand, MediaCreateModel};

const SUPPORTED_EXTENSIONS: [&str; 13] = [
    // Audio
    "mp3",
    "wav",
    // Image
    "jpg",
    "jpeg",
    "png",
    "tiff",
    "webp",
    // Vector
    "svg",
    // Video
    "avi",
    "mov",
    "mp4",
    "webm",
    "wmv"
];

pub struct MediaDiscovery {
    walker: MediaWalker,
    api: MediaServerApi,
}

impl MediaDiscovery {
    pub fn new<P: Into<PathBuf>>(api: MediaServerApi, path: P) -> Self {
        MediaDiscovery {
            walker: MediaWalker::new(path.into()),
            api,
        }
    }

    pub async fn discover(&self) -> anyhow::Result<()> {
        let paths = self.walker.scan().await?;

        for path in paths {
            let (sender, receiver) = MediaServerApi::open_channel();
            let media_create = MediaCreateModel {
                name: path.file_name().unwrap().to_os_string().into_string().unwrap(),
                tags: Vec::new(),
            };
            let cmd = MediaServerCommand::ImportFile(media_create, path, sender);
            self.api.send_command(cmd);

            receiver.recv_async().await?;
        }

        Ok(())
    }
}

struct MediaWalker {
    path: PathBuf,
}

impl MediaWalker {
    fn new(path: PathBuf) -> Self {
        MediaWalker {
            path
        }
    }

    async fn scan(&self) -> anyhow::Result<Vec<PathBuf>> {
        let walker = WalkBuilder::new(&self.path).build();
        let paths = walker
            .into_stream()
            .map(|entry| entry.map(|e| e.path()))
            .try_filter(|path| {
                let supported = if let Some(extension) = path.extension().and_then(|extension| extension.to_str()) {
                    SUPPORTED_EXTENSIONS.contains(&extension)
                }else {
                    false
                };
                future::ready(supported)
            })
            .try_collect()
            .await
            .map_err(|err| anyhow::anyhow!("walking error: {:?}", err))?;

        Ok(paths)
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;
    use super::MediaWalker;
    use std::path::{PathBuf, Path};

    #[test_case("examples/media/audio/file_example_MP3_5MG.mp3")]
    #[test_case("examples/media/audio/file_example_WAV_10MG.wav")]
    #[test_case("examples/media/image/file_example_JPG_2500kB.jpg")]
    #[test_case("examples/media/image/file_example_PNG_3MB.png")]
    #[test_case("examples/media/image/file_example_TIFF_10MB.tiff")]
    #[test_case("examples/media/image/file_example_WEBP_1500kB.webp")]
    #[test_case("examples/media/vector/file_example_SVG_30kB.svg")]
    #[test_case("examples/media/video/file_example_AVI_1920_2_3MG.avi")]
    #[test_case("examples/media/video/file_example_MOV_1920_2_2MB.mov")]
    #[test_case("examples/media/video/file_example_MP4_1920_18MG.mp4")]
    #[test_case("examples/media/video/file_example_WEBM_1920_3_7MB.webm")]
    #[test_case("examples/media/video/file_example_WMV_1920_9_3MB.wmv")]
    fn scan_should_list_example_files(expected: &str) {
        let mut rt = tokio::runtime::Runtime::new().unwrap();
        let path = std::env!("CARGO_MANIFEST_DIR");
        let workspace_path = Path::new(path).parent().unwrap().parent().unwrap();
        let expected = workspace_path.join(expected);
        let walker = MediaWalker::new(workspace_path.join("examples/media"));

        let files = rt.block_on(walker.scan()).unwrap();

        assert!(files.contains(&expected));
    }
}
