use eframe::egui::Context;
use eframe::{egui, Frame};
use egui_json_tree::JsonTree;
use serde_derive::Serialize;
use mizer_fixtures::definition::FixtureDefinition;
use mizer_gdtf_provider::{GdtfArchive, GdtfFixtureDefinition, GeometryFeatures, IGeometry};

fn main() {
    let path = std::env::args().nth(1).expect("No path provided");
    let path = std::path::PathBuf::from(path);
    let archive = GdtfArchive::read(&path).unwrap();
    let definition = GdtfFixtureDefinition::from(archive);

    println!("Loaded GDTF Fixture from '{path:?}'.");

    let geometry = definition.fixture_type.geometries.get_geometry().unwrap();

    println!("Loaded geometry '{:?}'", geometry.name());

    let gdtf_definition = serde_json::to_value(&definition).unwrap();
    let mizer_definition = FixtureDefinition::from(definition.clone());
    let mizer_definition = serde_json::to_value(&mizer_definition).unwrap();
    let geometry = serde_json::to_value(&geometry).unwrap();

    let app = GdtfDebuggerApp {
        gdtf_definition,
        mizer_definition,
        geometry
    };

    eframe::run_native(
        "GDTF Debugger",
        eframe::NativeOptions::default(),
        Box::new(|_cc| Ok(Box::new(app))),
    ).unwrap();
}

#[derive(Debug, Serialize)]
struct GdtfGeometryDebugger {
    name: String,
    root_features: GeometryFeatures,
    sub_features: Vec<GeometryFeatures>,
}

struct GdtfDebuggerApp {
    gdtf_definition: serde_json::Value,
    mizer_definition: serde_json::Value,
    geometry: serde_json::Value,
}

impl eframe::App for GdtfDebuggerApp {
    fn update(&mut self, ctx: &Context, frame: &mut Frame) {
        egui::CentralPanel::default().show(ctx, |ui| {
            ui.columns(3, |ui| {
                ui[0].label("GDTF Definition");
                ui[1].label("Geometry");
                ui[2].label("Mizer Definition");
                egui::ScrollArea::vertical()
                    .id_salt("gdtf")
                    .show(&mut ui[0], |ui| {
                        JsonTree::new("gdtf", &self.gdtf_definition).show(ui);
                    });
                egui::ScrollArea::vertical()
                    .id_salt("geometry")
                    .show(&mut ui[1], |ui| {
                        JsonTree::new("geometry", &self.geometry).show(ui);
                    });
                egui::ScrollArea::vertical()
                    .id_salt("mizer")
                    .show(&mut ui[2], |ui| {
                        JsonTree::new("mizer", &self.mizer_definition).show(ui);
                    });
            });
        });
    }
}
