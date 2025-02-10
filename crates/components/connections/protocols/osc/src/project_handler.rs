use crate::{OscAddress, OscConnectionManager};
use mizer_module::*;
use std::collections::HashMap;

const CONNECTIONS_FILE_NAME: &str = "osc";

pub struct OscProjectHandler;

impl ProjectHandler for OscProjectHandler {
    fn get_name(&self) -> &'static str {
        "connections"
    }

    fn new_project(
        &mut self,
        _context: &mut impl ProjectHandlerContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let Some(osc_manager) = injector.try_inject_mut::<OscConnectionManager>() else {
            tracing::warn!("OSC connection manager not found");
            return Ok(());
        };

        osc_manager.clear();

        Ok(())
    }

    fn load_project(
        &mut self,
        context: &mut impl LoadProjectContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        profiling::scope!("OscProjectHandler::load_project");
        let Some(osc_manager) = injector.try_inject_mut::<OscConnectionManager>() else {
            tracing::warn!("OSC connection manager not found");
            return Ok(());
        };
        osc_manager.clear();
        let connections: HashMap<String, OscAddress> = context.read_file(CONNECTIONS_FILE_NAME)?;
        for (id, config) in connections {
            osc_manager.add_connection(id, config)?;
        }

        Ok(())
    }

    fn save_project(
        &self,
        context: &mut impl SaveProjectContext,
        injector: &dyn InjectDyn,
    ) -> anyhow::Result<()> {
        profiling::scope!("OscProjectHandler::save_project");
        let Some(osc_manager) = injector.try_inject::<OscConnectionManager>() else {
            tracing::warn!("OSC connection manager not found");
            return Ok(());
        };

        let mut connections: HashMap<String, OscAddress> = Default::default();

        for (id, connection) in osc_manager.list_connections() {
            connections.insert(id.clone(), connection.address);
        }

        context.write_file(CONNECTIONS_FILE_NAME, &connections)?;

        Ok(())
    }
}
