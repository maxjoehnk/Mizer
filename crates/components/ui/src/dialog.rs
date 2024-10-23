use crate::{UiApi, UiEvent};

pub struct DialogService {
    api: UiApi,
}

impl DialogService {
    pub(crate) fn new(api: UiApi) -> Self {
        Self { api }
    }

    pub fn show_dialog(&self, dialog: Dialog) -> anyhow::Result<()> {
        self.api.emit(UiEvent::ShowDialog(dialog));

        Ok(())
    }
}

#[derive(Clone, Debug)]
pub struct Dialog {
    pub title: String,
    pub elements: Vec<DialogElement>,
}

impl Dialog {
    pub fn builder() -> DialogBuilder {
        DialogBuilder::new()
    }
}

#[derive(Default)]
pub struct DialogBuilder {
    title: Option<String>,
    elements: Vec<DialogElement>,
}

impl DialogBuilder {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn title(mut self, title: String) -> Self {
        self.title = Some(title);
        self
    }

    pub fn text(mut self, text: String) -> Self {
        self.elements.push(DialogElement::Text(text));
        self
    }

    pub fn build(self) -> anyhow::Result<Dialog> {
        anyhow::ensure!(
            !self.elements.is_empty(),
            "at least one element is required"
        );
        Ok(Dialog {
            title: self
                .title
                .ok_or_else(|| anyhow::anyhow!("title is required"))?,
            elements: self.elements,
        })
    }
}

#[derive(Clone, Debug)]
pub enum DialogElement {
    Text(String),
}