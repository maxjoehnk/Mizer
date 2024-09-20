import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/programmer.pb.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:provider/provider.dart';

class ColorIndicator extends StatelessWidget {
  final Iterable<ProgrammerChannel>? fixtureState;

  const ColorIndicator({super.key, this.fixtureState});

  @override
  Widget build(BuildContext context) {
    var color = this.getColor(context);
    if (color == null) {
      return Container();
    }
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Color? getColor(BuildContext context) {
    var redChannel = fixtureState?.firstWhereOrNull((element) => element.control == "ColorMixerRed");
    var greenChannel = fixtureState?.firstWhereOrNull((element) => element.control == "ColorMixerGreen");
    var blueChannel = fixtureState?.firstWhereOrNull((element) => element.control == "ColorMixerBlue");
    var presetChannel = fixtureState?.firstWhereOrNull((element) => element.control == "ColorMixerRed");
    if (presetChannel != null && presetChannel.hasPreset()) {
      PresetsBloc bloc = context.read();
      var preset = bloc.state.getPreset(presetChannel.preset);
      if (preset == null) {
        return null;
      }
      return _convertPresetColor(preset.color);
    }

    if (redChannel == null && greenChannel == null && blueChannel == null) {
      return null;
    }

    var red = ((redChannel?.direct.percent ?? 0) * 255).round();
    var green = ((greenChannel?.direct.percent ?? 0) * 255).round();
    var blue = ((blueChannel?.direct.percent ?? 0) * 255).round();

    return Color.fromARGB(255, red, green, blue);
  }

  Color _convertPresetColor(Preset_Color color) {
    int red = (color.red * 255).round();
    int green = (color.green * 255).round();
    int blue = (color.blue * 255).round();

    return Color.fromARGB(255, red, green, blue);
  }
}
