use mizer_fixtures::definition::{ColorChannel, FixtureControl, FixtureFaderControl};
use serde::{Deserialize, Serialize};

use mizer_fixtures::fixture::IFixtureMut;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixturePriority;
use mizer_node::*;

const FIXTURE_SETTING: &str = "Fixture";
const CONTROL_SETTING: &str = "Control";
const PRIORITY_SETTING: &str = "Priority";
const SEND_ZERO_SETTING: &str = "Send Zero";

const INPUT_VALUE_PORT: &str = "Value";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct FixtureControlNode {
    #[serde(rename = "fixture")]
    pub fixture_id: u32,
    #[serde(default)]
    pub priority: FixturePriority,
    #[serde(default = "default_send_zero")]
    pub send_zero: bool,
    pub control: FixtureControl,
}

impl Default for FixtureControlNode {
    fn default() -> Self {
        Self {
            fixture_id: 0,
            priority: FixturePriority::default(),
            send_zero: default_send_zero(),
            control: FixtureControl::Intensity,
        }
    }
}

fn default_send_zero() -> bool {
    true
}

impl FixtureControlNode {
    fn get_controls(
        &self,
        fixture_manager: &FixtureManager,
    ) -> impl Iterator<Item = FixtureControl> {
        fixture_manager
            .get_fixture(self.fixture_id)
            .map(|fixture| fixture.current_mode.controls.controls())
            .unwrap_or_default()
            .into_iter()
            .map(|(control, _)| control)
    }
}

impl ConfigurableNode for FixtureControlNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        let fixtures = fixture_manager
            .get_fixtures()
            .into_iter()
            .map(|fixture| IdVariant {
                value: fixture.id,
                label: fixture.name.clone(),
            })
            .collect();
        let controls = self
            .get_controls(fixture_manager)
            .map(|control| SelectVariant::from(control.to_string()))
            .collect();

        vec![
            setting!(id FIXTURE_SETTING, self.fixture_id, fixtures),
            setting!(select CONTROL_SETTING, self.control.to_string(), controls),
            setting!(enum PRIORITY_SETTING, self.priority),
            setting!(SEND_ZERO_SETTING, self.send_zero),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, FIXTURE_SETTING, self.fixture_id);
        update!(select setting, CONTROL_SETTING, self.control);
        update!(enum setting, PRIORITY_SETTING, self.priority);
        update!(bool setting, SEND_ZERO_SETTING, self.send_zero);

        update_fallback!(setting)
    }
}

impl PipelineNode for FixtureControlNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Fixture Control".into(),
            preview_type: if self.control.is_color() {
                PreviewType::Color
            } else {
                PreviewType::History
            },
            category: NodeCategory::Fixtures,
        }
    }

    fn display_name(&self, injector: &Injector) -> String {
        if let Some(fixture) = injector
            .get::<FixtureManager>()
            .and_then(|manager| manager.get_fixture(self.fixture_id))
        {
            format!(
                "Fixture Control ({} - {})",
                fixture.name,
                self.control.to_string()
            )
        } else {
            format!(
                "Fixture Control (ID {} - {})",
                self.fixture_id,
                self.control.to_string()
            )
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        if self.control.is_color() {
            vec![input_port!(INPUT_VALUE_PORT, PortType::Color)]
        } else {
            vec![input_port!(INPUT_VALUE_PORT, PortType::Single)]
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::FixtureControl
    }
}

impl ProcessingNode for FixtureControlNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let Some(manager) = context.inject::<FixtureManager>() else {
            tracing::warn!("missing fixture module");
            return Ok(());
        };

        let Some(mut fixture) = manager.get_fixture_mut(self.fixture_id) else {
            tracing::error!("could not find fixture for id {}", self.fixture_id);
            return Ok(());
        };

        if self.control.is_color() {
            if let Some(value) = context.color_input(INPUT_VALUE_PORT).read() {
                fixture.write_fader_control(
                    FixtureFaderControl::ColorMixer(ColorChannel::Red),
                    value.red,
                    self.priority,
                );
                fixture.write_fader_control(
                    FixtureFaderControl::ColorMixer(ColorChannel::Green),
                    value.green,
                    self.priority,
                );
                fixture.write_fader_control(
                    FixtureFaderControl::ColorMixer(ColorChannel::Blue),
                    value.blue,
                    self.priority,
                );
                context.write_color_preview(value);
            }
        } else {
            let reader = context.single_input(INPUT_VALUE_PORT);
            if reader.is_high().unwrap_or_default() || self.send_zero {
                if let Some(value) = context.single_input(INPUT_VALUE_PORT).read() {
                    for fader_control in self.control.clone().faders() {
                        fixture.write_fader_control(fader_control, value, self.priority);
                    }
                    context.push_history_value(value);
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
