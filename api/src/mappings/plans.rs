use crate::models::*;
use protobuf::SingularPtrField;

impl From<mizer_plan::Plan> for Plan {
    fn from(plan: mizer_plan::Plan) -> Self {
        Self {
            name: plan.name,
            positions: plan
                .fixtures
                .into_iter()
                .map(|f| FixturePosition {
                    id: SingularPtrField::some(f.fixture.into()),
                    x: f.x,
                    y: f.y,
                    ..Default::default()
                })
                .collect(),
            ..Default::default()
        }
    }
}
