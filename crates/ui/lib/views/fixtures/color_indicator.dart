import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/fixtures.pb.dart';
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
    var programmerChannel =
        fixtureState?.firstWhereOrNull((element) => element.control == FixtureControl.COLOR_MIXER);
    if (programmerChannel == null) {
      return null;
    }
    if (programmerChannel.hasPreset()) {
      PresetsBloc bloc = context.read();
      var preset = bloc.state.getPreset(programmerChannel.preset);
      if (preset == null) {
        return null;
      }
      return _convertPresetColor(preset.color);
    }

    return _convertColor(programmerChannel.color);
  }

  Color _convertColor(ColorMixerChannel color) {
    int red = (color.red * 255).round();
    int green = (color.green * 255).round();
    int blue = (color.blue * 255).round();

    return Color.fromARGB(255, red, green, blue);
  }

  Color _convertPresetColor(Preset_Color color) {
    int red = (color.red * 255).round();
    int green = (color.green * 255).round();
    int blue = (color.blue * 255).round();

    return Color.fromARGB(255, red, green, blue);
  }
}
