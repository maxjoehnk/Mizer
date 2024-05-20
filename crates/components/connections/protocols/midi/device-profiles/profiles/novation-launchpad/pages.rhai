fn generate_page() {
    let page = create_page("Default");
    page = add_buttons(page);

    page
}

fn add_buttons(page) {
    page += generate_pads();
    page += generate_play_buttons();
    page += generate_controls();

    page
}

fn generate_pads() {
    let pads = create_group("Pads");
    for row_index in range(0, 8) {
        for column_index in range(0, 8) {
            let button_base = row_index * 16;
            let button_note = button_base + column_index;

            let button_id = "button-" + button_note;
            let button_name = "Pad " + (row_index + 1) + "-" + (column_index + 1);
            pads += control(button_name)
                .id(button_id)
                .input()
                .note(button_note)
                .output()
                .range(0, 63)
                .step(12, "Off")
                .step(13, "Red - Low")
                .step(15, "Red - Full")
                .step(11, "Red - Flashing")
                .step(29, "Amber - Low")
                .step(63, "Amber - Full")
                .step(59, "Amber - Flashing")
                .step(62, "Yellow - Full")
                .step(58, "Yellow - Flashing")
                .step(28, "Green - Low")
                .step(60, "Green - Full")
                .step(56, "Green - Flashing");
        }
    }

    pads
}

fn generate_play_buttons() {
    let buttons = create_group("Play Buttons");
    for row_index in range(0, 8) {
        let button_base = row_index * 16;
        let button_note = button_base + 8;

        let button_id = "button-" + button_note;
        let button_name = "Button " + (row_index + 1);
        buttons += control(button_name)
            .id(button_id)
            .input()
            .note(button_note)
            .output()
            .range(0, 60);
    }

    buttons
}

fn generate_controls() {
    let buttons = create_group("Control Buttons");
    buttons += generate_control("Up", 104);
    buttons += generate_control("Down", 105);
    buttons += generate_control("Left", 106);
    buttons += generate_control("Right", 107);
    buttons += generate_control("Session", 108);
    buttons += generate_control("User 1", 109);
    buttons += generate_control("User 2", 110);
    buttons += generate_control("Mixer", 111);

    buttons
}

fn generate_control(name, note) {
    let control = control(name).input().cc(note);

    control
}

let pages = [
    generate_page()
];

pages
