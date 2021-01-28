use std::path::Path;
use std::process::{Command, Child};

use crate::file_storage::FileStorage;
use crate::media_handlers::MediaHandler;
use std::ffi::OsStr;

pub struct VideoHandler;

impl VideoHandler {
    #[cfg(all(feature = "omx", not(feature = "nvenc")))]
    fn transcode_command<I: AsRef<OsStr>, O: AsRef<OsStr>>(input: I, output: O) -> anyhow::Result<Child> {
        let child = Command::new("ffmpeg").arg("-i").arg(input).arg("-c:v").arg("h264_omx").arg("-preset").arg("slow").arg("-crf").arg("17").arg(output).spawn()?;

        Ok(child)
    }

    #[cfg(feature = "nvenc")]
    fn transcode_command<I: AsRef<OsStr>, O: AsRef<OsStr>>(input: I, output: O) -> anyhow::Result<Child> {
        unimplemented!()
    }

    #[cfg(not(any(feature = "nvenc", feature = "omx")))]
    fn transcode_command<I: AsRef<OsStr>, O: AsRef<OsStr>>(input: I, output: O) -> anyhow::Result<Child> {
        let child = Command::new("ffmpeg").arg("-i").arg(input).arg("-c:v").arg("libx264").arg("-preset").arg("slow").arg("-crf").arg("17").arg(output).spawn()?;

        Ok(child)
    }
}

impl MediaHandler for VideoHandler {
    fn generate_thumbnail<P: AsRef<Path>>(&self, file: P, storage: &FileStorage, _content_type: &str) -> anyhow::Result<()> {
        let target = storage.get_thumbnail_path(&file);
        let mut child = Command::new("ffmpeg").arg("-i").arg(file.as_ref().as_os_str()).arg("-vframes").arg("1").arg("-filter:v").arg("scale=200:-1").arg(&target).spawn()?;

        let status = child.wait()?;

        if status.success() {
            Ok(())
        }else {
            anyhow::bail!("Something went wrong")
        }
    }
}
