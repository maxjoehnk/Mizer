use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_mqtt::{MqttConnectionManager, MqttSubscription};

const VALUE_PORT: &str = "value";

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct MqttInputNode {
    pub path: String,
    pub connection: String,
}

impl Default for MqttInputNode {
    fn default() -> Self {
        Self {
            path: "/".to_string(),
            connection: Default::default(),
        }
    }
}

impl PipelineNode for MqttInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "MqttInputNode".into(),
            preview_type: PreviewType::Data,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            VALUE_PORT.into(),
            PortMetadata {
                port_type: PortType::Data,
                direction: PortDirection::Output,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MqttInput
    }
}

impl ProcessingNode for MqttInputNode {
    type State = Option<MqttSubscription>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let connection_manager = self.get_connection_manager(context);
        if state.is_none() {
            self.create_subscription(connection_manager, state)?;
        } else {
            self.verify_subscription(connection_manager, state)?;
        }
        self.read_subscription(context, state);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.connection = config.connection.clone();
        self.path = config.path.clone();
    }
}

impl MqttInputNode {
    fn get_connection_manager<'a>(
        &self,
        context: &'a impl NodeContext,
    ) -> &'a MqttConnectionManager {
        let connection_manager = context.inject::<MqttConnectionManager>();

        connection_manager.expect("Missing mqtt module")
    }

    fn verify_subscription(
        &self,
        connection_manager: &MqttConnectionManager,
        subscription: &mut Option<MqttSubscription>,
    ) -> anyhow::Result<()> {
        if subscription
            .as_ref()
            .map(|subscription| {
                subscription.path() != self.path || subscription.connection_id() != self.connection
            })
            .and_then(|is_valid| is_valid.then_some(()))
            .is_some()
        {
            self.create_subscription(connection_manager, subscription)?;
        }

        Ok(())
    }

    fn create_subscription(
        &self,
        connection_manager: &MqttConnectionManager,
        subscription: &mut Option<MqttSubscription>,
    ) -> anyhow::Result<()> {
        *subscription = connection_manager.subscribe(&self.connection, self.path.clone())?;

        Ok(())
    }

    fn read_subscription(
        &self,
        context: &impl NodeContext,
        subscription: &mut Option<MqttSubscription>,
    ) {
        if let Some(event) = subscription
            .as_ref()
            .and_then(|subscription| subscription.next_event())
        {
            context.write_data_preview(event.payload.clone());
            context.write_port(VALUE_PORT, event.payload);
        }
    }
}
