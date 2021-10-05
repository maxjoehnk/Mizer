import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/inputs/decoration.dart';
import 'package:mizer/widgets/tabs.dart';

import 'fader.dart';

enum ColorMode {
  Rgb,
  Hsb,
  Color,
}

class ColorValue {
  final double red;
  final double green;
  final double blue;

  ColorValue({required this.red, required this.green, required this.blue});

  ColorValue copyWith({double? red, double? green, double? blue}) {
    return ColorValue(
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
    );
  }
}

class ColorInput extends StatefulWidget {
  final String? label;
  final ColorValue value;
  final Function(ColorValue)? onChange;

  const ColorInput({this.label, required this.value, this.onChange, Key? key}) : super(key: key);

  @override
  State<ColorInput> createState() => _ColorInputState(value);
}

class _ColorInputState extends State<ColorInput> {
  ColorMode mode = ColorMode.Rgb;
  ColorValue value;

  _ColorInputState(this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ControlDecoration(),
        width: 200,
        child: Column(
          children: [
            Container(
              height: 32,
              color: Colors.grey.shade800,
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Row(children: [
                Expanded(
                  child: Text(widget.label ?? ""),
                ),
                TabHeader("RGB",
                    onSelect: () => setState(() => mode = ColorMode.Rgb),
                    selected: mode == ColorMode.Rgb),
                TabHeader("HSB",
                    onSelect: () => setState(() => mode = ColorMode.Hsb),
                    selected: mode == ColorMode.Hsb),
                TabHeader("Color",
                    onSelect: () => setState(() => mode = ColorMode.Color),
                    selected: mode == ColorMode.Color),
              ]),
            ),
            Expanded(
              child: Row(children: [
                if (mode == ColorMode.Rgb)
                  RGBInput(value, (color) {
                    setState(() => value = color);
                    if (widget.onChange != null) {
                      widget.onChange!(color);
                    }
                  }),
                if (mode == ColorMode.Hsb) HSBInput(),
                if (mode == ColorMode.Color) ColorPicker(),
              ]),
            ),
          ],
        ));
  }
}

class RGBInput extends StatelessWidget {
  final ColorValue value;
  final Function(ColorValue) onChange;

  const RGBInput(this.value, this.onChange, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ColorFader(
          value: value.red,
          onValue: (v) => onChange(value.copyWith(red: v)),
          label: "R",
          gradient: colorChannelGradient(Color.fromARGB(255, 255, 0, 0))),
      ColorFader(
          value: value.green,
          onValue: (v) => onChange(value.copyWith(green: v)),
          label: "G",
          gradient: colorChannelGradient(Color.fromARGB(255, 0, 255, 0))),
      ColorFader(
          value: value.blue,
          onValue: (v) => onChange(value.copyWith(blue: v)),
          label: "B",
          gradient: colorChannelGradient(Color.fromARGB(255, 0, 0, 255))),
    ]);
  }
}

Gradient colorChannelGradient(Color color) {
  return LinearGradient(
      colors: [Color.fromARGB(255, 0, 0, 0), color],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);
}

Gradient hueGradient() {
  return LinearGradient(colors: [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 255, 0, 0)
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

class HSBInput extends StatelessWidget {
  const HSBInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ColorFader(label: "H", gradient: hueGradient(), value: 0),
      ColorFader(label: "S", gradient: colorChannelGradient(Color.fromARGB(255, 255, 255, 255)), value: 0),
      ColorFader(label: "B", gradient: colorChannelGradient(Color.fromARGB(255, 255, 255, 255)), value: 0),
    ]);
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ColorFader extends StatelessWidget {
  final String? label;
  final Gradient? gradient;
  final double value;
  final Function(double)? onValue;

  const ColorFader({this.label, this.gradient, required this.value, this.onValue, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        width: 64,
        child: FaderInput(label: label, gradient: gradient, value: value, onValue: onValue));
  }
}
