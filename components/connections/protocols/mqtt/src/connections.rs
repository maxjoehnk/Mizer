use crate::output::MqttOutput;
use crate::subscription::MqttSubscription;
use flume::{Receiver, Sender};
use futures::future::Either;
use futures::{future, FutureExt};
use mizer_message_bus::{MessageBus, Subscriber};
use mizer_util::StructuredData;
use mqtt_async_client::client::{Client, Publish, QoS, ReadResult, Subscribe, SubscribeTopic};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use url::Url;

#[derive(Debug, Clone, Hash, PartialEq, Eq, PartialOrd, Ord, Deserialize, Serialize)]
pub struct MqttAddress {
    pub url: Url,
    pub username: Option<String>,
    pub password: Option<String>,
}

impl MqttAddress {
    fn into_client(self) -> anyhow::Result<Client> {
        let client = Client::builder()
            .set_url(self.url)?
            .set_username(self.username)
            .set_password(self.password.map(|password| password.into_bytes()))
            .build()?;

        Ok(client)
    }
}

#[derive(Default)]
pub struct MqttConnectionManager {
    connections: HashMap<String, MqttConnection>,
}

impl MqttConnectionManager {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn add_connection(&mut self, id: String, address: MqttAddress) -> anyhow::Result<()> {
        let (connection, background_client) = MqttConnection::new(address)?;
        self.connections.insert(id, connection);
        tokio::spawn(background_client.run());

        Ok(())
    }

    pub fn list_connections(&self) -> Vec<(&String, &MqttConnection)> {
        self.connections.iter().collect()
    }

    pub fn delete_connection(&mut self, id: &str) -> Option<MqttAddress> {
        self.connections
            .remove(id)
            .map(|connection| connection.address.clone())
    }

    pub(crate) fn reconfigure_connection(
        &mut self,
        id: &str,
        address: MqttAddress,
    ) -> anyhow::Result<MqttAddress> {
        log::debug!("reconfigure_connection {id}");
        let connection = self
            .connections
            .get_mut(id)
            .ok_or_else(|| anyhow::anyhow!("Unknown connection"))?;
        let previous_address = connection.reconfigure(address)?;

        Ok(previous_address)
    }

    pub fn clear(&mut self) {
        self.connections.clear();
    }

    pub fn get_output(&self, id: &str) -> Option<MqttOutput> {
        self.connections
            .get(id)
            .map(|connection| MqttOutput::new(&connection.command_publisher))
    }

    pub fn subscribe(&self, id: &str, path: String) -> anyhow::Result<Option<MqttSubscription>> {
        self.connections
            .get(id)
            .map(|connection| {
                let subscriber = connection.subscribe(path.clone())?;

                Ok(MqttSubscription {
                    connection_id: id.to_string(),
                    path,
                    subscriber,
                })
            })
            .transpose()
    }
}

pub struct MqttConnection {
    pub address: MqttAddress,
    command_publisher: Sender<MqttClientCommand>,
    event_publisher: MessageBus<MqttEvent>,
}

#[derive(Debug, Clone)]
pub struct MqttEvent {
    pub topic: String,
    pub payload: StructuredData,
}

impl MqttConnection {
    fn new(address: MqttAddress) -> anyhow::Result<(Self, MqttBackgroundClient)> {
        let client = address.clone().into_client()?;

        let (command_publisher, command_receiver) = flume::unbounded();
        let event_publisher = MessageBus::new();

        let connection = Self {
            address,
            command_publisher,
            event_publisher: event_publisher.clone(),
        };
        let background_client = MqttBackgroundClient {
            client,
            command_receiver,
            event_publisher,
            subscriptions: Default::default(),
        };
        Ok((connection, background_client))
    }

    fn reconfigure(&mut self, address: MqttAddress) -> anyhow::Result<MqttAddress> {
        let mut previous_address = address.clone();
        std::mem::swap(&mut self.address, &mut previous_address);
        self.command_publisher
            .send(MqttClientCommand::Reconfigure(address))?;

        Ok(previous_address)
    }

    fn subscribe(&self, path: String) -> anyhow::Result<Subscriber<MqttEvent>> {
        self.command_publisher
            .send(MqttClientCommand::Subscribe(path))?;
        let subscriber = self.event_publisher.subscribe();

        Ok(subscriber)
    }
}

impl Drop for MqttConnection {
    fn drop(&mut self) {
        self.command_publisher
            .send(MqttClientCommand::Close)
            .unwrap();
    }
}

#[derive(Debug)]
pub(crate) enum MqttClientCommand {
    Close,
    Reconfigure(MqttAddress),
    Publish(Publish),
    Subscribe(String),
}

struct MqttBackgroundClient {
    client: Client,
    command_receiver: Receiver<MqttClientCommand>,
    event_publisher: MessageBus<MqttEvent>,
    subscriptions: Vec<String>,
}

impl MqttBackgroundClient {
    async fn run(mut self) {
        self.connect().await;
        loop {
            let (cmd, event) = {
                let commands = self.command_receiver.recv_async().fuse();
                let subscriptions = self.client.read_subscriptions().fuse();
                futures::pin_mut!(commands);
                futures::pin_mut!(subscriptions);

                match future::select(commands, subscriptions).await {
                    Either::Left((cmd, _)) => (Some(cmd), None),
                    Either::Right((event, _)) => (None, Some(event)),
                }
            };

            if let Some(cmd) = cmd {
                match self.handle_command(cmd).await {
                    Ok(true) => break,
                    Err(err) => log::error!("Error handling mqtt background command {:?}", err),
                    _ => {}
                }
            }

            if let Some(event) = event {
                if let Err(err) = self.handle_event(event).await {
                    log::error!("Error handling mqtt event {:?}", err)
                }
            }
        }
    }

    async fn connect(&mut self) {
        loop {
            if let Err(err) = self.client.connect().await {
                log::error!("Error connecting to mqtt broker: {:?}", err);
            } else {
                break;
            }
        }
    }

    async fn handle_command(
        &mut self,
        command: Result<MqttClientCommand, flume::RecvError>,
    ) -> anyhow::Result<bool> {
        let command = command?;
        log::trace!("handle_command {:?}", command);
        match command {
            MqttClientCommand::Publish(publish) => {
                log::debug!("Publishing message to {}", publish.topic());
                self.client.publish(&publish).await?;

                Ok(false)
            }
            MqttClientCommand::Subscribe(path) => {
                if !self.subscriptions.contains(&path) {
                    let subscribe = Subscribe::new(vec![SubscribeTopic {
                        topic_path: path.clone(),
                        qos: QoS::AtLeastOnce,
                    }]);
                    log::debug!("Subscribing to {path}");
                    let result = self.client.subscribe(subscribe).await?;
                    result.any_failures()?;
                    self.subscriptions.push(path);
                }

                Ok(false)
            }
            MqttClientCommand::Reconfigure(address) => {
                self.client.disconnect().await?;
                self.client = address.clone().into_client()?;
                // TODO: this will also block any configuration attempts until a connection could be established
                self.connect().await;

                Ok(false)
            }
            MqttClientCommand::Close => Ok(true),
        }
    }

    async fn handle_event(
        &mut self,
        result: mqtt_async_client::Result<ReadResult>,
    ) -> anyhow::Result<()> {
        let result = result?;
        let topic = result.topic().to_string();
        let payload = serde_json::from_slice(result.payload())?;

        log::trace!("Received MQTT message {} - {:?}", topic, payload);
        self.event_publisher.send(MqttEvent { topic, payload });

        Ok(())
    }
}
