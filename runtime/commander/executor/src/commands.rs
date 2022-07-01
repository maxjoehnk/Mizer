use crate::executor::CommandExecutor;
use derive_more::From;
use mizer_commander::Command;
use mizer_processing::Injector;
use std::any::Any;

pub use crate::aggregates::*;
pub use mizer_fixture_commands::*;
pub use mizer_layout_commands::*;
pub use mizer_plan::commands::*;
pub use mizer_protocol_dmx::commands::*;
pub use mizer_runtime::commands::*;
pub use mizer_sequencer_commands::*;

pub trait SendableCommand<'a>: Command<'a> + Into<CommandImpl> + Send + Sync {}

impl<'a, T: Command<'a> + Into<CommandImpl> + Send + Sync> SendableCommand<'a> for T {}

#[derive(Debug, From)]
pub enum CommandImpl {
    PatchFixturesCommand(PatchFixturesCommand),
    DeleteFixturesCommand(DeleteFixturesCommand),
    AddGroupCommand(AddGroupCommand),
    DeleteGroupCommand(DeleteGroupCommand),
    AssignFixturesToGroupCommand(AssignFixturesToGroupCommand),
    UpdateFixtureCommand(UpdateFixtureCommand),
    AddNodeCommand(AddNodeCommand),
    DeleteNodeCommand(DeleteNodeCommand),
    DuplicateNodeCommand(DuplicateNodeCommand),
    ShowNodeCommand(ShowNodeCommand),
    HideNodeCommand(HideNodeCommand),
    MoveNodeCommand(MoveNodeCommand),
    UpdateNodeCommand(UpdateNodeCommand),
    AddLinkCommand(AddLinkCommand),
    DisconnectPortsCommand(DisconnectPortsCommand),
    AddPlanCommand(AddPlanCommand),
    RemovePlanCommand(RemovePlanCommand),
    RenamePlanCommand(RenamePlanCommand),
    MoveFixturesInPlanCommand(MoveFixturesInPlanCommand),
    AddFixturesToPlanCommand(AddFixturesToPlanCommand),
    AddLayoutCommand(AddLayoutCommand),
    RenameLayoutCommand(RenameLayoutCommand),
    RemoveLayoutCommand(RemoveLayoutCommand),
    AddLayoutControlCommand(AddLayoutControlCommand),
    AddLayoutControlWithNodeCommand(AddLayoutControlWithNodeCommand),
    DeleteLayoutControlCommand(DeleteLayoutControlCommand),
    RenameLayoutControlCommand(RenameLayoutControlCommand),
    MoveLayoutControlCommand(MoveLayoutControlCommand),
    UpdateLayoutControlDecorationsCommand(UpdateLayoutControlDecorationsCommand),
    AddSequenceCommand(AddSequenceCommand),
    DeleteSequenceCommand(DeleteSequenceCommand),
    StoreProgrammerInSequenceCommand(StoreProgrammerInSequenceCommand),
    RenameSequenceCommand(RenameSequenceCommand),
    RenameCueCommand(RenameCueCommand),
    UpdateControlDelayTimeCommand(UpdateControlDelayTimeCommand),
    UpdateControlFadeTimeCommand(UpdateControlFadeTimeCommand),
    UpdateCueTriggerCommand(UpdateCueTriggerCommand),
    UpdateCueTriggerTimeCommand(UpdateCueTriggerTimeCommand),
    UpdateCueValueCommand(UpdateCueValueCommand),
    UpdateSequenceWrapAroundCommand(UpdateSequenceWrapAroundCommand),
    DeleteEffectCommand(DeleteEffectCommand),
    AddArtnetOutputCommand(AddArtnetOutputCommand),
    AddSacnOutputCommand(AddSacnOutputCommand),
    ConfigureArtnetOutputCommand(ConfigureArtnetOutputCommand),
    DeleteOutputCommand(DeleteOutputCommand),
}

