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
                .range(0, 127)
                .output()
                .range(0, 60);
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
            .range(0, 127)
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
    let control = control(name).input().cc(note).range(0, 127);

    control
}

let pages = [
    generate_page()
];

pages
