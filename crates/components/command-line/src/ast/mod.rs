mod parser;

use std::ops::Deref;
pub use parser::parse;
use crate::Id;

pub struct Value(u32);

pub struct Full;

pub struct Fixtures;

pub struct Sequences;

pub struct Groups;

pub struct Presets;

trait Type {}

impl Type for Fixtures {}

impl Type for Sequences {}

impl Type for Groups {}

impl Type for Presets {}

pub struct ActiveSelection;

pub struct Single {
    pub id: Id,
}

pub struct Range {
    pub from: Id,
    pub to: Id,
}

impl Range {
    pub fn evaluate_range(&self) -> Vec<Id> {
        match (self.from.deref(), self.to.deref()) {
            (&[from], &[to]) => {
                (from..=to).map(|id| Id::single(id)).collect()
            }
            _ => todo!()
        }
    }
}

trait Entity {}

impl Entity for ActiveSelection {}

impl Entity for Single {}

impl Entity for Range {}

pub struct Delete<TTargetType: Type, TTargetEntity: Entity> {
    pub target_type: TTargetType,
    pub target_entity: TTargetEntity,
}

pub struct Store<TSourceType: Type, TSourceEntity: Entity, TTargetType: Type, TTargetEntity: Entity> {
    pub source_type: TSourceType,
    pub source_entity: TSourceEntity,
    pub target_type: TTargetType,
    pub target_entity: TTargetEntity,
}

pub struct Select<TargetType: Type, TargetEntity: Entity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

pub struct Highlight;

pub struct Clear;

pub struct Call<TargetType: Type, TargetEntity: Entity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

pub struct Off<TargetType, TargetEntity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

pub struct GoForward<TargetType, TargetEntity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

pub struct GoBackward<TargetType, TargetEntity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

pub struct Write<TargetType, TargetEntity, Value> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
    pub value: Value,
}

pub struct Name<TargetType, TargetEntity> {
    pub target_type: TargetType,
    pub target_entity: TargetEntity,
}

#[cfg(test)]
mod tests {
    use test_case::test_case;
    
    use super::*;
    
    #[test_case(Id::single(1), Id::single(4), vec![Id::single(1), Id::single(2), Id::single(3), Id::single(4)])]
    #[test_case(Id::new([1, 1]), Id::new([1, 4]), vec![Id::new([1, 1]), Id::new([1, 2]), Id::new([1, 3]), Id::new([1, 4])])]
    fn range_evaluate_range(from: Id, to: Id, expected: Vec<Id>) {
        let range = Range {
            from,
            to,
        };
        
        let result = range.evaluate_range();
        
        assert_eq!(result, expected);
    }
}