impl CommandImpl {
    pub(crate) fn apply(
        &self,
        injector: &mut Injector,
        executor: &mut CommandExecutor,
    ) -> anyhow::Result<Box<dyn Any + Send + Sync>> {
        match &self {
            Self::PatchFixturesCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DeleteFixturesCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddGroupCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DeleteGroupCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AssignFixturesToGroupCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateFixtureCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddNodeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DeleteNodeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DuplicateNodeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::ShowNodeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::HideNodeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::MoveNodeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateNodeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddLinkCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DisconnectPortsCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddPlanCommand(cmd) => self._apply(injector, executor, cmd),
            Self::RenamePlanCommand(cmd) => self._apply(injector, executor, cmd),
            Self::RemovePlanCommand(cmd) => self._apply(injector, executor, cmd),
            Self::MoveFixturesInPlanCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddFixturesToPlanCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddLayoutCommand(cmd) => self._apply(injector, executor, cmd),
            Self::RenameLayoutCommand(cmd) => self._apply(injector, executor, cmd),
            Self::RemoveLayoutCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddLayoutControlCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddLayoutControlWithNodeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DeleteLayoutControlCommand(cmd) => self._apply(injector, executor, cmd),
            Self::RenameLayoutControlCommand(cmd) => self._apply(injector, executor, cmd),
            Self::MoveLayoutControlCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateLayoutControlDecorationsCommand(cmd) => {
                self._apply(injector, executor, cmd)
            }
            Self::AddSequenceCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DeleteSequenceCommand(cmd) => self._apply(injector, executor, cmd),
            Self::StoreProgrammerInSequenceCommand(cmd) => self._apply(injector, executor, cmd),
            Self::RenameSequenceCommand(cmd) => self._apply(injector, executor, cmd),
            Self::RenameCueCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateControlDelayTimeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateControlFadeTimeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateCueTriggerCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateCueTriggerTimeCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateCueValueCommand(cmd) => self._apply(injector, executor, cmd),
            Self::UpdateSequenceWrapAroundCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DeleteEffectCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddArtnetOutputCommand(cmd) => self._apply(injector, executor, cmd),
            Self::AddSacnOutputCommand(cmd) => self._apply(injector, executor, cmd),
            Self::ConfigureArtnetOutputCommand(cmd) => self._apply(injector, executor, cmd),
            Self::DeleteOutputCommand(cmd) => self._apply(injector, executor, cmd),
        }
    }

    pub(crate) fn revert(
        &self,
        injector: &mut Injector,
        executor: &mut CommandExecutor,
    ) -> anyhow::Result<()> {
        match &self {
            Self::PatchFixturesCommand(cmd) => executor.revert(injector, cmd),
            Self::DeleteFixturesCommand(cmd) => executor.revert(injector, cmd),
            Self::AddGroupCommand(cmd) => executor.revert(injector, cmd),
            Self::DeleteGroupCommand(cmd) => executor.revert(injector, cmd),
            Self::AssignFixturesToGroupCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateFixtureCommand(cmd) => executor.revert(injector, cmd),
            Self::AddNodeCommand(cmd) => executor.revert(injector, cmd),
            Self::DeleteNodeCommand(cmd) => executor.revert(injector, cmd),
            Self::DuplicateNodeCommand(cmd) => executor.revert(injector, cmd),
            Self::ShowNodeCommand(cmd) => executor.revert(injector, cmd),
            Self::HideNodeCommand(cmd) => executor.revert(injector, cmd),
            Self::MoveNodeCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateNodeCommand(cmd) => executor.revert(injector, cmd),
            Self::AddLinkCommand(cmd) => executor.revert(injector, cmd),
            Self::DisconnectPortsCommand(cmd) => executor.revert(injector, cmd),
            Self::AddPlanCommand(cmd) => executor.revert(injector, cmd),
            Self::RenamePlanCommand(cmd) => executor.revert(injector, cmd),
            Self::RemovePlanCommand(cmd) => executor.revert(injector, cmd),
            Self::MoveFixturesInPlanCommand(cmd) => executor.revert(injector, cmd),
            Self::AddFixturesToPlanCommand(cmd) => executor.revert(injector, cmd),
            Self::AddLayoutCommand(cmd) => executor.revert(injector, cmd),
            Self::RenameLayoutCommand(cmd) => executor.revert(injector, cmd),
            Self::RemoveLayoutCommand(cmd) => executor.revert(injector, cmd),
            Self::AddLayoutControlCommand(cmd) => executor.revert(injector, cmd),
            Self::AddLayoutControlWithNodeCommand(cmd) => executor.revert(injector, cmd),
            Self::DeleteLayoutControlCommand(cmd) => executor.revert(injector, cmd),
            Self::RenameLayoutControlCommand(cmd) => executor.revert(injector, cmd),
            Self::MoveLayoutControlCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateLayoutControlDecorationsCommand(cmd) => executor.revert(injector, cmd),
            Self::AddSequenceCommand(cmd) => executor.revert(injector, cmd),
            Self::DeleteSequenceCommand(cmd) => executor.revert(injector, cmd),
            Self::StoreProgrammerInSequenceCommand(cmd) => executor.revert(injector, cmd),
            Self::RenameSequenceCommand(cmd) => executor.revert(injector, cmd),
            Self::RenameCueCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateControlDelayTimeCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateControlFadeTimeCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateCueTriggerCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateCueTriggerTimeCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateCueValueCommand(cmd) => executor.revert(injector, cmd),
            Self::UpdateSequenceWrapAroundCommand(cmd) => executor.revert(injector, cmd),
            Self::DeleteEffectCommand(cmd) => executor.revert(injector, cmd),
            Self::AddArtnetOutputCommand(cmd) => executor.revert(injector, cmd),
            Self::AddSacnOutputCommand(cmd) => executor.revert(injector, cmd),
            Self::ConfigureArtnetOutputCommand(cmd) => executor.revert(injector, cmd),
            Self::DeleteOutputCommand(cmd) => executor.revert(injector, cmd),
        }
    }

