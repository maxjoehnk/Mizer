fn generate_page() {
    let page = create_page("Default");
    page = add_buttons(page);
    page += add_knobs();

    page
}

fn add_buttons(page) {
    let pads = create_group("Pads");
    for row_index in range(0, 4) {
        for column_index in range(0, 16) {
            let button_base = 54 + row_index * 16;
            let button_note = button_base + column_index;

            let button_id = "button-" + button_note;
            let button_name = "Pad " + (row_index + 1) + "-" + (column_index + 1);
            pads += note(button_name, button_note)
                .range(0, 127)
                .id(button_id);
        }
    }
    let mutes = create_group("Mutes");
    for button_index in range(0, 4) {
        mutes += generate_button("Mute ", button_index, 36);
    }
    let playback = create_group("Playback");
    playback += create_button("Step", 44);
    playback += create_button("Note", 45);
    playback += create_button("Drum", 46);
    playback += create_button("Perform", 47);
    playback += create_button("Shift", 48);
    playback += create_button("Alt", 49);
    playback += create_button("Pattern/Song", 50);
    playback += create_button("Play", 51);
    playback += create_button("Stop", 52);
    playback += create_button("Record", 53);

    page += pads;
    page += mutes;
    page += playback;

    page += create_button("Mode Selector", 26);
    page += create_button("Pattern Up", 31);
    page += create_button("Pattern Down", 32);
    page += create_button("Browser", 33);
    page += create_button("Grid Left", 34);
    page += create_button("Grid Right", 35);

    page
}

fn generate_button(prefix, button_index, base) {
    let button_note = button_index + base;
    let name = prefix + (button_index + 1);

    return create_button(name, button_note);
}

fn create_button(name, note) {
    let button_id = "button-" + note;
    let button = note(name, note)
        .range(0, 127)
        .id(button_id);

    return button;
}

fn add_knobs() {
    let group = create_group("Knobs");

    group += cc("Volume", 16).range(0, 127);
    group += note("Volume Touch", 16).range(0, 127);
    group += cc("Pan", 17).range(0, 127);
    group += note("Pan Touch", 17).range(0, 127);
    group += cc("Filter", 18).range(0, 127);
    group += note("Filter Touch", 18).range(0, 127);
    group += cc("Resonance", 19).range(0, 127);
    group += note("Resonance Touch", 19).range(0, 127);
    group += cc("Select", 118).range(0, 127);

    group
}

let pages = [
    generate_page()
];

pages
