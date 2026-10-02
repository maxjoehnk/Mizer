use godot::classes::{Control, IControl, Timer};
use godot::prelude::*;
use crate::MizerInterface;
use crate::controls::{GridButton, MizerGridPanel};

#[derive(GodotClass)]
#[class(init, base=Control)]
pub struct SequencesPanel {
    base: Base<Control>,
    #[init(node = "GridPanel")]
    grid_panel: OnReady<Gd<MizerGridPanel>>,
}

impl SequencesPanel {
    fn rerender(&mut self) {
        let interface = MizerInterface::singleton();
        let interface = interface.bind();
        let sequences = interface.handlers.sequencer.get_sequences();

        let count = sequences.sequences.len();
        let items = sequences.sequences.into_iter()
            .map(|sequence| {
                let mut button = GridButton::new();
                button.bind_mut().label = sequence.name.to_godot();

                button.upcast::<Control>()
            });

        self.grid_panel.bind_mut().set_items(items, count);
    }
}

#[godot_api]
impl IControl for SequencesPanel {
    fn ready(&mut self) {
        self.grid_panel.bind_mut().panel.bind_mut().set_title("Sequences");
        let mut timer = Timer::new_alloc();
        self.base_mut().add_child(&timer);
        timer.signals().timeout().connect_other(self, Self::rerender);
        timer.start();
    }
}