    pub fn label(&self) -> String {
        match self {
            Self::PatchFixturesCommand(cmd) => cmd.label(),
            Self::DeleteFixturesCommand(cmd) => cmd.label(),
            Self::AddGroupCommand(cmd) => cmd.label(),
            Self::DeleteGroupCommand(cmd) => cmd.label(),
            Self::AssignFixturesToGroupCommand(cmd) => cmd.label(),
            Self::UpdateFixtureCommand(cmd) => cmd.label(),
            Self::AddNodeCommand(cmd) => cmd.label(),
            Self::DeleteNodeCommand(cmd) => cmd.label(),
            Self::DuplicateNodeCommand(cmd) => cmd.label(),
            Self::ShowNodeCommand(cmd) => cmd.label(),
            Self::HideNodeCommand(cmd) => cmd.label(),
            Self::MoveNodeCommand(cmd) => cmd.label(),
            Self::UpdateNodeCommand(cmd) => cmd.label(),
            Self::AddLinkCommand(cmd) => cmd.label(),
            Self::DisconnectPortsCommand(cmd) => cmd.label(),
            Self::AddPlanCommand(cmd) => cmd.label(),
            Self::RenamePlanCommand(cmd) => cmd.label(),
            Self::RemovePlanCommand(cmd) => cmd.label(),
            Self::MoveFixturesInPlanCommand(cmd) => cmd.label(),
            Self::AddFixturesToPlanCommand(cmd) => cmd.label(),
            Self::AddLayoutCommand(cmd) => cmd.label(),
            Self::RemoveLayoutCommand(cmd) => cmd.label(),
            Self::RenameLayoutCommand(cmd) => cmd.label(),
            Self::AddLayoutControlCommand(cmd) => cmd.label(),
            Self::AddLayoutControlWithNodeCommand(cmd) => cmd.label(),
            Self::DeleteLayoutControlCommand(cmd) => cmd.label(),
            Self::RenameLayoutControlCommand(cmd) => cmd.label(),
            Self::MoveLayoutControlCommand(cmd) => cmd.label(),
            Self::UpdateLayoutControlDecorationsCommand(cmd) => cmd.label(),
            Self::AddSequenceCommand(cmd) => cmd.label(),
            Self::DeleteSequenceCommand(cmd) => cmd.label(),
            Self::StoreProgrammerInSequenceCommand(cmd) => cmd.label(),
            Self::RenameSequenceCommand(cmd) => cmd.label(),
            Self::RenameCueCommand(cmd) => cmd.label(),
            Self::UpdateControlDelayTimeCommand(cmd) => cmd.label(),
            Self::UpdateControlFadeTimeCommand(cmd) => cmd.label(),
            Self::UpdateCueTriggerCommand(cmd) => cmd.label(),
            Self::UpdateCueTriggerTimeCommand(cmd) => cmd.label(),
            Self::UpdateCueValueCommand(cmd) => cmd.label(),
            Self::UpdateSequenceWrapAroundCommand(cmd) => cmd.label(),
            Self::DeleteEffectCommand(cmd) => cmd.label(),
            Self::AddArtnetOutputCommand(cmd) => cmd.label(),
            Self::AddSacnOutputCommand(cmd) => cmd.label(),
            Self::ConfigureArtnetOutputCommand(cmd) => cmd.label(),
            Self::DeleteOutputCommand(cmd) => cmd.label(),
        }
    }

    fn _apply<'a>(
        &self,
        injector: &'a mut Injector,
        executor: &'a mut CommandExecutor,
        cmd: &(impl Command<'a> + 'static),
    ) -> anyhow::Result<Box<dyn Any + Send + Sync>> {
        let result = executor.apply(injector, cmd)?;

        Ok(Box::new(result))
    }
}
