import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';

import 'programmer_sheet.dart';

class ProgrammerView extends StatefulWidget {
  @override
  State<ProgrammerView> createState() => _ProgrammerViewState();
}

class _ProgrammerViewState extends State<ProgrammerView>
    with SingleTickerProviderStateMixin, ProgrammerStateMixin {
  @override
  Widget build(BuildContext context) {
    FixturesBloc fixturesBloc = context.read();
    fixturesBloc.add(FetchFixtures());

    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return ProgrammerSheet(
          highlight: programmerState.highlight,
          channels: programmerState.controls
              .where((c) => c.fixtures.any((fixtureId) => selectedIds.contains(fixtureId)))
              .toList(),
          isEmpty: selectedIds.isEmpty && trackedIds.isEmpty,
          fixtures: getSelectedInstances(selectedIds, fixtures.fixtures),
          api: context.read());
    });
  }

  List<FixtureId> get trackedIds {
    return programmerState.fixtures;
  }

  List<FixtureId> get selectedIds {
    return programmerState.activeFixtures;
  }

  List<FixtureInstance> getSelectedInstances(List<FixtureId> selectedIds, List<Fixture> fixtures) {
    return selectedIds
        .map((id) => fixtures.getFixture(id))
        .where((element) => element != null)
        .map((fixture) => fixture!)
        .toList();
  }
}
