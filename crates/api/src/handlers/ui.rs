use futures::{Stream, StreamExt};
use mizer_ui_api::dialog;
use mizer_ui_api::UiApi;
use crate::proto::ui::*;

#[derive(Clone)]
pub struct UiHandler {
    ui_receiver: UiApi,
}

impl UiHandler {
    pub fn new(ui_api: UiApi) -> Self {
        Self { ui_receiver: ui_api }
    }

    pub fn observe_dialogs(&self) -> impl Stream<Item = ShowDialog> {
        self.ui_receiver.subscribe_dialog().map(ShowDialog::from)
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
