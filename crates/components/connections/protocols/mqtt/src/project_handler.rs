use crate::{MqttAddress, MqttConnectionManager};
use mizer_module::*;
use std::collections::HashMap;

const CONNECTIONS_FILE_NAME: &str = "mqtt";

pub struct MqttProjectHandler;

impl ProjectHandler for MqttProjectHandler {
    fn get_name(&self) -> &'static str {
        "connections"
    }

    fn new_project(
        &mut self,
        _context: &mut impl ProjectHandlerContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let Some(mqtt_manager) = injector.try_inject_mut::<MqttConnectionManager>() else {
            tracing::warn!("MQTT connection manager not found");
            return Ok(());
        };

        mqtt_manager.clear();

        Ok(())
    }

    fn load_project(
        &mut self,
        context: &mut impl LoadProjectContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        profiling::scope!("MqttProjectHandler::load_project");
        let Some(mqtt_manager) = injector.try_inject_mut::<MqttConnectionManager>() else {
            tracing::warn!("MQTT connection manager not found");
            return Ok(());
        };
        mqtt_manager.clear();
        let connections: HashMap<String, MqttAddress> = context.read_file(CONNECTIONS_FILE_NAME)?;
        for (id, config) in connections {
            mqtt_manager.add_connection(id, config)?;
        }

        Ok(())
    }

    fn save_project(
        &self,
        context: &mut impl SaveProjectContext,
        injector: &dyn InjectDyn,
    ) -> anyhow::Result<()> {
        profiling::scope!("MqttProjectHandler::save_project");
        let Some(mqtt_manager) = injector.try_inject::<MqttConnectionManager>() else {
            tracing::warn!("MQTT connection manager not found");
            return Ok(());
        };

        let mut connections: HashMap<String, MqttAddress> = Default::default();

        for (id, connection) in mqtt_manager.list_connections() {
            connections.insert(id.clone(), connection.address.clone());
        }

        context.write_file(CONNECTIONS_FILE_NAME, &connections)?;

        Ok(())
    }
}
