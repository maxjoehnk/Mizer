import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/views/fixtures/patch_fixture_dialog.dart';
import 'package:mizer/widgets/inputs/color.dart';
import 'package:mizer/widgets/inputs/fader.dart';

const double SHEET_SIZE = 320;

class FixturesView extends StatefulWidget {
  @override
  State<FixturesView> createState() => _FixturesViewState();
}

class _FixturesViewState extends State<FixturesView> {
  List<int> selectedIds = [];

  @override
  Widget build(BuildContext context) {
    FixturesBloc fixturesBloc = context.read();
    fixturesBloc.add(FetchFixtures());
    var fixturesApi = context.read<FixturesApi>();
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA): AddFixture(),
      },
      child: BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
        return Stack(
          fit: StackFit.expand,
          children: [
            DataTable(
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(label: Text("Id")),
                  DataColumn(label: Text("Manufacturer")),
                  DataColumn(label: Text("Model")),
                  DataColumn(label: Text("Mode")),
                  DataColumn(label: Text("Address"))
                ],
                rows: fixtures.fixtures
                    .sortedByCompare((fixture) => fixture.id, (lhs, rhs) => lhs - rhs)
                    .map((fixture) => DataRow(
                            cells: [
                              DataCell(Text(fixture.id.toString())),
                              DataCell(Text(fixture.manufacturer)),
                              DataCell(Text(fixture.name)),
                              DataCell(Text(fixture.mode)),
                              DataCell(Text("${fixture.universe}:${fixture.channel}"))
                            ],
                            onSelectChanged: (selected) {
                              setState(() {
                                if (selected) {
                                  this.selectedIds.add(fixture.id);
                                } else {
                                  this.selectedIds.remove(fixture.id);
                                }
                              });
                            },
                            selected: selectedIds.contains(fixture.id)))
                    .toList()),
            Positioned(
              bottom: bottomOffset,
              right: 0,
              child: Container(
                  padding: EdgeInsets.all(16),
                  child: AddFixturesButton(apiClient: fixturesApi, fixturesBloc: fixturesBloc)),
            ),
            if (selectedIds.isNotEmpty) FixtureSheet(fixtures: fixtures.fixtures.where((f) => selectedIds.contains(f.id)).toList(), api: fixturesApi),
          ],
        );
      }),
    );
  }

  double get bottomOffset {
    if (selectedIds.isEmpty) {
      return 0;
    }
    return SHEET_SIZE;
  }
}

class FixtureSheet extends StatelessWidget {
  final List<Fixture> fixtures;
  final FixturesApi api;

  const FixtureSheet({this.fixtures, this.api, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: SHEET_SIZE,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            boxShadow: [BoxShadow(offset: Offset(0, -2), blurRadius: 4, color: Colors.black26)]),
        padding: const EdgeInsets.all(8),
        child: groups.isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: groups.map(_buildFixtureGroup).toList())
            : null,
      ),
    );
  }

  List<FixtureChannelGroup> get groups {
    log("$fixtures");
    return fixtures.first.channels;
  }

  Widget _buildFixtureGroup(FixtureChannelGroup group) {
    Widget widget = Container();
    if (group.hasGeneric()) {
      widget = Container(width: 64, child: FaderInput(value: group.generic.value, onValue: (v) {
        api.writeFixtureChannel(WriteFixtureChannelRequest(
          ids: fixtures.map((f) => f.id).toList(),
          channel: group.name,
          fader: v,
        ));
      }));
    }
    if (group.hasColor()) {
      widget = ColorInput();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [Text(group.name), Expanded(child: widget)]),
    );
  }
}

class AddFixturesButton extends StatelessWidget {
  final FixturesApi apiClient;
  final FixturesBloc fixturesBloc;

  AddFixturesButton({this.apiClient, this.fixturesBloc});

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {AddFixture: CallbackAction(onInvoke: (_) => this.openDialog(context))},
      child: FloatingActionButton.extended(
          autofocus: true,
          onPressed: () => this.openDialog(context),
          label: Text("Add Fixture"),
          icon: Icon(Icons.add)),
    );
  }

  openDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => PatchFixtureDialog(this.apiClient, this.fixturesBloc));
  }
}

class AddFixture extends Intent {}
