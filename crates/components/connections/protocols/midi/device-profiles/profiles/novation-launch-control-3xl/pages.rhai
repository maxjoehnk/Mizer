fn fader(id) {
    control("Fader " + id)
        .id("fader-" + id)
        .input()
        .channel(16)
        .cc(4 + id)
        .resolution_14_bit()
}

fn faders() {
    let group = create_group("Faders");
    for fader_index in range(1, 9) {
        group.add(fader(fader_index));
    }

    group
}

fn knob(base, id) {
    control("Knob " + id)
        .id("knob-" + (4 + base + id))
        .input()
        .cc(4 + base + id)
        .channel(16)
        .resolution_14_bit()
}

fn knobs(row_index) {
    let group = create_group("Knobs Row " + row_index);
    for idx in range(1, 9) {
        group.add(knob(row_index * 8, idx));
    }

    group
}

fn button(name, note) {
    control(name)
        .id("button-" + note)
        .input()
        .note(note)
        .channel(16)
        .output()
}

fn channel_button(base, id) {
    button("Button " + id, (base + id))
}

fn buttons(base, row_index) {
    let group = create_group("Buttons Row " + row_index);
    for idx in range(1, 8) {
        group.add(channel_button(base, idx));
    }

    group
}

fn playback_toolbar() {
    let group = create_group("Playback");
    group += button("Page Up", 106);
    group += button("Page Down", 107);
    group += button("Track Left", 103);
    group += button("Track Right", 102);
    group += button("Record", 118);
    group += button("Play", 116);
    group += button("Shift", 63);
    group += button("Solo / Arm", 65);
    group += button("Mute / Select", 66);
    group += button("Novation", 104);

    group
}

fn generate_page() {
    let pages = [];
    let page = create_page("Default");
    pages += page;
    page += faders();
    page += knobs(1);
    page += knobs(2);
    page += knobs(3);
    page += buttons(59, 1);
    page += buttons(71, 2);
    // page += playback_toolbar();
    // page += buttons(59, 1);
    // page += buttons(71, 2);

    page
}

let pages = [];

pages += generate_page();

pages
