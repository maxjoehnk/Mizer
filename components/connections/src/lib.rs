use derive_more::From;

#[derive(From, Debug, Clone)]
pub enum Connection {
    Midi(MidiView),
    Dmx(DmxView),
}

impl Connection {
    pub fn name(&self) -> String {
        match self {
            Connection::Midi(device) => device.name.clone(),
            Connection::Dmx(device) => device.name.clone(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct MidiView {
    pub name: String
}

#[derive(Debug, Clone)]
pub struct DmxView {
    pub name: String
}
