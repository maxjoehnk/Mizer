fn generate_page() {
    let page = create_page("Default");
    page = add_buttons(page);
    page += add_faders();
    page += add_knobs();

    page
}

fn add_buttons(page) {
    page += generate_pads();
    page += generate_controls();
    page += generate_keys();

    page
}

fn generate_pads() {
    let pads = create_group("Pads");
    for row_index in range(0, 4) {
        for column_index in range(0, 4) {
            let button_base = row_index * 4 + column_index;
            let button_note = 36 + button_base;

            let button_id = "button-" + button_base;
            let button_name = "Pad " + (row_index + 1) + "-" + (column_index + 1);
            pads += control(button_name)
                .id(button_id)
                .input()
                .note(button_note)
                .channel(10)
                .range(0, 127)
                .output();
        }
    }

    pads
}

fn generate_keys() {
    let pads = create_group("Keys");
    for index in range(0, 61) {
        let button_note = 36 + index;

        let button_id = "key-" + button_note;
        let button_name = "Key " + (index + 1);
        pads += control(button_name)
            .id(button_id)
            .input()
            .note(button_note)
            .range(0, 127);
    }

    pads
}

fn generate_controls() {
    let buttons = create_group("Control Buttons");
    buttons += generate_control("Prev", 112);
    buttons += generate_control("Next", 113);
    buttons += generate_control("Stop", 114);
    buttons += generate_control("Play", 115);
    buttons += generate_control("Loop", 116);
    buttons += generate_control("Record", 117);

    buttons
}

fn generate_control(name, note) {
    let control = control(name).input().cc(note).range(0, 127);

    control
}

fn add_faders() {
    let group = create_group("Faders");
    for fader_index in range(0, 8) {
        group += control("Fader " + (fader_index + 1)).input().cc(41 + fader_index).range(0, 127);
    }

    group += control("Master").input().cc(7).range(0, 127);

    group
}

fn add_knobs() {
    let group = create_group("Knobs");
    for fader_index in range(0, 8) {
        group += control("Knob " + (fader_index + 1)).input().cc(21 + fader_index).range(0, 127);
    }

    group
}

let pages = [
    generate_page()
];

pages
