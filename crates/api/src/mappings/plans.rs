use crate::models::plans::*;
use mizer_plan::commands::AlignFixturesDirection;
use protobuf::MessageField;

impl From<mizer_plan::Plan> for Plan {
    fn from(plan: mizer_plan::Plan) -> Self {
        Self {
            name: plan.name,
            positions: plan
                .fixtures
                .into_iter()
                .map(|f| FixturePosition {
                    id: MessageField::some(f.fixture.into()),
                    x: f.x,
                    y: f.y,
                    width: f.width,
                    height: f.height,
                    ..Default::default()
                })
                .collect(),
            screens: plan
                .screens
                .into_iter()
                .map(|s| PlanScreen {
                    id: s.screen_id.into(),
                    x: s.x,
                    y: s.y,
                    width: s.width,
                    height: s.height,
                    ..Default::default()
                })
                .collect(),
            images: plan
                .images
                .into_iter()
                .map(|i| PlanImage {
                    id: i.id.to_string(),
                    x: i.x,
                    y: i.y,
                    width: i.width,
                    height: i.height,
                    transparency: i.transparency,
                    data: i.data.try_to_buffer().unwrap_or_default(),
                    ..Default::default()
                })
                .collect(),
            ..Default::default()
        }
    }
}

impl From<align_fixtures_request::AlignDirection> for AlignFixturesDirection {
    fn from(direction: align_fixtures_request::AlignDirection) -> Self {
        use align_fixtures_request::AlignDirection::*;

        match direction {
            LEFT_TO_RIGHT => Self::LeftToRight,
            TOP_TO_BOTTOM => Self::TopToBottom,
        }
    }
}
