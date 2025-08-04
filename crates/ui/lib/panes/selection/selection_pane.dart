import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';

import 'package:mizer/panes/selection/selection_sheet.dart';

class SelectionPane extends StatefulWidget {
  const SelectionPane({Key? key}) : super(key: key);

  @override
  State<SelectionPane> createState() => _SelectionPaneState();
}

class _SelectionPaneState extends State<SelectionPane>
    with SingleTickerProviderStateMixin, ProgrammerStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FixturesBloc fixturesBloc = context.read();
      fixturesBloc.add(FetchFixtures());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return SelectionSheet(
        fixtures: getSelectedInstances(selection, fixtures.fixtures),
        isEmpty: selectedIds.isEmpty && trackedIds.isEmpty,
        api: context.read(),
        state: programmerState,
      );
    });
  }

  List<FixtureId> get trackedIds {
    return programmerState.fixtures;
  }

  List<FixtureId> get selectedIds {
    return programmerState.activeFixtures;
  }

  List<FixtureId> get selection {
    return programmerState.selection.fixtures.map((e) => e.fixtures.first).toList();
  }

  List<FixtureInstance> getSelectedInstances(List<FixtureId> selectedIds, List<Fixture> fixtures) {
    return selectedIds
        .map((id) => fixtures.getFixture(id))
        .where((element) => element != null)
        .map((fixture) => fixture!)
        .toList();
  }
}
