fn generate_page(pages, index) {
    let name = if index < 8 {
        "User " + (index + 1)
    } else {
        "Factory " + (index - 7)
    };
    let page = create_page(name);

    fill_page(page, index + 1)
}

fn fill_page(page, channel) {
    page += add_buttons(channel);
    page += add_faders(channel);
    page = add_move_buttons(page, channel);

    page
}

fn add_buttons(channel) {
    let group = create_group("Pads");
    for button_index in range(0, 4) {
        let button_number = button_index + 1;
        let button_id = "button-" + (channel - 1) + "-" + button_index;
        group += note("Pad " + button_number, 9 + button_index)
            .channel(channel)
            .range(0, 127)
            .output()
            .output_range(0, 127) // This should be replaced by some calculation
            .id(button_id);
    }
    for button_index in range(0, 4) {
        let button_name = button_index + 5;
        let button_id = "button-" + (channel - 1) + "-" + (button_index + 4);
        group += note("Pad " + button_name, 25 + button_index)
            .channel(channel)
            .range(0, 127)
            .output()
            .output_range(0, 127) // This should be replaced by some calculation
            .id(button_id);
    }

    group
}

fn add_faders(channel) {
    let group = create_group("Knobs");
    for fader_index in range(0, 8) {
        let fader_name = fader_index + 1;
        group += cc("Knob 1-" + fader_name, 21 + fader_index).channel(channel).range(0, 127);
    }

    for fader_index in range(0, 8) {
        let fader_name = fader_index + 1;
        group += cc("Knob 2-" + fader_name, 41 + fader_index).channel(channel).range(0, 127);
    }

    group
}

fn add_move_buttons(page, channel) {
    let button_id = "button-" + (channel - 1) + "-";
    page += cc("Down", 115).channel(channel).range(0, 127).output().id(button_id + "9");
    page += cc("Up", 114).channel(channel).range(0, 127).output().id(button_id + "8");
    page += cc("Left", 116).channel(channel).range(0, 127).output().id(button_id + "10");
    page += cc("Right", 117).channel(channel).range(0, 127).output().id(button_id + "11");

    page
}

let pages = [];

for index in range(0, 16) {
    pages += [generate_page(pages, index)];
}

pages
