fn generate_page(name, base) {
    let page = create_page(name);
    page += create_layer("A - Hot Cue", 11, base);
    page += create_layer("A - Loop", 12, base);
    page += create_layer("A - Autoloop", 13, base);
    page += create_layer("B - Hot Cue", 14, base);
    page += create_layer("B - Loop", 15, base);
    page += create_layer("B - Autoloop", 16, base);

    page
}

fn add_buttons(page) {
    page += generate_pads();

    page
}

fn create_layer(name, channel, button_base) {
    let pads = create_group(name);
    for index in range(0, 5) {
        let button_name = name + " - Pad " + (index + 1);
        let button_note = button_base + index;
        let button_id = "button-" + channel + "-" + button_note;
        pads += control(button_name)
            .id(button_id)
            .input()
            .channel(channel)
            .note(button_note)
            .output()
            .range(0, 112)
            .step(0, "Off")
            .steps("Red", intensity_steps("Red", 0))
            .steps("Red/Orange", intensity_steps("Red/Orange", 16))
            .steps("Orange", intensity_steps("Orange", 32))
            .steps("Orange/Amber", intensity_steps("Orange/Amber", 48))
            .steps("Amber", intensity_steps("Amber", 64))
            .steps("Yellow", intensity_steps("Yellow", 80))
            .steps("Yellow/Green", intensity_steps("Yellow/Green", 96))
            .steps("Green", intensity_steps("Green", 112));
    }

    pads
}

fn intensity_steps(prefix, start) {
    let steps = create_steps();
    for index in range(1, 16) {
        let step_name = prefix + " - " + index;
        let step_value = start + index;
        steps.step(step_value, step_name);
    }

    steps
}

let pages = [
    generate_page("Default", 60),
    generate_page("Shift", 65),
];

pages
