use crate::{
    ArtnetInput, ArtnetOutput, DmxConnectionManager, DmxInput, DmxInputConnection,
    DmxOutputConnection, SacnOutput,
};
use mizer_module::*;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::net::Ipv4Addr;

pub struct DmxProjectHandler;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub enum DmxConfig {
    Sacn {
        priority: Option<u8>,
    },
    #[serde(alias = "artnet")]
    ArtnetOutput {
        host: String,
        port: Option<u16>,
    },
    ArtnetInput {
        host: Ipv4Addr,
        port: Option<u16>,
        name: String,
    },
}

impl ProjectHandler for DmxProjectHandler {
    fn get_name(&self) -> &'static str {
        "connections"
    }

    fn new_project(
        &mut self,
        _context: &mut impl ProjectHandlerContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let Some(dmx_manager) = injector.try_inject_mut::<DmxConnectionManager>() else {
            anyhow::bail!("DMX connection manager not found");
        };

        dmx_manager.clear();
        dmx_manager.add_output("dmx-0".into(), SacnOutput::new(None));

        Ok(())
    }

    fn load_project(
        &mut self,
        context: &mut impl LoadProjectContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        profiling::scope!("DmxProjectHandler::load_project");
        let Some(dmx_manager) = injector.try_inject_mut::<DmxConnectionManager>() else {
            anyhow::bail!("DMX connection manager not found");
        };
        dmx_manager.clear();
        let dmx_outputs: HashMap<String, DmxConfig> = context.read_file("dmx")?;
        for (id, config) in dmx_outputs {
            match config {
                DmxConfig::Sacn { priority } => {
                    dmx_manager.add_output(id, SacnOutput::new(priority))
                }
                DmxConfig::ArtnetOutput { port, host } => {
                    dmx_manager.add_output(id, ArtnetOutput::new(host, port)?)
                }
                DmxConfig::ArtnetInput { port, host, name } => {
                    dmx_manager.add_input(id, ArtnetInput::new(host, port, name)?)
                }
            }
        }

        Ok(())
    }

    fn save_project(
        &self,
        context: &mut impl SaveProjectContext,
        injector: &dyn InjectDyn,
    ) -> anyhow::Result<()> {
        profiling::scope!("DmxProjectHandler::save_project");
        let Some(dmx_manager) = injector.try_inject::<DmxConnectionManager>() else {
            anyhow::bail!("DMX connection manager not found");
        };

        let mut connections: HashMap<String, DmxConfig> = Default::default();

        for (id, output) in dmx_manager.list_outputs() {
            connections.insert(id.clone(), get_output_config(output));
        }

        for (id, input) in dmx_manager.list_inputs() {
            connections.insert(id.clone(), get_input_config(input));
        }

        context.write_file("dmx", &connections)?;

        Ok(())
    }
}

fn get_output_config(connection: &DmxOutputConnection) -> DmxConfig {
    match connection {
        DmxOutputConnection::Artnet(artnet) => DmxConfig::ArtnetOutput {
            host: artnet.host.clone(),
            port: artnet.port.into(),
        },
        DmxOutputConnection::Sacn(sacn) => DmxConfig::Sacn {
            priority: Some(sacn.priority),
        },
    }
}

fn get_input_config(connection: &DmxInputConnection) -> DmxConfig {
    match connection {
        DmxInputConnection::Artnet(artnet) => DmxConfig::ArtnetInput {
            host: artnet.config.host,
            port: artnet.config.port.into(),
            name: artnet.config.name.clone(),
        },
    }
}
