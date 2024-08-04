use std::fs;
use std::fs::File;
use std::io::{BufWriter, Write};
use std::path::{Path, PathBuf};

fn main() -> anyhow::Result<()> {
    let nodes = list_nodes()?;
    println!("{nodes:?}");
    let path = Path::new(&std::env::var("OUT_DIR")?).join("docs.rs");
    let mut file = BufWriter::new(File::create(path)?);

    generate_descriptions(&mut file, &nodes)?;
    generate_settings(&mut file, &nodes)?;
    generate_templates(&mut file, &nodes)?;

    Ok(())
}

fn generate_descriptions(file: &mut impl Write, nodes: &[PathBuf]) -> anyhow::Result<()> {
    let mut codegen = phf_codegen::Map::new();
    for node in nodes {
        let name = node.file_stem().unwrap().to_str().unwrap();
        let description_path = node.join("description.adoc");
        println!("{description_path:?}");
        if description_path.exists() {
            let description = fs::read_to_string(&description_path)?;
            codegen.entry(name.to_string(), &format!("\"{description}\""));
        }
    }

    write!(
        file,
        "static NODE_DESCRIPTIONS: phf::Map<&'static str, &'static str> = {};",
        codegen.build()
    )?;

    Ok(())
}

fn generate_settings(file: &mut impl Write, nodes: &[PathBuf]) -> anyhow::Result<()> {
    let mut codegen = phf_codegen::Map::new();

    for node in nodes {
        let name = node.file_stem().unwrap().to_str().unwrap();
        let mut settings_codegen = phf_codegen::Map::new();
        for dir in node.read_dir()? {
            match dir {
                Ok(entry) => {
                    let file_name = entry.file_name();
                    let file_name = file_name.to_string_lossy();
                    let is_setting_file = entry.file_type()?.is_file() && file_name.starts_with("setting");
                    if is_setting_file {
                        let setting_name = file_name.replace("setting_", "").replace(".adoc", "");
                        let settings = fs::read_to_string(entry.path())?;
                        let settings = settings.lines()
                            .skip(1)
                            .collect::<String>();
                        let settings = settings.trim();
                        settings_codegen.entry(setting_name.to_string(), &format!("\"{settings}\""));
                    }
                }
                Err(err) => eprintln!("Error reading file in directory {}: {err:?}", node.display())
            }
        }
        codegen.entry(name.to_string(), &format!("{}", settings_codegen.build()));
    }

    write!(
        file,
        "static NODE_SETTINGS: phf::Map<&'static str, phf::Map<&'static str, &'static str>> = {};",
        codegen.build()
    )?;

    Ok(())
}

fn list_nodes() -> anyhow::Result<Vec<PathBuf>> {
    let mut nodes = Vec::new();
    for category in fs::read_dir("modules/nodes/pages")? {
        let category = category?;
        let path = category.path();
        if path.is_dir() {
            for node in fs::read_dir(path)? {
                let node = node?;
                let path = node.path();
                if path.is_dir() {
                    nodes.push(path);
                }
            }
        }
    }
    Ok(nodes)
}

fn generate_templates(file: &mut impl Write, nodes: &[PathBuf]) -> anyhow::Result<()> {
    let mut codegen = phf_codegen::Map::new();

    for node in nodes {
        let name = node.file_stem().unwrap().to_str().unwrap();
        let mut templates_codegen = phf_codegen::Map::new();
        for dir in node.read_dir()? {
            match dir {
                Ok(entry) => {
                    let file_name = entry.file_name();
                    let file_name = file_name.to_string_lossy();
                    let is_setting_file = entry.file_type()?.is_file() && file_name.starts_with("template");
                    if is_setting_file {
                        let template_name = file_name.replace("template_", "").replace(".adoc", "");
                        let template = fs::read_to_string(entry.path())?;
                        let template = template.lines()
                            .skip(1)
                            .collect::<String>();
                        let template = template.trim();
                        templates_codegen.entry(template_name.to_string(), &format!("\"{template}\""));
                    }
                }
                Err(err) => eprintln!("Error reading file in directory {}: {err:?}", node.display())
            }
        }
        codegen.entry(name.to_string(), &format!("{}", templates_codegen.build()));
    }

    write!(
        file,
        "static NODE_TEMPLATE_DESCRIPTIONS: phf::Map<&'static str, phf::Map<&'static str, &'static str>> = {};",
        codegen.build()
    )?;

    Ok(())
}

