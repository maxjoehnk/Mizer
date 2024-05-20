fn generate_page() {
    let page = create_page("Default");
    page = add_buttons(page);
    page += control("Shift").id("button-98").input().note(98);
    page += add_faders();

    page
}

fn add_buttons(page) {
    let pads = create_group("Pads");
    for row_index in range(0, 8) {
        for column_index in range(0, 8) {
            let button_base = (row_index - 7).abs() * 8;
            let button_note = button_base + column_index;

            let button_id = "button-" + button_note;
            let button_name = "Pad " + (row_index + 1) + "-" + (column_index + 1);
            pads += control(button_name)
                .id(button_id)
                .input()
                .note(button_note)
                .output()
                .range(0, 6)
                .step(0, "Off")
                .step(1, "Green")
                .step(2, "Green Blinking")
                .step(3, "Red")
                .step(4, "Red Blinking")
                .step(5, "Orange")
                .step(6, "Orange Blinking");
        }
    }
    let scene_launch = create_group("Scene Launch");
    for button_index in range(0, 8) {
        scene_launch += generate_button("Scene Launch ", button_index, 82);
    }
    let mutes = create_group("Mutes");
    for button_index in range(0, 8) {
        mutes += generate_button("Mutes ", button_index, 64);
    }

    page += pads;
    page += scene_launch;
    page += mutes;

    page
}

fn generate_button(prefix, button_index, base) {
    let button_note = button_index + base;
    let button_id = "button-" + button_note;

    let button = control(prefix + (button_index + 1))
        .id(button_id)
        .input()
        .note(button_note)
        .output()
        .range(0, 2)
        .step(0, "Off")
        .step(1, "On")
        .step(2, "Blinking");

    return button;
}

fn add_faders() {
    let group = create_group("Faders");
    for fader_index in range(0, 9) {
        group += control("Fader " + (fader_index + 1)).input().cc(48 + fader_index);
    }

    group
}

let pages = [
    generate_page()
];

pages
