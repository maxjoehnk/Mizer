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

    pub async fn show_dialog_with_result(&self, mut dialog: Dialog) -> anyhow::Result<Option<String>> {
        let (sender, receiver) = flume::bounded(1);
        dialog.return_channel = Some(sender);
        self.api.emit(UiEvent::ShowDialog(dialog));
        
        let result = receiver.recv_async().await?;
        
        Ok(result)
    }
}

#[derive(Clone, Debug)]
pub struct Dialog {
    pub title: String,
    pub elements: Vec<DialogElement>,
    pub actions: Vec<DialogAction>,
    return_channel: Option<flume::Sender<Option<String>>>,
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
    actions: Vec<DialogAction>,
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
    
    pub fn action(mut self, title: String, action: String) -> Self {
        self.actions.push(DialogAction { label: title, action });
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
            actions: self.actions,
            return_channel: None,
        })
    }
}

#[derive(Clone, Debug)]
pub enum DialogElement {
    Text(String),
}

#[derive(Clone, Debug)]
pub struct DialogAction {
    pub label: String,
    pub action: String,
}