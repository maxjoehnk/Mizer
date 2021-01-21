import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/protos/fixtures.pb.dart';

class FixturesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return DataTable(
          columns: const [
            DataColumn(label: Text("Id")),
            DataColumn(label: Text("Manufacturer")),
            DataColumn(label: Text("Model")),
            DataColumn(label: Text("Address"))
          ],
          rows: fixtures.fixtures
              .map((fixture) => DataRow(cells: [
                    DataCell(Text(fixture.id)),
                    DataCell(Text(fixture.manufacturer)),
                    DataCell(Text(fixture.name)),
                    DataCell(Text("${fixture.universe}:${fixture.channel}"))
                  ]))
              .toList());
    });
  }
}
