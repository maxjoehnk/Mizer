fn generate_page() {
    let page = create_page("Default");
    page = add_buttons(page);
    page += add_knobs();

    page
}

fn add_buttons(page) {
    let pads = create_group("Pads");
    let pad_index = 0;
    for row_index in range(0, 4) {
        for column_index in range(0, 16) {
            let button_base = 54 + row_index * 16;
            let button_note = button_base + column_index;

            let button_id = "pad-" + pad_index;
            let button_name = "Pad " + (row_index + 1) + "-" + (column_index + 1);
            pads += control(button_name)
                .id(button_id)
                .input()
                .note(button_note)
                .range(0, 127)
                .output()
                .rgb("write_rgb");
            pad_index += 1;
        }
    }
    let mutes = create_group("Mutes");
    for button_index in range(0, 4) {
        mutes += generate_button("Mute ", button_index, 36)
                .output()
                .cc(36 + button_index)
                .range(0, 3);
    }
    let playback = create_group("Playback");
    playback += create_button("Step", 44).output().cc(44).range(0, 5);
    playback += create_button("Note", 45).output().cc(45).range(0, 5);
    playback += create_button("Drum", 46).output().cc(46).range(0, 5);
    playback += create_button("Perform", 47).output().cc(47).range(0, 5);
    playback += create_button("Shift", 48).output().cc(48).range(0, 5);
    playback += create_button("Alt", 49).output().cc(49).range(0, 3);
    playback += create_button("Pattern/Song", 50).output().cc(50).range(0, 5);
    playback += create_button("Play", 51).output().cc(51).range(0, 5);
    playback += create_button("Stop", 52).output().cc(52).range(0, 3);
    playback += create_button("Record", 53).output().cc(53).range(0, 5);

    let leds = create_group("LEDs");
    leds += control("LED 1").id("led-1").output().cc(40).range(0, 5);
    leds += control("LED 2").id("led-2").output().cc(41).range(0, 5);
    leds += control("LED 3").id("led-3").output().cc(42).range(0, 5);
    leds += control("LED 4").id("led-4").output().cc(43).range(0, 5);

    page += pads;
    page += mutes;
    page += playback;
    page += leds;

    page += create_button("Mode Selector", 26);
    page += create_button("Pattern Up", 31).output().cc(31).range(0, 3);
    page += create_button("Pattern Down", 32).output().cc(32).range(0, 3);
    page += create_button("Browser", 33).output().cc(33).range(0, 3);
    page += create_button("Grid Left", 34).output().cc(34).range(0, 3);
    page += create_button("Grid Right", 35).output().cc(35).range(0, 3);

    page
}

fn generate_button(prefix, button_index, base) {
    let button_note = button_index + base;
    let name = prefix + (button_index + 1);

    return create_button(name, button_note);
}

fn create_button(name, note) {
    let button_id = "button-" + note;
    let button = control(name)
        .id(button_id)
        .input()
        .note(note)
        .range(0, 127);

    return button;
}

fn add_knobs() {
    let group = create_group("Knobs");

    group += control("Volume").input().cc(16).range(0, 127);
    group += control("Volume Touch").input().note(16).range(0, 127);
    group += control("Pan").input().cc(17).range(0, 127);
    group += control("Pan Touch").input().note(17).range(0, 127);
    group += control("Filter").input().cc(18).range(0, 127);
    group += control("Filter Touch").input().note(18).range(0, 127);
    group += control("Resonance").input().cc(19).range(0, 127);
    group += control("Resonance Touch").input().note(19).range(0, 127);
    group += control("Select").input().cc(118).range(0, 127);

    group
}

let pages = [
    generate_page()
];

pages
