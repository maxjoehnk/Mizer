import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/widgets/popup/popup_input.dart';
import 'package:mizer/widgets/table/table.dart';

class FixtureChannelLimits extends StatelessWidget {
  final List<int> selectedIds;
  final Function(int, UpdateFixtureRequest) onUpdateFixture;

  FixtureChannelLimits({super.key, required this.selectedIds, required this.onUpdateFixture});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      List<Fixture> selectedFixtures =
          fixtures.fixtures.where((f) => selectedIds.contains(f.id)).toList();
      List<FixtureChannel> controls = selectedFixtures.firstOrNull?.channels ?? [];

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _table(controls, selectedFixtures),
      );
    });
  }

  Widget _table(List<FixtureChannel> controls, List<Fixture> selectedFixtures) {
    if (controls.isEmpty) {
      return Container();
    }
    return MizerTable(columnWidths: {
      0: FixedColumnWidth(100),
      ...controls.asMap().map((key, value) => MapEntry(key + 1, FixedColumnWidth(100)))
    }, columns: [
      Container(),
      ...controls.map((e) => Text(_controlName(e))),
    ], rows: [
      _buildRow(controls, selectedFixtures, "Min", (limit) {
        if (limit == null) {
          return null;
        }
        if (!limit.hasMin()) {
          return null;
        }
        return limit.min;
      },
          (control, limit, value) => UpdateFixtureRequest_UpdateFixtureLimit(
                channel: control.channel,
                min: value,
                max: (limit?.hasMax() ?? false) ? limit!.max : null,
              )),
      _buildRow(controls, selectedFixtures, "Max", (limit) {
        if (limit == null) {
          return null;
        }
        if (!limit.hasMax()) {
          return null;
        }
        return limit.max;
      },
          (control, limit, value) => UpdateFixtureRequest_UpdateFixtureLimit(
                channel: control.channel,
                min: (limit?.hasMin() ?? false) ? limit!.min : null,
                max: value,
              )),
    ]);
  }

  String _controlName(FixtureChannel control) {
    return control.channel;
  }

  MizerTableRow _buildRow(
      List<FixtureChannel> controls,
      List<Fixture> selectedFixtures,
      String title,
      double? Function(FixtureChannelLimit?) getValue,
      UpdateFixtureRequest_UpdateFixtureLimit Function(
              FixtureChannel, FixtureChannelLimit?, double?)
          updateLimit) {
    return MizerTableRow(cells: [
      Text(title),
      ...controls.map((control) {
        var limit = selectedFixtures
            .map((fixture) => fixture.config.channelLimits
                .firstWhereOrNull((channelLimit) => channelLimit.channel == control.channel))
            .firstOrNull;
        var value = getValue(limit);
        return PopupTableCell(
            child: Text("${value != null ? value.toPercentage() : "--"}"),
            popup: PopupInput(
              title: "$title ${_controlName(control)}",
              value: value != null ? (value * 100).toString() : "",
              onChange: (value) {
                var newLimit = double.tryParse(value);
                newLimit = newLimit == null ? newLimit : newLimit / 100;
                selectedFixtures.forEach((fixture) {
                  var oldLimit = fixture.config.channelLimits
                      .firstWhereOrNull((channelLimit) => channelLimit.channel == control.channel);

                  onUpdateFixture(fixture.id,
                      UpdateFixtureRequest(limit: updateLimit(control, oldLimit, newLimit)));
                });
              },
            ));
      })
    ]);
  }
}
