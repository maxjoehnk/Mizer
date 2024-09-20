import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/fixtures/position_indicator.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

import 'color_indicator.dart';
import 'fader_indicator.dart';

class FixturesTable extends StatelessWidget {
  final List<Fixture> fixtures;
  final List<FixtureId> selectedIds;
  final List<FixtureId> trackedIds;
  final List<int> expandedIds;
  final ProgrammerState? state;
  final Function(FixtureId, bool) onSelect;
  final Function(int) onExpand;
  final Function(Fixture) onSelectSimilar;
  final Function(Fixture) onSelectChildren;

  FixturesTable(
      {required this.fixtures,
      required this.selectedIds,
      required this.trackedIds,
      required this.expandedIds,
      this.state,
      required this.onSelect,
      required this.onExpand,
      required this.onSelectSimilar,
      required this.onSelectChildren,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MizerTableRow> rows = _getRows(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: MizerTable(
            columnWidths: {
              0: FixedColumnWidth(40),
              1: FixedColumnWidth(50),
              2: FixedColumnWidth(150),
              3: FixedColumnWidth(128),
              4: FixedColumnWidth(128),
              5: FixedColumnWidth(40),
              6: FixedColumnWidth(128),
              7: FixedColumnWidth(128),
              8: FixedColumnWidth(128),
              9: FixedColumnWidth(40),
              10: FixedColumnWidth(128),
              11: FixedColumnWidth(128),
              12: FixedColumnWidth(128),
            },
            headerAlignment: AlignmentDirectional.center,
            columns: [
              Text(""),
              Text("Id".i18n),
              Text("Name".i18n),
              Text("Intensity".i18n),
              Text("Shutter".i18n),
              Container(),
              Text("Red".i18n),
              Text("Green".i18n),
              Text("Blue".i18n),
              Container(),
              Text("Pan".i18n),
              Text("Tilt".i18n),
              Text("Gobo".i18n),
            ],
            rows: rows),
      ),
    );
  }

  List<MizerTableRow> _getRows(BuildContext context) {
    List<MizerTableRow> rows = [];
    for (var fixture in fixtures) {
      rows.add(_fixtureRow(context, fixture, expandedIds.contains(fixture.id)));
      if (expandedIds.contains(fixture.id)) {
        for (var child in fixture.children) {
          rows.add(_subFixtureRow(context, fixture, child));
        }
      }
    }
    return rows;
  }

  MizerTableRow _fixtureRow(BuildContext context, Fixture fixture, bool expanded) {
    var fixtureId = FixtureId(fixture: fixture.id);
    var fixtureState = state?.controls.where((channel) => channel.fixtures.contains(fixtureId));

    return _row(
      context,
      fixtureId,
      fixture.name,
      fixtureState,
      onSelectSimilar: () => onSelectSimilar(fixture),
      child: fixture.children.isEmpty
            ? Container()
            : MizerIconButton(
                onClick: () => onExpand(fixture.id),
                icon: expanded ? Icons.arrow_drop_down : Icons.arrow_right,
                label: "Expand".i18n,
              ),
    );
  }

  MizerTableRow _subFixtureRow(BuildContext context, Fixture fixture, SubFixture subFixture) {
    var fixtureId =
        FixtureId(subFixture: SubFixtureId(fixtureId: fixture.id, childId: subFixture.id));
    var fixtureState = state?.controls
        .where((channel) => channel.fixtures.any((f) => f.subFixture == fixtureId.subFixture));

    return _row(
      context,
      fixtureId,
      subFixture.name,
      fixtureState,
      onSelectSimilar: () => onSelectChildren(fixture),
    );
  }

  MizerTableRow _row(BuildContext context, FixtureId id, String name, Iterable<ProgrammerChannel>? fixtureState, { Widget? child, required Function() onSelectSimilar }) {
    var selected = selectedIds.contains(id);
    var tracked = trackedIds.contains(id);
    var textStyle = tracked ? TextStyle(color: Colors.deepOrange) : TextStyle();

    var row = MizerTableRow(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      cells: [
        child ?? Container(),
        Text(id.toDisplay(), style: textStyle),
        Text(name, style: textStyle),
        IntensityIndicator(
            fixtureState: fixtureState,
            child: Text(_faderState(context, fixtureState, "Intensity"), style: textStyle)),
        Text(_faderState(context, fixtureState, "Shutter1"), style: textStyle),
        ColorIndicator(fixtureState: fixtureState),
        Text(_faderState(context, fixtureState, "ColorMixerRed"), style: textStyle),
        Text(_faderState(context, fixtureState, "ColorMixerGreen", presetControl: "ColorMixerRed"), style: textStyle),
        Text(_faderState(context, fixtureState, "ColorMixerBlue", presetControl: "ColorMixerRed"), style: textStyle),
        PositionIndicator(fixtureState: fixtureState),
        Text(_faderState(context, fixtureState, "Pan"), style: textStyle),
        Text(_faderState(context, fixtureState, "Tilt"), style: textStyle),
        Text(_faderState(context, fixtureState, "GoboWheel1"), style: textStyle),
      ],
      onTap: () => onSelect(id, !selected),
      onDoubleTap: onSelectSimilar,
      selected: selected,
    );
    return row;
  }

  // FIXME: `presetControl` is a hack because currently the preset is only listed in the pan control
  String _faderState(BuildContext context, Iterable<ProgrammerChannel>? fixtureState, String control, { String? presetControl }) {
    var programmerChannel = fixtureState?.firstWhereOrNull((element) => element.control == control);
    var presetChannel = fixtureState?.firstWhereOrNull((element) => element.control == (presetControl ?? control));
    if (programmerChannel == null && presetChannel == null) {
      return "";
    }
    if (presetChannel?.hasPreset() == true) {
      PresetsBloc bloc = context.read();
      var preset = bloc.state.getPreset(presetChannel!.preset);
      if (preset == null) {
        return "";
      }
      return "${presetId(preset)} - ${preset.label}";
    }
    if (programmerChannel == null) {
      return "";
    }
    var value = programmerChannel.direct.percent;
    return "${(value * 100).toStringAsFixed(1)}%";
  }
}

String presetId(Preset preset) {
  if (preset.id.type == PresetId_PresetType.COLOR) {
    return "C${preset.id.id}";
  }
  if (preset.id.type == PresetId_PresetType.INTENSITY) {
    // Panel is actually called Dimmer
    return "D${preset.id.id}";
  }
  if (preset.id.type == PresetId_PresetType.SHUTTER) {
    return "S${preset.id.id}";
  }
  if (preset.id.type == PresetId_PresetType.POSITION) {
    return "P${preset.id.id}";
  }
  return "";
}
