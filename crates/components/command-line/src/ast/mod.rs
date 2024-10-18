mod parser;

pub use parser::parse;

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
    pub id: u32,
}

pub struct Range {
    pub from: u32,
    pub to: u32,
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
