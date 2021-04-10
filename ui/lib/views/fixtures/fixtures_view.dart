import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/views/fixtures/patch_fixture_dialog.dart';

class FixturesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fixturesBloc = context.read<FixturesBloc>();
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
                columns: const [
                  DataColumn(label: Text("Id")),
                  DataColumn(label: Text("Manufacturer")),
                  DataColumn(label: Text("Model")),
                  DataColumn(label: Text("Mode")),
                  DataColumn(label: Text("Address"))
                ],
                rows: fixtures.fixtures
                    .sortedByCompare((fixture) => fixture.id, (lhs, rhs) => lhs - rhs)
                    .map((fixture) => DataRow(cells: [
                          DataCell(Text(fixture.id.toString())),
                          DataCell(Text(fixture.manufacturer)),
                          DataCell(Text(fixture.name)),
                          DataCell(Text(fixture.mode)),
                          DataCell(Text("${fixture.universe}:${fixture.channel}"))
                        ]))
                    .toList()),
            Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: AddFixturesButton(apiClient: fixturesApi, fixturesBloc: fixturesBloc)),
          ],
        );
      }),
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
