use crate::shader::{glsl_string_from_isf, prefix_isf_glsl_str};
use crate::shader_processor::{process_fragment_shader, process_vertex_shader};
use crate::IsfShader;
use mizer_shaders::ShaderRegistry;
use std::fs;
use std::fs::DirEntry;
use std::path::Path;

pub struct IsfLoader;

impl IsfLoader {
    pub fn load_dir(registry: &mut ShaderRegistry, path: impl AsRef<Path>) -> anyhow::Result<()> {
        let path = path.as_ref();
        tracing::info!("Loading ISF shaders from {path}", path = path.display());

        let mut count = 0;
        for file in fs::read_dir(path)? {
            let file = file?;
            let path = file.path();
            let ext = path.extension().and_then(|s| s.to_str());
            if ext == Some("fs") {
                if let Err(err) = Self::load_shader(registry, file) {
                    tracing::error!("err while loading {}: {}", path.display(), err);
                } else {
                    count += 1;
                }
            }
        }

        tracing::info!(
            "Loaded {count} ISF shaders from {path}",
            count = count,
            path = path.display()
        );

        Ok(())
    }

    fn load_shader(registry: &mut ShaderRegistry, file: DirEntry) -> anyhow::Result<()> {
        let path = file.path();
        tracing::debug!("Loading ISF shader from {path}", path = path.display());

        let isf_str = fs::read_to_string(&path)?;

        match isf::parse(&isf_str) {
            // Ignore non-ISF vertex shaders.
            // Err(isf::ParseError::MissingTopComment) if ext == Some("vs") => continue,
            Err(err) => return Err(err.into()),
            Ok(isf) => {
                let filename: String = file.file_name().to_string_lossy().into();
                let fragment_shader = process_fragment_shader(&isf_str, &isf);
                if isf.passes.len() > 1 {
                    tracing::warn!(
                        "ISF shader {path} has {count} passes, which is not supported as of now",
                        path = path.display(),
                        count = isf.passes.len()
                    );
                    return Ok(());
                }
                let vert_path = path.with_extension("vs");
                let vertex_shader = if vert_path.exists() {
                    let vertex_shader = fs::read_to_string(&vert_path)?;
                    let vertex_shader = process_vertex_shader(vertex_shader, &isf);

                    Some(vertex_shader)
                } else {
                    None
                };
                let isf = IsfShader {
                    shader: isf,
                    fragment_shader,
                    vertex_shader,
                    filename,
                    path,
                };
                registry.add_shader(isf);
            }
        };

        Ok(())
    }
}
