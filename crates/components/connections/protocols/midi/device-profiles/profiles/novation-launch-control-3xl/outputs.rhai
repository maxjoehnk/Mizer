fn init() {
    let disable = blob();
    disable += 0x02;
    disable += 0x15;
    disable += 0x02;
    disable += 0x00;
    disable += 0xf7;

    let enable = blob();
    enable += 0x02;
    enable += 0x15;
    enable += 0x02;
    enable += 0x7f;
    enable += 0xf7;

    [
        sysex(0xf0, 0x00, 0x20, 0x29, disable),
        sysex(0xf0, 0x00, 0x20, 0x29, enable),
        cc(7, 0x47, 0x01)
        //cc(7, 0x1e, 0x01)
    ]
}

fn write_rgb(control, color) {
    let id = control.id.sub_string(-2);
    let index = parse_int(id);
    let red = color_to_byte(color.red);
    let green = color_to_byte(color.green);
    let blue = color_to_byte(color.blue);
    let data = blob();
    data += 0x02;
    data += 0x15;
    data += 0x01;
    data += 0x53;
    data += index;
    data += (red & 0x7f);
    data += (green & 0x7f);
    data += (blue & 0x7f);
    data += 0xf7;

    sysex(0xf0, 0x00, 0x20, 0x29, data)
}

fn color_to_byte(value) {
    (value * 127.0).to_int()
}
