fn fader(channel, id) {
    control("Fader " + id)
        .id("fader-" + id)
        .input()
        .channel(16)
        .cc(4 + id)
        .resolution_14_bit()
}

fn faders(channel) {
    let group = create_group("Faders");
    for fader_index in range(1, 9) {
        group.add(fader(channel, fader_index));
    }

    group
}

fn knob(channel, base, id) {
    control("Knob " + id)
        .id("knob-" + (4 + base + id))
        .input()
        .cc(4 + base + id)
        .channel(channel)
}

fn knobs(channel, row_index) {
    let group = create_group("Knobs Row " + row_index);
    for idx in range(1, 9) {
        group.add(knob(channel, row_index * 8, idx));
    }

    group
}

fn button(channel, name, note) {
    control(name)
        .id("button-" + note)
        .input()
        .note(note)
        .channel(channel)
        .output()
}

fn channel_button(channel, base, id) {
    button(channel, "Button " + id, (base + id))
}

fn buttons(channel, base, row_index) {
    let group = create_group("Buttons Row " + row_index);
    for idx in range(1, 9) {
        group.add(channel_button(channel, base, idx));
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
    page += faders(16);
    page += knobs(16, 1);
    page += knobs(16, 2);
    page += knobs(16, 3);
    page += buttons(16, 59, 1);
    page += buttons(16, 71, 2);
    // page += playback_toolbar();
    // page += buttons(59, 1);
    // page += buttons(71, 2);

    page
}

fn generate_channel_groove() {
    let pages = [];
    let page = create_page("Channel 1");
    pages += page;
    page += knobs(8, 1);
    page += knobs(8, 2);
    page += knobs(8, 3);
    page += buttons(8, 59, 1);
    page += buttons(8, 71, 2);
    // page += playback_toolbar();
    // page += buttons(59, 1);
    // page += buttons(71, 2);

    page.grid(8, 2, |x, y| {
        if x == 0 {
          let button_note = 60 + y;
          return "button-" + button_note;
        }else {
          let button_note = 72 + y;
          return "button-" + button_note;
        }
    });

    page
}

let pages = [];

pages += generate_page();
pages += generate_channel_groove();

pages
