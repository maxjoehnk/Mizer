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
        group += control("Pad " + button_number)
            .id(button_id)
            .input()
            .note(9 + button_index)
            .channel(channel)
            .range(0, 127)
            .output()
            .range(0, 127); // This should be replaced by some calculation;
    }
    for button_index in range(0, 4) {
        let button_name = button_index + 5;
        let button_id = "button-" + (channel - 1) + "-" + (button_index + 4);
        group += control("Pad " + button_name)
            .id(button_id)
            .input()
            .channel(channel)
            .note(25 + button_index)
            .range(0, 127)
            .output()
            .range(0, 127); // This should be replaced by some calculation;
    }

    group
}

fn add_faders(channel) {
    let group = create_group("Knobs");
    for fader_index in range(0, 8) {
        let fader_name = fader_index + 1;
        group += control("Knob 1-" + fader_name).input().cc(21 + fader_index).channel(channel).range(0, 127);
    }

    for fader_index in range(0, 8) {
        let fader_name = fader_index + 1;
        group += control("Knob 2-" + fader_name).input().cc(41 + fader_index).channel(channel).range(0, 127);
    }

    group
}

fn add_move_buttons(page, channel) {
    let button_id = "button-" + (channel - 1) + "-";
    page += control("Down").id(button_id + "9").input().cc(115).channel(channel).range(0, 127).output();
    page += control("Up").id(button_id + "8").input().cc(114).channel(channel).range(0, 127).output();
    page += control("Left").id(button_id + "10").input().cc(116).channel(channel).range(0, 127).output();
    page += control("Right").id(button_id + "11").input().cc(117).channel(channel).range(0, 127).output();

    page
}

let pages = [];

for index in range(0, 16) {
    pages += [generate_page(pages, index)];
}

pages
