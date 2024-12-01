mod parser;

pub(crate) use crate::Id;
pub use parser::parse;

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Value(pub(crate) u32);

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Full;

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Fixtures;

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Sequences;

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Groups;

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Presets;

pub trait Type {}

impl Type for Fixtures {}

impl Type for Sequences {}

impl Type for Groups {}

impl Type for Presets {}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct ActiveSelection;

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Single {
    pub id: Id,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Range {
    pub from: Id,
    pub to: Id,
}

impl Range {
    pub fn evaluate_range(&self, available_ids: &[Id]) -> Vec<Id> {
        // TODO: This should probably be supported in the future but I'm not sure how it should behave
        if self.from.depth() != self.to.depth() {
            return Default::default();
        }

        if self.from.depth() == 1 {
            let from = self.from.first();
            let to = self.to.first();

            return (from..=to).map(Id::single).collect();
        }

        let mut relevant_ids = available_ids
            .iter()
            .filter(|id| id.depth() == self.from.depth())
            .filter(|id| *id >= &self.from && *id <= &self.to)
            .copied()
            .collect::<Vec<_>>();

        relevant_ids.sort();

        relevant_ids
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct All;

pub trait Entity {}

impl Entity for ActiveSelection {}

impl Entity for Single {}

impl Entity for Range {}

impl Entity for All {}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Delete<TTargetType: Type, TTargetEntity: Entity> {
    pub target_type: TTargetType,
    pub target_entity: TTargetEntity,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Store<TSourceType: Type, TSourceEntity: Entity, TTargetType: Type, TTargetEntity: Entity>
{
    pub source_type: TSourceType,
    pub source_entity: TSourceEntity,
    pub target_type: TTargetType,
    pub target_entity: TTargetEntity,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Select<TargetType: Type, TargetEntity: Entity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Highlight;

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Clear;

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Call<TargetType: Type, TargetEntity: Entity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Off<TargetType, TargetEntity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct GoForward<TargetType, TargetEntity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct GoBackward<TargetType, TargetEntity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Write<TargetType, TargetEntity, Value> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
    pub value: Value,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Name<TargetType, TargetEntity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use super::*;

    #[test_case(Id::single(1), Id::single(4), vec![Id::single(1), Id::single(2), Id::single(3), Id::single(4)])]
    #[test_case(Id::single(1), Id::single(2), vec![Id::single(1), Id::single(2)])]
    #[test_case(Id::new([1, 2]), Id::new([1, 4]), vec![Id::new([1, 2]), Id::new([1, 3]), Id::new([1, 4])])]
    #[test_case(Id::new([1, 1]), Id::new([4, 2]), vec![Id::new([1, 1]), Id::new([1, 2]), Id::new([1, 3]), Id::new([1, 4]), Id::new([2, 1]), Id::new([2, 2]), Id::new([2, 3]), Id::new([2, 4]), Id::new([3, 1]), Id::new([3, 2]), Id::new([3, 3]), Id::new([3, 4]), Id::new([4, 1]), Id::new([4, 2])])]
    fn range_evaluate_range(from: Id, to: Id, expected: Vec<Id>) {
        let available_ids = vec![
            Id::single(1),
            Id::new([1, 1]),
            Id::new([1, 2]),
            Id::new([1, 3]),
            Id::new([1, 4]),
            Id::single(2),
            Id::new([2, 1]),
            Id::new([2, 2]),
            Id::new([2, 3]),
            Id::new([2, 4]),
            Id::single(3),
            Id::new([3, 1]),
            Id::new([3, 2]),
            Id::new([3, 3]),
            Id::new([3, 4]),
            Id::single(4),
            Id::new([4, 1]),
            Id::new([4, 2]),
            Id::new([4, 3]),
            Id::new([4, 4]),
        ];
        let range = Range { from, to };

        let result = range.evaluate_range(&available_ids);

        assert_eq!(result, expected);
    }
}
