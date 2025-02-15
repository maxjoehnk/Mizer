use futures::Stream;
use futures::StreamExt;

use mizer_timecode::commands::*;
use mizer_timecode::queries::{ListTimecodeControlsQuery, ListTimecodeTracksQuery};
use mizer_timecode::TimecodeManager;
pub use mizer_timecode::TimecodeStateAccess;

use crate::proto::timecode::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct TimecodeHandler<R: RuntimeApi> {
    manager: TimecodeManager,
    runtime: R,
}

impl<R: RuntimeApi> TimecodeHandler<R> {
    pub fn new(manager: TimecodeManager, runtime: R) -> Self {
        Self { manager, runtime }
    }

    pub fn observe_timecodes(&self) -> impl Stream<Item = AllTimecodes> {
        self.manager
            .observe_timecodes()
            .into_stream()
            .map(|timecodes| {
                let timecodes = timecodes.into_iter().map(Timecode::from).collect();

                AllTimecodes {
                    timecodes,
                    controls: Default::default(),
                }
            })
    }

    #[profiling::function]
    pub fn get_timecodes(&self) -> AllTimecodes {
        let timecodes = self.runtime.execute_query(ListTimecodeTracksQuery).unwrap();
        let controls = self
            .runtime
            .execute_query(ListTimecodeControlsQuery)
            .unwrap();
        let timecodes = timecodes.into_iter().map(Timecode::from).collect();
        let controls = controls.into_iter().map(TimecodeControl::from).collect();

        AllTimecodes {
            timecodes,
            controls,
        }
    }

    #[profiling::function]
    pub fn add_timecode(&self, req: AddTimecodeRequest) -> anyhow::Result<()> {
        self.runtime
            .run_command(AddTimecodeCommand { name: req.name })?;

        Ok(())
    }

    #[profiling::function]
    pub fn rename_timecode(&self, req: RenameTimecodeRequest) -> anyhow::Result<()> {
        self.runtime.run_command(RenameTimecodeCommand {
            id: req.id.into(),
            name: req.name,
        })?;

        Ok(())
    }

    #[profiling::function]
    pub fn delete_timecode(&self, req: DeleteTimecodeRequest) -> anyhow::Result<()> {
        self.runtime
            .run_command(DeleteTimecodeCommand { id: req.id.into() })?;

        Ok(())
    }

    #[profiling::function]
    pub fn add_timecode_control(&self, req: AddTimecodeControlRequest) -> anyhow::Result<()> {
        self.runtime
            .run_command(AddTimecodeControlCommand { name: req.name })?;

        Ok(())
    }

    #[profiling::function]
    pub fn rename_timecode_control(&self, req: RenameTimecodeControlRequest) -> anyhow::Result<()> {
        self.runtime.run_command(RenameTimecodeControlCommand {
            id: req.id.into(),
            name: req.name,
        })?;

        Ok(())
    }

    #[profiling::function]
    pub fn delete_timecode_control(&self, req: DeleteTimecodeControlRequest) -> anyhow::Result<()> {
        self.runtime
            .run_command(DeleteTimecodeControlCommand { id: req.id.into() })?;

        Ok(())
    }

    #[profiling::function]
    pub fn get_timecode_state_ref(&self, id: u32) -> Option<TimecodeStateAccess> {
        self.manager.get_state_access(id.into())
    }

    #[profiling::function]
    pub fn get_timecode_manager(&self) -> TimecodeManager {
        self.manager.clone()
    }
}
