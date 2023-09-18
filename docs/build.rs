use std::fs;
use std::fs::File;
use std::io::{BufWriter, Write};
use std::path::{Path, PathBuf};

fn main() -> anyhow::Result<()> {
    let nodes = list_nodes()?;
    println!("{nodes:?}");
    let path = Path::new(&std::env::var("OUT_DIR")?).join("docs.rs");
    let mut file = BufWriter::new(File::create(&path)?);

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
        &mut file,
        "static NODE_DESCRIPTIONS: phf::Map<&'static str, &'static str> = {};",
        codegen.build()
    )?;

    Ok(())
}

fn list_nodes() -> anyhow::Result<Vec<PathBuf>> {
    let mut nodes = Vec::new();
    for category in fs::read_dir("nodes")? {
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
