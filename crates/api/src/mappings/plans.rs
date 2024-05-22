use crate::proto::plans::*;
use mizer_plan::commands::{AlignFixturesDirection, SpreadFixturesGeometry};

impl From<mizer_plan::Plan> for Plan {
    fn from(plan: mizer_plan::Plan) -> Self {
        Self {
            name: plan.name,
            positions: plan
                .fixtures
                .into_iter()
                .map(|f| FixturePosition {
                    id: Some(f.fixture.into()),
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
                    id: s.id.into(),
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
            LeftToRight => Self::LeftToRight,
            TopToBottom => Self::TopToBottom,
        }
    }
}

impl From<spread_fixtures_request::SpreadGeometry> for SpreadFixturesGeometry {
    fn from(geometry: spread_fixtures_request::SpreadGeometry) -> Self {
        use spread_fixtures_request::SpreadGeometry;

        match geometry {
            SpreadGeometry::Square => Self::Square,
            SpreadGeometry::Triangle => Self::Triangle,
        }
    }
}
