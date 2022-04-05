import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/inputs/color.dart';
import 'package:mizer/widgets/inputs/decoration.dart';
import 'package:mizer/widgets/inputs/fader.dart';
import 'package:provider/provider.dart';

class Control {
  final String? label;
  final WriteControlRequest Function(dynamic) update;
  final FaderChannel? fader;
  final ColorChannel? color;
  final AxisChannel? axis;
  final GenericChannel? generic;
  final ProgrammerChannel? channel;
  final List<ControlPreset>? presets;

  Control(this.label,
      {required this.update,
      this.fader,
      this.generic,
      this.color,
      this.axis,
      this.presets,
      required this.channel});

  bool get hasFader {
    return fader != null;
  }

  bool get hasGeneric {
    return generic != null;
  }

  bool get hasColor {
    return color != null;
  }

  bool get hasAxis {
    return axis != null;
  }

  bool get hasPresets {
    return presets != null;
  }
}

class ControlPreset {
  final double value;
  final String name;
  final ControlPresetImage? image;

  ControlPreset(this.value, {required this.name, this.image});

  @override
  String toString() {
    return "ControlPreset(value: $value, name: $name, image: $image)";
  }
}

class ControlPresetImage {
  final String? svg;
  final Uint8List? raster;

  ControlPresetImage({ this.svg, this.raster });
}

class FixtureGroupControl extends StatelessWidget {
  final Control control;
  final ProgrammerChannel? channel;
  final String? label;

  const FixtureGroupControl(this.control, {this.channel, this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProgrammerApi api = context.read();
    Widget widget = Container();
    if (control.hasFader || control.hasGeneric) {
      widget = Container(
          width: 64,
          child: FaderInput(
              // highlight: modifiedChannels.contains(group.name),
              label: control.label,
              value: control.channel?.fader ?? 0,
              // value: control.fader?.value ?? control.generic!.value,
              onValue: (v) => api.writeControl(control.update(v))));
    }
    if (control.hasColor) {
      widget = ColorInput(
        label: control.label,
        value: ColorValue(
            red: control.channel?.color.red ?? 0,
            green: control.channel?.color.green ?? 0,
            blue: control.channel?.color.blue ?? 0),
        // value: ColorValue(red: control.color!.red, green: control.color!.green, blue: control.color!.blue),
        onChange: (v) => api.writeControl(control.update(v)),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget,
          if (control.hasPresets)
            FixtureControlPresets(control.presets!,
                onSelect: (v) => api.writeControl(control.update(v)))
        ],
      ),
    );
  }
}

class FixtureControlPresets extends StatelessWidget {
  final List<ControlPreset> presets;
  final Function(double) onSelect;

  const FixtureControlPresets(this.presets, {required this.onSelect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 4,
        shrinkWrap: true,
        childAspectRatio: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: presets
            .map((p) => Hoverable(
                  onTap: () => onSelect(p.value),
                  builder: (hovered) => Container(
                    decoration: ControlDecoration(color: hovered ? Colors.grey.shade900 : Colors.grey.shade700),
                    padding: const EdgeInsets.all(8),
                    child: p.image != null ? _image(p.image!) : Center(child: Text(p.name, textAlign: TextAlign.center)),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _image(ControlPresetImage image) {
    if (image.raster != null) {
      return Image.memory(image.raster!);
    }else {
      return SvgPicture.string(image.svg!);
    }
  }
}
