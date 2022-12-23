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
            ..Default::default()
        }
    }
}

impl From<align_fixtures_request::AlignDirection> for AlignFixturesDirection {
    fn from(direction: align_fixtures_request::AlignDirection) -> Self {
        use align_fixtures_request::AlignDirection::*;

        match direction {
            LeftToRight => Self::LeftToRight,
            TopToBottom => Self::TopToBottom,
        }
    }
}
