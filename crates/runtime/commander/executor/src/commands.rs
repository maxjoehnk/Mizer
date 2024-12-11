use std::any::Any;

use derive_more::From;

use mizer_commander::Command;
pub use mizer_fixture_commands::*;
pub use mizer_layout_commands::*;
pub use mizer_node_templates::ExecuteNodeTemplateCommand;
pub use mizer_plan::commands::*;
use mizer_processing::Injector;
pub use mizer_protocol_dmx::commands::*;
pub use mizer_protocol_midi::commands::*;
pub use mizer_protocol_mqtt::commands::*;
pub use mizer_protocol_osc::commands::*;
pub use mizer_runtime::commands::*;
pub use mizer_sequencer_commands::*;
pub use mizer_surfaces::commands::*;
pub use mizer_timecode::commands::*;

pub use crate::aggregates::*;
use crate::executor::{CommandExecutor, CommandKey};

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
                command_key: Option<CommandKey>,
            ) -> anyhow::Result<(Box<dyn Any + Send + Sync>, CommandKey)> {
                match &self {
                    $(Self::$x(cmd) => self._apply(injector, executor, cmd, command_key),)*
                }
            }
            pub(crate) fn revert(
                &self,
                injector: &mut Injector,
                executor: &mut CommandExecutor,
                command_key: &CommandKey,
            ) -> anyhow::Result<()> {
                match &self {
                    $(Self::$x(cmd) => executor.revert(injector, cmd, command_key),)*
                }
            }

            pub fn label(&self) -> String {
                match self {
                    $(Self::$x(cmd) => cmd.label(),)*
                }
            }

            pub fn execute<E: crate::ICommandExecutor>(self, executor: &E) -> anyhow::Result<()> {
                match self {
                    $(Self::$x(cmd) => {
                        executor.run_command(cmd)?;

                        Ok(())
                    })*
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
    AssignProgrammerToGroupCommand,
    UpdateFixtureCommand,
    SelectFixturesCommand,
    ClearProgrammerCommand,
    CallPresetCommand,
    CallEffectCommand,
    CallGroupCommand,
    ToggleHighlightCommand,
    WriteProgrammerCommand,
    AddPresetCommand,
    StoreInPresetCommand,
    DeletePresetCommand,
    RenamePresetCommand,
    AddNodeCommand,
    DeleteNodesCommand,
    DuplicateNodesCommand,
    ShowNodeCommand,
    HideNodeCommand,
    MoveNodesCommand,
    RenameNodeCommand,
    GroupNodesCommand,
    UpdateNodeSettingCommand,
    UpdateNodeColorCommand,
    AddLinkCommand,
    RemoveLinkCommand,
    DisconnectPortsCommand,
    DisconnectPortCommand,
    AddCommentCommand,
    UpdateCommentCommand,
    DeleteCommentCommand,
    AddPlanCommand,
    RemovePlanCommand,
    RenamePlanCommand,
    MoveFixturesInPlanCommand,
    TransformFixturesInPlanCommand,
    AddFixturesToPlanCommand,
    AlignFixturesInPlanCommand,
    SpreadFixturesInPlanCommand,
    AddPlanImageCommand,
    MovePlanImageCommand,
    ResizePlanImageCommand,
    RemovePlanImageCommand,
    AddPlanScreenCommand,
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
    UpdateSequencePriorityCommand,
    StopSequenceCommand,
    SequenceGoForwardCommand,
    SequenceGoBackwardCommand,
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
    UpdateSurfaceSectionCommand,
    ChangeMidiDeviceProfileCommand,
}

impl CommandImpl {
    fn _apply<'a>(
        &self,
        injector: &'a mut Injector,
        executor: &'a mut CommandExecutor,
        cmd: &(impl Command<'a> + 'static),
        command_key: Option<CommandKey>,
    ) -> anyhow::Result<(Box<dyn Any + Send + Sync>, CommandKey)> {
        let (result, command_key) = executor.apply(injector, cmd, command_key)?;

        Ok((Box::new(result), command_key))
    }
}
