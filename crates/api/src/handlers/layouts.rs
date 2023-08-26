use mizer_command_executor::*;
use mizer_node::NodePath;
use mizer_runtime::LayoutsView;

use crate::proto::layouts::*;
use crate::proto::programmer::PresetId;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct LayoutsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> LayoutsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_layouts(&self) -> Layouts {
        Layouts {
            layouts: self
                .runtime
                .layouts()
                .into_iter()
                .map(Layout::from)
                .collect::<Vec<_>>(),
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_layout(&self, name: String) -> Layouts {
        self.runtime.run_command(AddLayoutCommand { name }).unwrap();

        self.get_layouts()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_layout(&self, id: String) -> Layouts {
        self.runtime
            .run_command(RemoveLayoutCommand { id })
            .unwrap();

        self.get_layouts()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn rename_layout(&self, id: String, name: String) -> Layouts {
        self.runtime
            .run_command(RenameLayoutCommand { id, name })
            .unwrap();

        self.get_layouts()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_control(&self, layout_id: String, control_id: String) {
        log::debug!("Removing control {} in layout {}", control_id, layout_id);
        self.runtime
            .run_command(DeleteLayoutControlCommand {
                layout_id,
                control_id: control_id.try_into().unwrap(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn move_control(&self, layout_id: String, control_id: String, position: ControlPosition) {
        let position = position.into();
        log::debug!(
            "Moving control {} in layout {} to {:?}",
            control_id,
            layout_id,
            position
        );
        self.runtime
            .run_command(MoveLayoutControlCommand {
                layout_id,
                control_id: control_id.try_into().unwrap(),
                position,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn resize_control(&self, layout_id: String, control_id: String, size: ControlSize) {
        let size = size.into();
        log::debug!(
            "Moving control {} in layout {} to {:?}",
            control_id,
            layout_id,
            size
        );
        self.runtime
            .run_command(ResizeLayoutControlCommand {
                layout_id,
                control_id: control_id.try_into().unwrap(),
                size,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_control_decorations(
        &self,
        layout_id: String,
        control_id: String,
        decorations: ControlDecorations,
    ) {
        let decorations = decorations.into();
        log::debug!(
            "Updating control {} in layout {} with {:?}",
            control_id,
            layout_id,
            decorations
        );
        self.runtime
            .run_command(UpdateLayoutControlDecorationsCommand {
                layout_id,
                control_id: control_id.try_into().unwrap(),
                decorations,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_control_behavior(
        &self,
        layout_id: String,
        control_id: String,
        behavior: ControlBehavior,
    ) {
        let behavior = behavior.into();
        log::debug!(
            "Updating control {} in layout {} with {:?}",
            control_id,
            layout_id,
            behavior
        );
        self.runtime
            .run_command(UpdateLayoutControlBehaviorCommand {
                layout_id,
                control_id: control_id.try_into().unwrap(),
                behavior,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn rename_control(&self, layout_id: String, control_id: String, name: String) {
        log::debug!(
            "Renaming control {} in layout {} to {}",
            control_id,
            layout_id,
            name
        );

        self.runtime
            .run_command(RenameLayoutControlCommand {
                layout_id,
                control_id: control_id.try_into().unwrap(),
                name,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_control(
        &self,
        layout_id: String,
        node_type: ControlType,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddLayoutControlWithNodeCommand {
            layout_id,
            node_type: node_type.into(),
            position: position.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_control_for_node(
        &self,
        layout_id: String,
        node_path: NodePath,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddLayoutControlCommand {
            layout_id,
            control_type: mizer_layouts::ControlType::Node { path: node_path },
            position: position.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_control_for_sequence(
        &self,
        layout_id: String,
        sequence_id: u32,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddLayoutControlCommand {
            layout_id,
            control_type: mizer_layouts::ControlType::Sequencer { sequence_id },
            position: position.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_control_for_group(
        &self,
        layout_id: String,
        group_id: u32,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddLayoutControlCommand {
            layout_id,
            control_type: mizer_layouts::ControlType::Group {
                group_id: group_id.into(),
            },
            position: position.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_control_for_preset(
        &self,
        layout_id: String,
        preset_id: PresetId,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddLayoutControlCommand {
            layout_id,
            control_type: mizer_layouts::ControlType::Preset {
                preset_id: preset_id.into(),
            },
            position: position.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn read_fader_value(&self, node_path: NodePath) -> Option<f64> {
        match self.runtime.read_fader_value(node_path) {
            Ok(value) => Some(value),
            Err(err) => {
                tracing::error!("Error reading fader value: {:?}", err);
                None
            }
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn layouts_view(&self) -> LayoutsView {
        self.runtime.layouts_view()
    }
}
