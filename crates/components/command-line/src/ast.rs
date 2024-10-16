use crate::Command;
use std::marker::PhantomData;

pub struct Fixtures;
pub struct Sequences;
pub struct Groups;

pub struct ActiveSelection;
pub struct Single(u32);
pub struct Range(u32, u32);

pub struct Delete<TargetType, TargetEntity>(PhantomData<TargetType>, PhantomData<TargetEntity>);
pub struct Store<SourceType, SourceEntity, TargetType, TargetEntity>(
    PhantomData<SourceType>,
    PhantomData<SourceEntity>,
    PhantomData<TargetType>,
    PhantomData<TargetEntity>,
);
pub struct Select<TargetType, TargetEntity>(PhantomData<TargetType>, PhantomData<TargetEntity>);
pub struct Highlight;
pub struct Clear;
pub struct Call<TargetType, TargetEntity>(PhantomData<TargetType>, PhantomData<TargetEntity>);

impl<TargetType: 'static, TargetEntity: 'static> Delete<TargetType, TargetEntity>
where
    Delete<TargetType, TargetEntity>: Command,
{
    pub fn new() -> Box<dyn Command> {
        Box::new(Self(PhantomData, PhantomData))
    }
}

impl<SourceType: 'static, SourceEntity: 'static, TargetType: 'static, TargetEntity: 'static>
    Store<SourceType, SourceEntity, TargetType, TargetEntity>
where
    Store<SourceType, SourceEntity, TargetType, TargetEntity>: Command,
{
    pub fn new() -> Box<dyn Command> {
        Box::new(Self(PhantomData, PhantomData, PhantomData, PhantomData))
    }
}

impl<TargetType: 'static, TargetEntity: 'static> Select<TargetType, TargetEntity>
where
    Select<TargetType, TargetEntity>: Command,
{
    pub fn new() -> Box<dyn Command> {
        Box::new(Self(PhantomData, PhantomData))
    }
}

impl Clear {
    pub fn new() -> Box<dyn Command> {
        Box::new(Self)
    }
}

impl Highlight {
    pub fn new() -> Box<dyn Command> {
        Box::new(Self)
    }
}

impl<TargetType: 'static, TargetEntity: 'static> Call<TargetType, TargetEntity>
where
    Call<TargetType, TargetEntity>: Command,
{
    pub fn new() -> Box<dyn Command> {
        Box::new(Self(PhantomData, PhantomData))
    }
}
