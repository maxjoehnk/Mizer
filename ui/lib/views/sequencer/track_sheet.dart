import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/widgets/table/table.dart';

const LABELS = {
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

class TrackSheet extends StatefulWidget {
  final Sequence sequence;
  final int? activeCue;

  const TrackSheet({required this.sequence, this.activeCue, Key? key}) : super(key: key);

  @override
  State<TrackSheet> createState() => _TrackSheetState();
}

class _TrackSheetState extends State<TrackSheet> {
  final _horizontalScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    var columnWidths = {
      0: FixedColumnWidth(75),
    };
    for (var i = 1; i <= _controls.length; i++) {
      columnWidths[i] = FixedColumnWidth(100);
    }
    return Scrollbar(
      controller: _horizontalScroll,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _horizontalScroll,
        scrollDirection: Axis.horizontal,
        child: MizerTable(columnWidths: columnWidths, columns: [
          Text("Cue"),
          ..._controls.map((c) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text(c.fixtureId.toDisplay()), Text(LABELS[c.control]!)])),
        ], rows: _buildRows(context)),
      ),
    );
  }

  Iterable<FixtureControl> get _controls {
    var controls = widget.sequence.cues.expand((e) => e.controls).map((control) => control.type).toSet();

    return widget.sequence.fixtures
        .expand((f) => controls.map((c) => FixtureControl(f, c)))
        .sorted((lhs, rhs) {
          var fixtureId = lhs.fixtureId.compareTo(rhs.fixtureId);
          if (fixtureId != 0) {
            return fixtureId;
          }
          return lhs.control.value - rhs.control.value;
        });
  }

  List<MizerTableRow> _buildRows(BuildContext context) {
    return widget.sequence.cues.map((cue) {
      return MizerTableRow(cells: [
        Text(cue.id.toString()),
        ..._controls.map((c) => Center(
            child: Text(cue.controls
                    .firstWhereOrNull((element) => element.type == c.control &&
                        element.fixtures.firstWhereOrNull((f) => f == c.fixtureId) != null)
                    ?.value
                    .toDisplay() ??
                "")))
      ], highlight: widget.activeCue == cue.id);
    }).toList();
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
