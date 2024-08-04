use futures::{Stream, StreamExt};
use itertools::Itertools;
use mizer_command_executor::{GetFixtureDefinitionQuery, ListFixtureDefinitionsQuery};
use mizer_fixtures::ui_handlers::*;
use mizer_ui_api::dialog;
use mizer_ui_api::table::TableHandler;
use mizer_ui_api::UiApi;
use crate::proto::ui::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct UiHandler<R> {
    ui_receiver: UiApi,
    runtime: R,
}

impl<R> UiHandler<R> {
    pub fn new(runtime: R, ui_api: UiApi) -> Self {
        Self { ui_receiver: ui_api, runtime }
    }

    pub fn observe_dialogs(&self) -> impl Stream<Item=ShowDialog> {
        self.ui_receiver.subscribe_dialog().map(ShowDialog::from)
    }
}

impl<R: RuntimeApi> UiHandler<R> {
    pub fn show_table(&self, name: &str, arguments: &[&String]) -> anyhow::Result<TabularData> {
        match name {
            "fixtures/definitions/list" => {
                let fixture_definitions = self.runtime.query(ListFixtureDefinitionsQuery::default())?;
                let table = FixtureDefinitionTable.get_table(fixture_definitions)?;

                Ok(table.into())
            }
            "fixtures/definitions/list/gdtf" => {
                let fixture_definitions = self.runtime.query(ListFixtureDefinitionsQuery {
                    gdtf: true,
                    ofl: false,
                    qlc: false,
                    mizer: false,
                })?;
                let table = FixtureDefinitionTable.get_table(fixture_definitions)?;

                Ok(table.into())
            }
            "fixtures/definitions/list/ofl" => {
                let fixture_definitions = self.runtime.query(ListFixtureDefinitionsQuery {
                    gdtf: false,
                    ofl: true,
                    qlc: false,
                    mizer: false,
                })?;
                let table = FixtureDefinitionTable.get_table(fixture_definitions)?;

                Ok(table.into())
            }
            "fixtures/definitions/list/qlc" => {
                let fixture_definitions = self.runtime.query(ListFixtureDefinitionsQuery {
                    gdtf: false,
                    ofl: false,
                    qlc: true,
                    mizer: false,
                })?;
                let table = FixtureDefinitionTable.get_table(fixture_definitions)?;

                Ok(table.into())
            }
            "fixtures/definitions/list/mizer" => {
                let fixture_definitions = self.runtime.query(ListFixtureDefinitionsQuery {
                    gdtf: false,
                    ofl: false,
                    qlc: false,
                    mizer: true,
                })?;
                let table = FixtureDefinitionTable.get_table(fixture_definitions)?;

                Ok(table.into())
            }
            "fixtures/definitions/modes" => {
                let fixture_definition = self.runtime.query(GetFixtureDefinitionQuery {
                    definition_id: arguments[0].clone(),
                })?;
                if let Some(fixture_definition) = fixture_definition {
                    let table = FixtureDefinitionModesTable.get_table(fixture_definition)?;

                    Ok(table.into())
                } else {
                    anyhow::bail!("Unknown fixture definition {}", &arguments[0]);
                }
            }
            "fixtures/definitions/channels" => {
                let fixture_definition = self.runtime.query(GetFixtureDefinitionQuery {
                    definition_id: arguments[0].clone(),
                })?;
                if let Some(fixture_definition) = fixture_definition {
                    if let Some(fixture_mode) = fixture_definition.modes.into_iter().find(|m| &m.name == arguments[1]) {
                        let table = FixtureDefinitionDmxChannelTable.get_table(fixture_mode)?;

                        Ok(table.into())
                    } else {
                        anyhow::bail!("Unknown fixture mode {}", &arguments[1]);
                    }
                } else {
                    anyhow::bail!("Unknown fixture definition {}", &arguments[0]);
                }
            }
            "fixtures/definitions/tree" => {
                let fixture_definition = self.runtime.query(GetFixtureDefinitionQuery {
                    definition_id: arguments[0].clone(),
                })?;
                if let Some(mut fixture_definition) = fixture_definition {
                    if let Some(index) = fixture_definition.modes.iter().position(|m| &m.name == arguments[1]) {
                        let fixture_mode = fixture_definition.modes.remove(index);
                        let table = FixtureDefinitionTreeTable.get_table(fixture_mode)?;

                        Ok(table.into())
                    } else {
                        anyhow::bail!("Unknown fixture mode {}, available modes: {}", &arguments[1], fixture_definition.modes.iter().map(|m| &m.name).join(", "));
                    }
                } else {
                    anyhow::bail!("Unknown fixture definition {}", &arguments[0]);
                }
            }
            name => anyhow::bail!("Unknown table: {name}")
        }
    }
}

impl From<dialog::Dialog> for ShowDialog {
    fn from(value: dialog::Dialog) -> Self {
        ShowDialog {
            title: value.title,
            elements: value.elements.into_iter().map(DialogElement::from).collect(),
        }
    }
}

impl From<dialog::DialogElement> for DialogElement {
    fn from(value: dialog::DialogElement) -> Self {
        match value {
            dialog::DialogElement::Text(text) => DialogElement {
                element: Some(dialog_element::Element::Text(text)),
            },
        }
    }
}
