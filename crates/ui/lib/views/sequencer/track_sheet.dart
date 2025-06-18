import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/popup/popup_direct_time_input.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

final LABELS = {
  CueControl_Type.INTENSITY: 'Dimmer',
  CueControl_Type.SHUTTER: 'Shutter',
  CueControl_Type.COLOR_RED: 'Red',
  CueControl_Type.COLOR_GREEN: 'Green',
  CueControl_Type.COLOR_BLUE: 'Blue',
  CueControl_Type.COLOR_WHEEL: 'Color',
  CueControl_Type.PAN: 'Pan',
  CueControl_Type.TILT: 'Tilt',
  CueControl_Type.FOCUS: 'Focus',
  CueControl_Type.ZOOM: 'Zoom',
  CueControl_Type.PRISM: 'Prism',
  CueControl_Type.IRIS: 'Iris',
  CueControl_Type.FROST: 'Frost',
  CueControl_Type.GOBO: 'Gobo',
  CueControl_Type.GENERIC: 'Generic',
};

class TrackSheet extends StatelessWidget {
  final Sequence sequence;
  final int? activeCue;

  const TrackSheet({required this.sequence, this.activeCue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var columnWidths = {
      0: FixedColumnWidth(75),
    };
    for (var i = 1; i <= _controls.length; i++) {
      columnWidths[i] = FixedColumnWidth(100);
    }
    for (var i = 1; i <= _effectIds.length; i++) {
      columnWidths[_controls.length + i] = FixedColumnWidth(100);
    }
    return MizerTable(
        columnWidths: columnWidths,
        columns: [
          Text("Cue"),
          ..._controls.map((c) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text(c.fixtureId.toDisplay()), Text(LABELS[c.control]!)])),
          ..._effectIds.map((c) => Column(
              mainAxisSize: MainAxisSize.min, children: [Text(c.toString()), Text("Offsets")])),
        ],
        rows: _buildRows(context));
  }

  Iterable<FixtureControl> get _controls {
    var controls =
        sequence.cues.expand((e) => e.controls).map((control) => control.type).toSet();

    return sequence.fixtures
        .expand((f) => controls.map((c) => FixtureControl(f, c)))
        .sorted((lhs, rhs) {
      var fixtureId = lhs.fixtureId.compareTo(rhs.fixtureId);
      if (fixtureId != 0) {
        return fixtureId;
      }
      return lhs.control.value - rhs.control.value;
    });
  }

  Iterable<int> get _effectIds {
    var effectIds = sequence.cues.expand((e) => e.effects).map((e) => e.effectId).toSet();
    effectIds.sorted((lhs, rhs) => lhs - rhs);

    return effectIds;
  }

  List<MizerTableRow> _buildRows(BuildContext context) {
    return sequence.cues.map((cue) {
      return MizerTableRow(cells: [
        Text(cue.id.toString()),
        ..._controls.map((c) => Center(
            child: Text(cue.controls
                    .firstWhereOrNull((element) =>
                        element.type == c.control &&
                        element.fixtures.firstWhereOrNull((f) => f == c.fixtureId) != null)
                    ?.value
                    .toDisplay() ??
                ""))),
        ..._effectIds.map((effectId) {
          var effect = cue.effects.firstWhereOrNull((e) => e.effectId == effectId);
          if (effect == null) {
            return Container();
          }

          return PopupTableCell(
              popup: PopupDirectTimeInput(
                  allowSeconds: false,
                  time: effect.hasEffectOffsets() ? CueTime(beats: effect.effectOffsets) : null,
                  onEnter: (value) => _updateCueEffectOffsetTime(
                      context, cue, effect, value?.hasBeats() == true ? value!.beats : null)),
              child: Text(effect.hasEffectOffsets() ? "${effect.effectOffsets} Beats" : ""));
        })
      ], highlight: activeCue == cue.id);
    }).toList();
  }

  void _updateCueEffectOffsetTime(BuildContext context, Cue cue, CueEffect effect, double? value) {
    context.read<SequencerBloc>().add(UpdateCueEffectOffsetTime(
        sequence: sequence.id, cue: cue.id, effect: effect.effectId, time: value));
  }
}

extension CueTimerDisplayExtensions on CueTimer {
  String toDisplay() {
    if (hasDirect()) {
      return direct.toDisplay();
    }
    if (hasRange()) {
      return "${range.from.toDisplay()} .. ${range.to.toDisplay()}";
    }
    return "";
  }
}

extension CueTimeDisplayExtensions on CueTime {
  String toDisplay() {
    if (hasBeats()) {
      return "$beats Beats";
    } else {
      return "${seconds}s";
    }
  }
}

extension CueValueDisplayExtensions on CueValue {
  String toDisplay() {
    return hasDirect()
        ? direct.toPercentage()
        : "${range.from.toPercentage()} .. ${range.to.toPercentage()}";
  }
}

class FixtureControl {
  final FixtureId fixtureId;
  final CueControl_Type control;

  FixtureControl(this.fixtureId, this.control);
}
