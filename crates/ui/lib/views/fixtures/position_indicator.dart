import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pbenum.dart';
import 'package:mizer/protos/programmer.pb.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/presets/preset_button.dart';
import 'package:provider/provider.dart';

class PositionIndicator extends StatelessWidget {
  final Iterable<ProgrammerChannel>? fixtureState;

  const PositionIndicator({super.key, this.fixtureState});

  @override
  Widget build(BuildContext context) {
    Preset_Position? preset = getPreset(context);
    var pan = this.getPan(preset);
    var tilt = this.getTilt(preset);
    if (pan == null && tilt == null) {
      return Container();
    }
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.all(4),
        width: 32,
        height: 32,
        child: CustomPaint(painter: PositionPainter(pan: pan, tilt: tilt)));
  }

  Preset_Position? getPreset(BuildContext context) {
    var programmerChannel =
        fixtureState?.firstWhereOrNull((element) => element.control == "Pan");
    if (programmerChannel == null) {
      return null;
    }
    if (programmerChannel.hasPreset()) {
      PresetsBloc bloc = context.read();
      var preset = bloc.state.getPreset(programmerChannel.preset);
      if (preset == null) {
        return null;
      }
      return preset.position;
    }

    return null;
  }

  double? getPan(Preset_Position? preset) {
    if (preset?.hasPan() == true) {
      return preset!.pan;
    }
    return getValue("Pan");
  }

  double? getTilt(Preset_Position? preset) {
    if (preset?.hasTilt() == true) {
      return preset!.tilt;
    }
    return getValue("Tilt");
  }

  double? getValue(String control) {
    var programmerChannel = fixtureState?.firstWhereOrNull((element) => element.control == control);
    if (programmerChannel == null) {
      return null;
    }
    return programmerChannel.direct.percent;
  }
}
