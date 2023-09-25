use std::any::Any;

use derive_more::From;

use mizer_commander::Command;
pub use mizer_fixture_commands::*;
pub use mizer_layout_commands::*;
pub use mizer_node_templates::ExecuteNodeTemplateCommand;
pub use mizer_plan::commands::*;
use mizer_processing::Injector;
pub use mizer_protocol_dmx::commands::*;
pub use mizer_protocol_mqtt::commands::*;
pub use mizer_protocol_osc::commands::*;
pub use mizer_runtime::commands::*;
pub use mizer_sequencer_commands::*;
pub use mizer_timecode::commands::*;

pub use crate::aggregates::*;
use crate::executor::CommandExecutor;

pub trait SendableCommand<'a>: Command<'a> + Into<CommandImpl> + Send + Sync {}

impl<'a, T: Command<'a> + Into<CommandImpl> + Send + Sync> SendableCommand<'a> for T {}

macro_rules! command_impl {
    ($($x:ident,)*) => {
        #[derive(Debug, From)]
        pub enum CommandImpl {
            $($x($x),)*
        }

        impl CommandImpl {
            pub(crate) fn apply(
                &self,
                injector: &mut Injector,
                executor: &mut CommandExecutor,
            ) -> anyhow::Result<Box<dyn Any + Send + Sync>> {
                match &self {
                    $(Self::$x(cmd) => self._apply(injector, executor, cmd),)*
                }
            }
            pub(crate) fn revert(
                &self,
                injector: &mut Injector,
                executor: &mut CommandExecutor,
            ) -> anyhow::Result<()> {
                match &self {
                    $(Self::$x(cmd) => executor.revert(injector, cmd),)*
                }
            }

            pub fn label(&self) -> String {
                match self {
                    $(Self::$x(cmd) => cmd.label(),)*
                }
            }
        }
    }
}

command_impl! {
    PatchFixturesCommand,
    DeleteFixturesCommand,
    AddGroupCommand,
    DeleteGroupCommand,
    RenameGroupCommand,
    AssignFixturesToGroupCommand,
    UpdateFixtureCommand,
    AddPresetCommand,
    StoreInPresetCommand,
    DeletePresetCommand,
    RenamePresetCommand,
    AddNodeCommand,
    DeleteNodeCommand,
    DuplicateNodeCommand,
    ShowNodeCommand,
    HideNodeCommand,
    MoveNodeCommand,
    RenameNodeCommand,
    GroupNodesCommand,
    UpdateNodeSettingCommand,
    AddLinkCommand,
    RemoveLinkCommand,
    DisconnectPortsCommand,
    AddPlanCommand,
    RemovePlanCommand,
    RenamePlanCommand,
    MoveFixturesInPlanCommand,
    AddFixturesToPlanCommand,
    AlignFixturesInPlanCommand,
    AddPlanImageCommand,
    MovePlanImageCommand,
    ResizePlanImageCommand,
    RemovePlanImageCommand,
    AddLayoutCommand,
    RenameLayoutCommand,
    RemoveLayoutCommand,
    AddLayoutControlCommand,
    AddLayoutControlWithNodeCommand,
    DeleteLayoutControlCommand,
    RenameLayoutControlCommand,
    MoveLayoutControlCommand,
    ResizeLayoutControlCommand,
    UpdateLayoutControlDecorationsCommand,
    UpdateLayoutControlBehaviorCommand,
    AddSequenceCommand,
    DeleteSequenceCommand,
    StoreProgrammerInSequenceCommand,
    RenameSequenceCommand,
    DuplicateSequenceCommand,
    RenameCueCommand,
    UpdateControlDelayTimeCommand,
    UpdateControlFadeTimeCommand,
    UpdateCueEffectOffsetCommand,
    UpdateCueTriggerCommand,
    UpdateCueTriggerTimeCommand,
    UpdateCueValueCommand,
    UpdateSequenceWrapAroundCommand,
    UpdateSequenceStopOnLastCueCommand,
    AddEffectCommand,
    AddEffectChannelCommand,
    AddEffectStepCommand,
    UpdateEffectStepCommand,
    DeleteEffectCommand,
    DeleteEffectChannelCommand,
    DeleteEffectStepCommand,
    AddArtnetOutputCommand,
    AddSacnOutputCommand,
    ConfigureArtnetOutputCommand,
    ConfigureSacnOutputCommand,
    DeleteOutputCommand,
    AddArtnetInputCommand,
    ConfigureArtnetInputCommand,
    DeleteInputCommand,
    AddMqttConnectionCommand,
    DeleteMqttConnectionCommand,
    ConfigureMqttConnectionCommand,
    ExecuteNodeTemplateCommand,
    AddOscConnectionCommand,
    ConfigureOscConnectionCommand,
    DeleteOscConnectionCommand,
    AddTimecodeCommand,
    RenameTimecodeCommand,
    DeleteTimecodeCommand,
    AddTimecodeControlCommand,
    RenameTimecodeControlCommand,
    DeleteTimecodeControlCommand,
}

impl CommandImpl {
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
