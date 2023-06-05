use mizer_fixtures::definition::{ColorChannel, FixtureFaderControl};
use mizer_fixtures::manager::FixtureManager;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_plan::{Plan, PlanScreen, PlanStorage, ScreenId};

const INPUT_PORT: &str = "Input";

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlanScreenNode {
    pub plan: String,
    pub screen_id: ScreenId,
    #[serde(skip)]
    pub plan_storage: Option<PlanStorage>,
}

impl PartialEq for PlanScreenNode {
    fn eq(&self, other: &Self) -> bool {
        self.screen_id == other.screen_id && self.plan == other.plan
    }
}

impl Default for PlanScreenNode {
    fn default() -> Self {
        Self {
            plan: Default::default(),
            screen_id: ScreenId(0),
            plan_storage: None,
        }
    }
}

impl ConfigurableNode for PlanScreenNode {}

impl PlanScreenNode {
    fn get_plan(&self) -> Option<Plan> {
        let storage = self.plan_storage.as_ref()?;
        let plans = storage.read();
        let plan = plans.into_iter().find(|p| p.name == self.plan)?;

        Some(plan)
    }

    fn get_screen(&self) -> Option<PlanScreen> {
        let plan = self.get_plan()?;
        plan.screens
            .into_iter()
            .find(|s| s.screen_id == self.screen_id)
    }

    fn convert_pixels(width: u32, pixels: Vec<f64>) -> Vec<Vec<Color>> {
        pixels
            .chunks_exact(3)
            .map(|bytes| Color::rgb(bytes[0], bytes[1], bytes[2]))
            .collect::<Vec<Color>>()
            .chunks_exact(width as usize)
            .map(|row| row.to_vec())
            .collect()
    }
}

impl PipelineNode for PlanScreenNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Plan Screen".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(
            INPUT_PORT,
            PortType::Multi,
            dimensions: self.get_screen()
                .map(|screen| (screen.width as u64, screen.height as u64))
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::PlanScreen
    }

    fn prepare(&mut self, injector: &Injector) {
        self.plan_storage = injector.get().cloned();
    }
}

impl ProcessingNode for PlanScreenNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let Some(pixels) = context.read_port::<_, Vec<f64>>(INPUT_PORT) else {
            return Ok(())
        };
        let Some(manager) = context.inject::<FixtureManager>() else {
            return Ok(())
        };
        let Some(plan) = self.get_plan() else {
            return Ok(())
        };
        let Some(screen) = plan.screens.iter().find(|s| s.screen_id == self.screen_id) else {
            return Ok(())
        };
        let pixel_data = Self::convert_pixels(screen.width, pixels);
        for fixture in plan.fixtures.iter().filter(|f| screen.contains_fixture(f)) {
            let (x, y) = screen.translate_position(fixture);
            let Some(color) = pixel_data.get(x).and_then(|row| row.get(y)) else {
                continue
            };
            manager.write_fixture_control(
                fixture.fixture,
                FixtureFaderControl::Intensity,
                color.alpha,
            );
            manager.write_fixture_control(
                fixture.fixture,
                FixtureFaderControl::ColorMixer(ColorChannel::Red),
                color.red,
            );
            manager.write_fixture_control(
                fixture.fixture,
                FixtureFaderControl::ColorMixer(ColorChannel::Green),
                color.green,
            );
            manager.write_fixture_control(
                fixture.fixture,
                FixtureFaderControl::ColorMixer(ColorChannel::Blue),
                color.blue,
            );
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
