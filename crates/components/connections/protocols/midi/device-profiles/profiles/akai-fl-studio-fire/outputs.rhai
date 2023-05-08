const AKAI_MANUFACTURER_ID = 0x47;
const ALL_CALL_ADDRESS = 0x7F;
const FIRE_SUB_ID = 0x43;
const WRITE_PAD_COMMAND = 0x65;

fn write_rgb(control, color) {
    let id = control.id.sub_string(4);
    let index = parse_int(id);
    let red = color_to_byte(color.red);
    let green = color_to_byte(color.green);
    let blue = color_to_byte(color.blue);
    let data = blob();
    data += 0;
    data += 4;
    data += index;
    data += (red & 0x7f);
    data += (green & 0x7f);
    data += (blue & 0x7f);

    sysex(0x47, 0x7f, 0x43, 0x65, data)
}

fn color_to_byte(value) {
    (value * 127.0).to_int()
}