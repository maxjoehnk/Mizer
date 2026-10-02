use crate::controls::GridButton;
use godot::classes::{Control, HFlowContainer, Label, PanelContainer};
use godot::meta::AsArg;
use godot::prelude::*;

#[derive(GodotClass)]
#[class(init, base=PanelContainer)]
pub struct MizerPanel {
    base: Base<PanelContainer>,
    #[init(node = "%Title")]
    title: OnReady<Gd<Label>>,
    #[init(node = "%Content")]
    content: OnReady<Gd<HFlowContainer>>,
}

impl MizerPanel {
    pub fn set_title(&mut self, title: impl AsArg<GString>) {
        self.title.set_text(title);
    }
}

#[derive(GodotClass)]
#[class(init, base=Control)]
pub struct MizerGridPanel {
    base: Base<Control>,
    #[init(node = "Panel")]
    pub panel: OnReady<Gd<MizerPanel>>,
}

impl MizerGridPanel {
    pub fn set_items(&mut self, children: impl Iterator<Item = Gd<Control>>, count: usize) {
        let mut panel = self.panel.bind_mut();
        for mut child in panel.content.get_children().iter_shared() {
            child.queue_free();
        }

        for child in children {
            panel.content.add_child(&child);
        }
        let fill_count = 200usize.saturating_sub(count);
        for _ in 0..fill_count {
            let mut button = GridButton::new();
            button.set_disabled(true);
            panel.content.add_child(&button);
        }
    }
}
