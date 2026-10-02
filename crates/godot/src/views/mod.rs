use godot::meta::GodotConvert;

mod sequencer;

#[derive(Clone, Copy, Default, Debug, GodotConvert)]
#[godot(via = u8)]
pub enum ActiveView {
    #[default]
    Layout,
    Plan,
    Nodes,
    Sequencer,
    Fixtures,
    Presets,
    Effects,
    Media,
    Surfaces,
    Timecode,
    Patch,
    Connections,
    DmxOutput,
    History,
    Session,
    MidiProfiles,
    FixtureLibrary,
    Settings,
}
