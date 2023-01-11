import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';

import 'selection_sheet.dart';

class SelectionPane extends StatefulWidget {
  const SelectionPane({Key? key}) : super(key: key);

  @override
  State<SelectionPane> createState() => _SelectionPaneState();
}

class _SelectionPaneState extends State<SelectionPane> with SingleTickerProviderStateMixin {
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
      return SelectionSheet(
          fixtures: getSelectedInstances(selection, fixtures.fixtures),
          isEmpty: selectedIds.isEmpty && trackedIds.isEmpty,
          api: context.read(),
          state: state,
      );
    });
  }

  List<FixtureId> get trackedIds {
    return state.fixtures;
  }


  List<FixtureId> get selectedIds {
    return state.activeFixtures;
  }

  List<FixtureId> get selection {
    return state.selection.fixtures.map((e) => e.fixtures.first).toList();
  }

  List<FixtureInstance> getSelectedInstances(List<FixtureId> selectedIds, List<Fixture> fixtures) {
    return selectedIds
        .map((id) => fixtures.getFixture(id))
        .where((element) => element != null)
        .map((fixture) => fixture!)
        .toList();
  }
}
