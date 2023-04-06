use std::path::PathBuf;

use async_walkdir::WalkDir;
use futures::{future, FutureExt, StreamExt, TryStreamExt};

use crate::{MediaCreateModel, MediaServer};

const SUPPORTED_EXTENSIONS: [&str; 13] = [
    // Audio
    "mp3", "wav", // Image
    "jpg", "jpeg", "png", "tiff", "webp", // Vector
    "svg",  // Video
    "avi", "mov", "mp4", "webm", "wmv",
];

pub struct MediaDiscovery {
    walker: MediaWalker,
    api: MediaServer,
}

impl MediaDiscovery {
    pub fn new<P: Into<PathBuf>>(api: MediaServer, path: P) -> Self {
        MediaDiscovery {
            walker: MediaWalker::new(path.into()),
            api,
        }
    }

    // TODO: watch path for file changes
    pub async fn discover(&self) -> anyhow::Result<()> {
        log::info!("Discovering media files in {:?}", &self.walker.path);
        let paths = self.walker.scan().await?;
        let mut receivers = Vec::new();

        for path in paths {
            let media_create = MediaCreateModel {
                name: path
                    .file_name()
                    .unwrap()
                    .to_os_string()
                    .into_string()
                    .unwrap(),
                tags: Vec::new(),
            };
            let receiver = self
                .api
                .import_file(media_create, path, Some(&self.walker.path))
                .boxed();

            receivers.push(receiver);
        }

        let results = futures::future::join_all(receivers).await;
        for result in results {
            match result {
                Err(err) => log::error!("Importing media file failed: {err:?}"),
                Ok(Some(document)) => log::debug!("Imported media file: {document:?}"),
                _ => {}
            }
        }

        Ok(())
    }
}

struct MediaWalker {
    path: PathBuf,
}

impl MediaWalker {
    fn new(path: PathBuf) -> Self {
        MediaWalker { path }
    }

    async fn scan(&self) -> anyhow::Result<Vec<PathBuf>> {
        let walker = WalkDir::new(&self.path);
        let paths = walker
            .into_stream()
            .map(|entry| entry.map(|e| e.path()))
            .try_filter(|path| {
                let supported = if let Some(extension) =
                    path.extension().and_then(|extension| extension.to_str())
                {
                    SUPPORTED_EXTENSIONS.contains(&extension)
                } else {
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
    use super::MediaWalker;
    use std::path::Path;
    use test_case::test_case;

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
        let path = env!("CARGO_MANIFEST_DIR");
        let workspace_path = Path::new(path).parent().unwrap().parent().unwrap();
        let expected = workspace_path.join(expected);
        let walker = MediaWalker::new(workspace_path.join("examples/media"));

        let files = futures::executor::block_on(walker.scan()).unwrap();

        assert!(files.contains(&expected));
    }
}
