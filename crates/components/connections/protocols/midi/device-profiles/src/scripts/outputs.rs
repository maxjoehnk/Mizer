use std::ops::Deref;
use std::path::PathBuf;
use std::sync::Arc;

use anyhow::Context;

use rhai::{Blob, Engine, ImmutableString, Scope, AST};

use mizer_midi_messages::MidiMessage;

use crate::{Control, DeviceControl};

#[derive(Debug, Clone)]
pub struct OutputEngine(Arc<Engine>);

impl Default for OutputEngine {
    fn default() -> Self {
        let mut engine = Engine::new();
        engine
            .set_max_expr_depths(0, 0)
            .set_max_operations(0)
            .register_type::<Color>()
            .register_get("red", |color: &mut Color| color.0 .0)
            .register_get("green", |color: &mut Color| color.0 .1)
            .register_get("blue", |color: &mut Color| color.0 .2)
            .register_fn("rgb8", |color: Color| color.rgb8())
            .register_type::<Color8>()
            .register_get("red", |color: &mut Color8| color.red as i64)
            .register_get("green", |color: &mut Color8| color.green as i64)
            .register_get("blue", |color: &mut Color8| color.blue as i64)
            .register_type::<Control>()
            .register_get("id", |control: &mut Control| {
                ImmutableString::from(&control.id)
            })
            .register_get("name", |control: &mut Control| {
                ImmutableString::from(&control.name)
            })
            .register_fn("sysex", |p1: i64, p2: i64, p3: i64, p4: i64, data: Blob| {
                MidiMessage::Sysex((p1 as u8, p2 as u8, p3 as u8), p4 as u8, data)
            });

        Self(engine.into())
    }
}

impl Deref for OutputEngine {
    type Target = Engine;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

#[derive(Debug, Clone, Copy)]
pub struct Color(pub(crate) (f64, f64, f64));

#[derive(Debug, Clone, Copy)]
pub struct Color8 {
    pub red: u8,
    pub green: u8,
    pub blue: u8,
}

impl Color {
    fn rgb8(&self) -> Color8 {
        let red = self.0 .0 * u8::MAX as f64;
        let red = red.round() as u8;
        let green = self.0 .1 * u8::MAX as f64;
        let green = green.round() as u8;
        let blue = self.0 .2 * u8::MAX as f64;
        let blue = blue.round() as u8;

        Color8 { red, green, blue }
    }
}

pub fn parse_outputs_ast(
    engine: &Engine,
    script: impl Into<PathBuf>,
) -> anyhow::Result<OutputScript> {
    let ast = engine.compile_file(script.into())?;

    let script = OutputScript { ast };
    Ok(script)
}

#[derive(Clone)]
pub struct OutputScript {
    ast: AST,
}

impl OutputScript {
    pub fn write_rgb(
        &self,
        engine: &OutputEngine,
        control: &Control,
        color: Color,
    ) -> anyhow::Result<MidiMessage> {
        let mut scope = Scope::new();
        let Some(DeviceControl::RGBSysEx(method)) = &control.output else {
            anyhow::bail!("Trying to write rgb when device control has no rgb output: {control:?}");
        };

        let message: MidiMessage = engine
            .call_fn(&mut scope, &self.ast, method, (control.clone(), color))
            .context(format!("Calling '{method}' for control {control:?}"))?;

        Ok(message)
    }
}
