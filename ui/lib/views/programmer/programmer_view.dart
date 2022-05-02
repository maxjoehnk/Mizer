import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';

import 'programmer_sheet.dart';

class ProgrammerView extends StatefulWidget {
  @override
  State<ProgrammerView> createState() => _ProgrammerViewState();
}

class _ProgrammerViewState extends State<ProgrammerView> with SingleTickerProviderStateMixin {
  ProgrammerStatePointer? _pointer;
  Ticker? ticker;
  ProgrammerState state = ProgrammerState();

  @override
  void initState() {
    super.initState();
    var programmerApi = context.read<ProgrammerApi>();
    programmerApi.getProgrammerPointer()
      .then((pointer) {
      _pointer = pointer;
        ticker = this.createTicker((elapsed) {
          setState(() {
            state = _pointer!.readState();
          });
        });
        ticker!.start();
    });
  }

  @override
  void dispose() {
    _pointer?.dispose();
    ticker?.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FixturesBloc fixturesBloc = context.read();
    fixturesBloc.add(FetchFixtures());

    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return ProgrammerSheet(
          highlight: state.highlight,
          channels: state.controls.where((c) => c.fixtures.any((fixtureId) => selectedIds.contains(fixtureId))).toList(),
          isEmpty: selectedIds.isEmpty && trackedIds.isEmpty,
          fixtures: getSelectedInstances(selectedIds, fixtures.fixtures),
          api: context.read());
    });
  }

  List<FixtureId> get trackedIds {
    return state.fixtures;
  }

  List<FixtureId> get selectedIds {
    return state.activeFixtures;
  }

  List<FixtureInstance> getSelectedInstances(List<FixtureId> selectedIds, List<Fixture> fixtures) {
    return selectedIds
        .map((id) => fixtures.getFixture(id))
        .where((element) => element != null)
        .map((fixture) => fixture!)
        .toList();
  }

  _selectAll(List<Fixture> fixtures) {
    _setSelectedIds(fixtures.map((f) => FixtureId(fixture: f.id)).toList());
  }

  _clear() {
    context.read<ProgrammerApi>().clear();
  }

  _setSelectedIds(List<FixtureId> ids) {
    context.read<ProgrammerApi>().selectFixtures(ids);
  }
}
