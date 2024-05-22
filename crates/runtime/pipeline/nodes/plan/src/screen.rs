use serde::{Deserialize, Serialize};

use mizer_fixtures::definition::{ColorChannel, FixtureFaderControl};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixturePriority;
use mizer_node::*;
use mizer_plan::{Plan, PlanScreen, PlanStorage, ScreenId};
use crate::texture_to_pixels::TextureToPixelsConverter;

const INPUT_PORT: &str = "Input";

const SCREEN_SETTING: &str = "Screen";
const PRIORITY_SETTING: &str = "Priority";

#[derive(Default, Debug, Clone, Serialize, Deserialize)]
pub struct PlanScreenNode {
    pub plan: String,
    pub screen_id: ScreenId,
    #[serde(default)]
    pub priority: FixturePriority,
}

impl PartialEq for PlanScreenNode {
    fn eq(&self, other: &Self) -> bool {
        self.screen_id == other.screen_id && self.plan == other.plan
    }
}

impl ConfigurableNode for PlanScreenNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let storage = injector.inject::<PlanStorage>();
        let plans = storage.read();
        let screens = plans
            .into_iter()
            .flat_map(|plan| {
                plan.screens
                    .into_iter()
                    .map(move |screen| (plan.name.clone(), screen))
            })
            .map(|(plan, screen)| IdVariant {
                value: screen.id.0,
                label: format!("{} / {}", plan, screen.id.0),
            })
            .collect();

        vec![
            setting!(id SCREEN_SETTING, self.screen_id.0, screens),
            setting!(enum PRIORITY_SETTING, self.priority),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, SCREEN_SETTING, self.screen_id, ScreenId);
        update!(enum setting, PRIORITY_SETTING, self.priority);

        Ok(())
    }
}

impl PlanScreenNode {
    fn get_plan(&self, injector: &impl Inject) -> Option<Plan> {
        let storage = injector.try_inject::<PlanStorage>()?;
        let plans = storage.read();
        let plan = plans.into_iter().find(|p| p.name == self.plan)?;

        Some(plan)
    }

    fn get_screen(&self, injector: &impl Inject) -> Option<PlanScreen> {
        let plan = self.get_plan(injector)?;
        plan.screens.into_iter().find(|s| s.id == self.screen_id)
    }
}

impl PipelineNode for PlanScreenNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Plan Screen".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Fixtures,
        }
    }

    fn list_ports(&self, injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(
            INPUT_PORT,
            PortType::Texture,
            dimensions: self.get_screen(injector)
                .map(|screen| (screen.width as u64, screen.height as u64))
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::PlanScreen
    }
}

impl ProcessingNode for PlanScreenNode {
    type State = Option<TextureToPixelsConverter>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if state.is_none() {
            *state = Some(TextureToPixelsConverter::new(context, INPUT_PORT)?);
        }

        if let Some(state) = state {
            state.process(context)?;
        }

        Ok(())
    }

    fn post_process(
        &self,
        context: &impl NodeContext,
        state: &mut Self::State,
    ) -> anyhow::Result<()> {
        let Some(manager) = context.try_inject::<FixtureManager>() else {
            return Ok(());
        };
        let Some(plan) = self.get_plan(context) else {
            return Ok(());
        };
        let Some(screen) = plan.screens.iter().find(|s| s.id == self.screen_id) else {
            return Ok(());
        };
        if let Some(state) = state.as_mut() {
            if let Some(pixels) = state.post_process(context)? {
                let pixel_width = 1920f64;
                let pixel_height = 1080f64;
                let pixels_per_screen_width = pixel_width / screen.width;
                let pixels_per_screen_height = pixel_height / screen.height;
                for fixture in plan.fixtures.iter().filter(|f| screen.contains_fixture(f)) {
                    // TODO: calculate average of all pixels in given rect instead of just the center
                    let (x1, y1) = screen.translate_position(fixture);
                    let x2 = x1 + fixture.width;
                    let y2 = y1 + fixture.height;

                    let x = (x1 + x2) / 2.0;
                    let y = (y1 + y2) / 2.0;

                    let x_pixel = (x * pixels_per_screen_width).round() as u32;
                    let y_pixel = (y * pixels_per_screen_height).round() as u32;

                    let pixel_index = (y_pixel * 1920 + x_pixel) as usize;
                    let pixel_index = pixel_index * 4;

                    if pixel_index + 3 >= pixels.len() {
                        tracing::warn!("Pixel index out of bounds: {} >= {}", pixel_index + 3, pixels.len());
                        continue;
                    }

                    let blue = pixels[pixel_index] as f64 / 255.0;
                    let green = pixels[pixel_index + 1] as f64 / 255.0;
                    let red = pixels[pixel_index + 2] as f64 / 255.0;
                    let alpha = pixels[pixel_index + 3] as f64 / 255.0;

                    manager.write_fixture_control(
                        fixture.fixture,
                        FixtureFaderControl::Intensity,
                        alpha,
                        self.priority,
                    );
                    manager.write_fixture_control(
                        fixture.fixture,
                        FixtureFaderControl::ColorMixer(ColorChannel::Red),
                        red,
                        self.priority,
                    );
                    manager.write_fixture_control(
                        fixture.fixture,
                        FixtureFaderControl::ColorMixer(ColorChannel::Green),
                        green,
                        self.priority,
                    );
                    manager.write_fixture_control(
                        fixture.fixture,
                        FixtureFaderControl::ColorMixer(ColorChannel::Blue),
                        blue,
                        self.priority,
                    );
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
