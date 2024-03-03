use image::{Pixel, Rgba};
use serde::{Deserialize, Serialize};

use mizer_fixtures::definition::{ColorChannel, FixtureFaderControl};
use mizer_fixtures::manager::FixtureManager;
use mizer_node::*;
use mizer_pixel_nodes::texture_to_pixels::TextureToPixelsConverter;
use mizer_plan::{Plan, PlanScreen, PlanStorage, ScreenId};
use mizer_util::ConvertBytes;

const INPUT_PORT: &str = "Input";

const SCREEN_SETTING: &str = "Screen";

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

impl ConfigurableNode for PlanScreenNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let storage = injector.get::<PlanStorage>().unwrap();
        let plans = storage.read();
        let screens = plans
            .into_iter()
            .flat_map(|plan| {
                plan.screens
                    .into_iter()
                    .map(move |screen| (plan.name.clone(), screen))
            })
            .map(|(plan, screen)| IdVariant {
                value: screen.screen_id.0,
                label: format!("{} / {}", plan, screen.screen_id.0),
            })
            .collect();

        vec![setting!(id SCREEN_SETTING, self.screen_id.0, screens)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, SCREEN_SETTING, self.screen_id, ScreenId);

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
        plan.screens
            .into_iter()
            .find(|s| s.screen_id == self.screen_id)
    }

    fn convert_pixels(width: u32, pixels: Vec<Rgba<u8>>) -> Vec<Vec<Color>> {
        pixels
            .into_iter()
            .map(|pixel| {
                let bytes = pixel.to_rgb();
                Color::rgb(
                    f64::from_8bit(bytes[0]),
                    f64::from_8bit(bytes[1]),
                    f64::from_8bit(bytes[2]),
                )
            })
            .collect::<Vec<Color>>()
            .chunks_exact(width as usize)
            .map(|row| row.to_vec())
            .collect()
    }
}

impl PipelineNode for PlanScreenNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Plan Screen".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
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
        let Some(screen) = plan.screens.iter().find(|s| s.screen_id == self.screen_id) else {
            return Ok(());
        };
        if let Some(state) = state.as_mut() {
            if let Some(pixels) = state.post_process(context, screen.width, screen.height)? {
                let pixel_data = Self::convert_pixels(screen.width, pixels);
                for fixture in plan.fixtures.iter().filter(|f| screen.contains_fixture(f)) {
                    let (x, y) = screen.translate_position(fixture);
                    // TODO: the downsampling of the input texture does not take into account that pixels can be smaller than 1 pixel
                    // in the future we should probably sample the picture for each pixel instead of down sampling it and then using the nearest pixel
                    let x = x.round() as usize;
                    let y = y.round() as usize;
                    let Some(color) = pixel_data.get(y).and_then(|row| row.get(x)) else {
                        continue;
                    };
                    manager.write_fixture_control(
                        fixture.fixture,
                        FixtureFaderControl::Intensity,
                        color.alpha,
                        Default::default(),
                    );
                    manager.write_fixture_control(
                        fixture.fixture,
                        FixtureFaderControl::ColorMixer(ColorChannel::Red),
                        color.red,
                        Default::default(),
                    );
                    manager.write_fixture_control(
                        fixture.fixture,
                        FixtureFaderControl::ColorMixer(ColorChannel::Green),
                        color.green,
                        Default::default(),
                    );
                    manager.write_fixture_control(
                        fixture.fixture,
                        FixtureFaderControl::ColorMixer(ColorChannel::Blue),
                        color.blue,
                        Default::default(),
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
