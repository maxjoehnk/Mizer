use crate::executor::CommandExecutor;
use derive_more::From;
use mizer_commander::Command;
use mizer_processing::Injector;
use std::any::Any;

pub use crate::aggregates::*;
pub use mizer_fixture_commands::*;
pub use mizer_layout_commands::*;
pub use mizer_node_templates::ExecuteNodeTemplateCommand;
pub use mizer_plan::commands::*;
pub use mizer_protocol_dmx::commands::*;
pub use mizer_protocol_mqtt::commands::*;
pub use mizer_protocol_osc::commands::*;
pub use mizer_runtime::commands::*;
pub use mizer_sequencer_commands::*;

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
    AssignFixturesToGroupCommand,
    UpdateFixtureCommand,
    AddNodeCommand,
    DeleteNodeCommand,
    DuplicateNodeCommand,
    ShowNodeCommand,
    HideNodeCommand,
    MoveNodeCommand,
    RenameNodeCommand,
    UpdateNodeCommand,
    GroupNodesCommand,
    AddLinkCommand,
    DisconnectPortsCommand,
    AddPlanCommand,
    RemovePlanCommand,
    RenamePlanCommand,
    MoveFixturesInPlanCommand,
    AddFixturesToPlanCommand,
    AlignFixturesInPlanCommand,
    AddLayoutCommand,
    RenameLayoutCommand,
    RemoveLayoutCommand,
    AddLayoutControlCommand,
    AddLayoutControlWithNodeCommand,
    DeleteLayoutControlCommand,
    RenameLayoutControlCommand,
    MoveLayoutControlCommand,
    UpdateLayoutControlDecorationsCommand,
    AddSequenceCommand,
    DeleteSequenceCommand,
    StoreProgrammerInSequenceCommand,
    RenameSequenceCommand,
    DuplicateSequenceCommand,
    RenameCueCommand,
    UpdateControlDelayTimeCommand,
    UpdateControlFadeTimeCommand,
    UpdateCueTriggerCommand,
    UpdateCueTriggerTimeCommand,
    UpdateCueValueCommand,
    UpdateSequenceWrapAroundCommand,
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
    DeleteOutputCommand,
    AddMqttConnectionCommand,
    DeleteMqttConnectionCommand,
    ConfigureMqttConnectionCommand,
    ExecuteNodeTemplateCommand,
    AddOscConnectionCommand,
    ConfigureOscConnectionCommand,
    DeleteOscConnectionCommand,
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
