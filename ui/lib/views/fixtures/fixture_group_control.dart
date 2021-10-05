import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/inputs/color.dart';
import 'package:mizer/widgets/inputs/fader.dart';
import 'package:provider/provider.dart';

class Control {
  final String? label;
  final WriteControlRequest Function(dynamic) update;
  final FaderChannel? fader;
  final ColorChannel? color;
  final AxisChannel? axis;
  final GenericChannel? generic;

  Control(this.label, { required this.update, this.fader, this.generic, this.color, this.axis });

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
}

class FixtureGroupControl extends StatelessWidget {
  final Control control;
  final String? label;
  final List<Fixture> fixtures;

  const FixtureGroupControl(this.control, {this.label, required this.fixtures, Key? key}) : super(key: key);

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
              value: control.fader?.value ?? control.generic!.value,
              onValue: (v) => api.writeControl(control.update(v))));
    }
    if (control.hasColor) {
      widget = ColorInput(
        label: control.label,
        value: ColorValue(red: control.color!.red, green: control.color!.green, blue: control.color!.blue),
        onChange: (v) => api.writeControl(control.update(v)),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget,
    );
  }
}
