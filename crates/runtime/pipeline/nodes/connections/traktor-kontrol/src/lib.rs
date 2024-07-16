use std::sync::Arc;
pub use self::input::*;
pub use self::output::*;
use mizer_devices::{DeviceManager, DeviceRef};
use mizer_node::{Inject, SelectVariant};
use mizer_traktor_kontrol_x1::{Button, DeckButton, DeckEncoder, Encoder, FxButton, FxKnob, Knob};

mod input;
mod output;

trait X1InjectorExt {
    fn get_devices(&self) -> Vec<SelectVariant>;
}

impl<I: ?Sized + Inject> X1InjectorExt for I {
    fn get_devices(&self) -> Vec<SelectVariant> {
        let device_manager = self.inject::<DeviceManager>();

        device_manager
            .current_devices()
            .into_iter()
            .flat_map(|device| {
                if let DeviceRef::TraktorKontrolX1(x1) = device {
                    Some(SelectVariant::from(x1.id))
                } else {
                    None
                }
            })
            .collect()
    }
}

trait ConvertVariant: Sized {
    fn to_id_with_prefix(&self, prefix: &str) -> String;
    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self>;

    fn try_from_str(id: &str) -> anyhow::Result<Self> {
        let variant = id.split('-').collect::<Vec<_>>();
        Self::try_from_id(&variant)
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant>;
}

impl ConvertVariant for Button {
    fn to_id_with_prefix(&self, prefix: &str) -> String {
        match self {
            Button::DeckA(deck) => deck.to_id_with_prefix(&format!("{prefix}decka-")),
            Button::DeckB(deck) => deck.to_id_with_prefix(&format!("{prefix}deckb-")),
            Button::FX1(fx) => fx.to_id_with_prefix(&format!("{prefix}fx1-")),
            Button::FX2(fx) => fx.to_id_with_prefix(&format!("{prefix}fx2-")),
            Button::Hotcue => format!("{prefix}hotcue"),
            Button::Shift => format!("{prefix}shift"),
        }
    }

    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self> {
        match variant {
            ["decka", deck] => Ok(Button::DeckA(DeckButton::try_from_id(&[deck])?)),
            ["deckb", deck] => Ok(Button::DeckB(DeckButton::try_from_id(&[deck])?)),
            ["fx1", fx] => Ok(Button::FX1(FxButton::try_from_id(&[fx])?)),
            ["fx2", fx] => Ok(Button::FX2(FxButton::try_from_id(&[fx])?)),
            ["hotcue"] => Ok(Button::Hotcue),
            ["shift"] => Ok(Button::Shift),
            _ => anyhow::bail!("Invalid variant"),
        }
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant> {
        vec![
            SelectVariant::Group {
                label: arc("Deck A"),
                children: DeckButton::list_variants(&format!("{prefix}decka-")),
            },
            SelectVariant::Group {
                label: arc("Deck B"),
                children: DeckButton::list_variants(&format!("{prefix}deckb-")),
            },
            SelectVariant::Group {
                label: arc("FX 1"),
                children: FxButton::list_variants(&format!("{prefix}fx1-")),
            },
            SelectVariant::Group {
                label: arc("FX 2"),
                children: FxButton::list_variants(&format!("{prefix}fx2-")),
            },
            SelectVariant::Item {
                label: arc("Hotcue"),
                value: Button::Hotcue.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Shift"),
                value: Button::Shift.to_id_with_prefix(prefix).into(),
            },
        ]

    }
}

impl ConvertVariant for DeckButton {
    fn to_id_with_prefix(&self, prefix: &str) -> String {
        let suffix = match self {
            DeckButton::Browse => "browse",
            DeckButton::Loop => "loop",
            DeckButton::FX1 => "fx1",
            DeckButton::FX2 => "fx2",
            DeckButton::In => "in",
            DeckButton::Out => "out",
            DeckButton::BeatBackward => "beatbackward",
            DeckButton::BeatForward => "beatforward",
            DeckButton::Cue => "cue",
            DeckButton::Cup => "cup",
            DeckButton::Play => "play",
            DeckButton::Sync => "sync",
        };

        format!("{prefix}{suffix}")
    }

    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self> {
        match variant {
            ["browse"] => Ok(DeckButton::Browse),
            ["loop"] => Ok(DeckButton::Loop),
            ["fx1"] => Ok(DeckButton::FX1),
            ["fx2"] => Ok(DeckButton::FX2),
            ["in"] => Ok(DeckButton::In),
            ["out"] => Ok(DeckButton::Out),
            ["beatbackward"] => Ok(DeckButton::BeatBackward),
            ["beatforward"] => Ok(DeckButton::BeatForward),
            ["cue"] => Ok(DeckButton::Cue),
            ["cup"] => Ok(DeckButton::Cup),
            ["play"] => Ok(DeckButton::Play),
            ["sync"] => Ok(DeckButton::Sync),
            _ => anyhow::bail!("Invalid variant"),
        }
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant> {
        vec![
            SelectVariant::Item {
                label: arc("Browse"),
                value: DeckButton::Browse.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Loop"),
                value: DeckButton::Loop.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("FX1"),
                value: DeckButton::FX1.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("FX2"),
                value: DeckButton::FX2.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("In"),
                value: DeckButton::In.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Out"),
                value: DeckButton::Out.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Beat Backward"),
                value: DeckButton::BeatBackward.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Beat Forward"),
                value: DeckButton::BeatForward.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Cue"),
                value: DeckButton::Cue.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Cup"),
                value: DeckButton::Cup.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Play"),
                value: DeckButton::Play.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Sync"),
                value: DeckButton::Sync.to_id_with_prefix(prefix).into(),
            },
        ]
    }
}

impl ConvertVariant for FxButton {
    fn to_id_with_prefix(&self, prefix: &str) -> String {
        let suffix = match self {
            FxButton::On => "on",
            FxButton::Button1 => "button1",
            FxButton::Button2 => "button2",
            FxButton::Button3 => "button3",
        };

        format!("{prefix}{suffix}")
    }

    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self> {
        match variant {
            ["on"] => Ok(FxButton::On),
            ["button1"] => Ok(FxButton::Button1),
            ["button2"] => Ok(FxButton::Button2),
            ["button3"] => Ok(FxButton::Button3),
            _ => anyhow::bail!("Invalid variant"),
        }
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant> {
        vec![
            SelectVariant::Item {
                label: arc("On"),
                value: FxButton::On.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Button 1"),
                value: FxButton::Button1.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Button 2"),
                value: FxButton::Button2.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Button 3"),
                value: FxButton::Button3.to_id_with_prefix(prefix).into(),
            },
        ]
    }
}

impl ConvertVariant for Knob {
    fn to_id_with_prefix(&self, prefix: &str) -> String {
        match self {
            Knob::FX1(fx) => fx.to_id_with_prefix(&format!("{prefix}fx1-")),
            Knob::FX2(fx) => fx.to_id_with_prefix(&format!("{prefix}fx2-")),
        }
    }

    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self> {
        match variant {
            ["fx1", fx] => Ok(Knob::FX1(FxKnob::try_from_id(&[fx])?)),
            ["fx2", fx] => Ok(Knob::FX2(FxKnob::try_from_id(&[fx])?)),
            _ => anyhow::bail!("Invalid variant"),
        }
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant> {
        vec![
            SelectVariant::Group {
                label: arc("FX 1"),
                children: FxKnob::list_variants(&format!("{prefix}fx1-")),
            },
            SelectVariant::Group {
                label: arc("FX 2"),
                children: FxKnob::list_variants(&format!("{prefix}fx2-")),
            },
        ]
    }
}

impl ConvertVariant for FxKnob {
    fn to_id_with_prefix(&self, prefix: &str) -> String {
        let suffix = match self {
            FxKnob::DryWet => "drywet",
            FxKnob::Param1 => "param1",
            FxKnob::Param2 => "param2",
            FxKnob::Param3 => "param3",
        };

        format!("{prefix}{suffix}")
    }

    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self> {
        match variant {
            ["drywet"] => Ok(FxKnob::DryWet),
            ["param1"] => Ok(FxKnob::Param1),
            ["param2"] => Ok(FxKnob::Param2),
            ["param3"] => Ok(FxKnob::Param3),
            _ => anyhow::bail!("Invalid variant"),
        }
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant> {
        vec![
            SelectVariant::Item {
                label: arc("Dry/Wet"),
                value: FxKnob::DryWet.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Param 1"),
                value: FxKnob::Param1.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Param 2"),
                value: FxKnob::Param2.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Param 3"),
                value: FxKnob::Param3.to_id_with_prefix(prefix).into(),
            },
        ]
    }
}

impl ConvertVariant for Encoder {
    fn to_id_with_prefix(&self, prefix: &str) -> String {
        match self {
            Encoder::DeckA(deck) => deck.to_id_with_prefix(&format!("{prefix}decka-")),
            Encoder::DeckB(deck) => deck.to_id_with_prefix(&format!("{prefix}deckb-")),
        }
    }

    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self> {
        match variant {
            ["decka", deck] => Ok(Encoder::DeckA(DeckEncoder::try_from_id(&[deck])?)),
            ["deckb", deck] => Ok(Encoder::DeckB(DeckEncoder::try_from_id(&[deck])?)),
            _ => anyhow::bail!("Invalid variant"),
        }
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant> {
        vec![
            SelectVariant::Group {
                label: arc("Deck A"),
                children: DeckEncoder::list_variants(&format!("{prefix}decka-")),
            },
            SelectVariant::Group {
                label: arc("Deck B"),
                children: DeckEncoder::list_variants(&format!("{prefix}deckb-")),
            },
        ]
    }
}

impl ConvertVariant for DeckEncoder {
    fn to_id_with_prefix(&self, prefix: &str) -> String {
        let suffix = match self {
            DeckEncoder::Browse => "browse",
            DeckEncoder::Loop => "loop",
        };

        format!("{prefix}{suffix}")
    }

    fn try_from_id(variant: &[&str]) -> anyhow::Result<Self> {
        match variant {
            ["browse"] => Ok(DeckEncoder::Browse),
            ["loop"] => Ok(DeckEncoder::Loop),
            _ => anyhow::bail!("Invalid variant"),
        }
    }

    fn list_variants(prefix: &str) -> Vec<SelectVariant> {
        vec![
            SelectVariant::Item {
                label: arc("Browse"),
                value: DeckEncoder::Browse.to_id_with_prefix(prefix).into(),
            },
            SelectVariant::Item {
                label: arc("Loop"),
                value: DeckEncoder::Loop.to_id_with_prefix(prefix).into(),
            },
        ]
    }
}

fn arc(text: impl ToString) -> Arc<String> {
    Arc::new(text.to_string())
}
