use std::ops::DerefMut;
use std::sync::Arc;

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_node::{NodePath, NodeSetting, NodeSettingValue, SelectVariant};
use mizer_nodes::*;
use mizer_pipeline::ProcessingNodeExt;

use crate::pipeline_access::PipelineAccess;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpdateNodeSettingCommand {
    pub path: NodePath,
    pub setting: NodeSetting,
}

impl<'a> Command<'a> for UpdateNodeSettingCommand {
    type Dependencies = RefMut<PipelineAccess>;
    type State = Node;
    type Result = ();

    fn label(&self) -> String {
        match &self.setting.value {
            NodeSettingValue::Float { value, .. } => {
                format!(
                    "Update Node {} setting {} to {}",
                    self.path, self.setting.id, value
                )
            }
            NodeSettingValue::Uint { value, .. } => {
                format!(
                    "Update Node '{}' setting {} to {}",
                    self.path, self.setting.id, value
                )
            }
            NodeSettingValue::Int { value, .. } => {
                format!(
                    "Update Node '{}' setting {} to {}",
                    self.path, self.setting.id, value
                )
            }
            NodeSettingValue::Bool { value, .. } => {
                format!(
                    "Update Node '{}' setting {} to {}",
                    self.path, self.setting.id, value
                )
            }
            NodeSettingValue::Text { value, .. } => {
                format!(
                    "Update Node '{}' setting {} to {}",
                    self.path, self.setting.id, value
                )
            }
            NodeSettingValue::Enum { value, variants } => {
                format!(
                    "Update Node '{}' setting {} to {}",
                    self.path,
                    self.setting.id,
                    variants
                        .into_iter()
                        .find(|v| v.value == *value)
                        .map(|v| v.label.clone())
                        .unwrap_or_else(|| value.to_string())
                )
            }
            NodeSettingValue::Id { value, variants } => {
                format!(
                    "Update Node '{}' setting {} to {}",
                    self.path,
                    self.setting.id,
                    variants
                        .iter()
                        .find(|v| v.value == *value)
                        .map(|v| v.label.clone())
                        .unwrap_or_else(|| value.to_string())
                )
            }
            NodeSettingValue::Select { value, variants } => {
                format!(
                    "Update Node '{}' setting {} to {}",
                    self.path,
                    self.setting.id,
                    variants
                        .iter()
                        .find_map(|v| if let SelectVariant::Item { value: v, label } = v {
                            if v.as_str() == value {
                                Some(label.clone())
                            } else {
                                None
                            }
                        } else {
                            None
                        })
                        .unwrap_or_else(|| Arc::new(value.clone()))
                )
            }
            NodeSettingValue::Spline(_) => {
                format!("Update Node '{}' setting {}", self.path, self.setting.id)
            }
            NodeSettingValue::Media { value, .. } => {
                format!(
                    "Update Node '{}' setting {} to {}",
                    self.path, self.setting.id, value
                )
            }
            NodeSettingValue::Steps(_) => {
                format!("Update Node '{}' setting {}", self.path, self.setting.id)
            }
        }
    }

    fn apply(
        &self,
        pipeline_access: &mut PipelineAccess,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        tracing::debug!("Updating {:?} with {:?}", self.path, self.setting);

        let node = pipeline_access
            .nodes
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let previous_config: Node = NodeDowncast::downcast(node);
        let node: &mut dyn ProcessingNodeExt = node.deref_mut();
        node.as_pipeline_node_mut()
            .update_setting(self.setting.clone())?;

        let mut node = pipeline_access
            .nodes_view
            .get_mut(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {}", self.path))?;
        let node = node.value_mut();
        node.update_setting(self.setting.clone())?;

        Ok(((), previous_config))
    }

    fn revert(
        &self,
        pipeline_access: &mut PipelineAccess,
        state: Self::State,
    ) -> anyhow::Result<()> {
        pipeline_access.apply_node_config(&self.path, state)?;

        Ok(())
    }
}
