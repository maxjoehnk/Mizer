import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart' show StreamGroup;

class FixtureList extends StatefulWidget {
  @override
  State<FixtureList> createState() => _FixtureListState();
}

class _FixtureListState extends State<FixtureList> {
  late Stream<Fixtures> _fixtures;
  late Stream<ProgrammerState> _programmer;

  @override
  void initState() {
    super.initState();
    var initial = Stream.fromFuture(_fixturesApi.getFixtures());
    var periodic = Stream.periodic(Duration(seconds: 1)).asyncMap((_) => _fixturesApi.getFixtures());
    this._fixtures = StreamGroup.merge([initial, periodic]).asBroadcastStream();
    this._programmer = _programmerApi.observe().asBroadcastStream();
    this._programmer.handleError((_) {
      this._programmer = _programmerApi.observe().asBroadcastStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Fixtures>(
        stream: _fixtures,
        builder: (context, fixturesSnapshot) {
          var fixtures =
              (fixturesSnapshot.data ?? Fixtures()).fixtures.sorted((a, b) => a.id.compareTo(b.id));
          return StreamBuilder<ProgrammerState>(
              stream: _programmer,
              builder: (context, programmerSnapshot) {
                var programmer = programmerSnapshot.data ?? ProgrammerState();
                return Panel(
                    label: 'Patch',
                    actions: [
                      PanelActionModel(
                          label: "Highlight",
                          activated: programmer.highlight,
                          onClick: () => _programmerApi.highlight(!programmer.highlight)),
                      PanelActionModel(
                          disabled: !fixturesSnapshot.hasData,
                          label: "Select All",
                          onClick: () => _programmerApi.selectFixtures(fixtures
                              .map((f) => f.id)
                              .map((id) => FixtureId(fixture: id))
                              .toList())),
                      PanelActionModel(
                          label: "Clear",
                          onClick: () => _programmerApi.clear(),
                          disabled: programmer.activeFixtures.isEmpty),
                      PanelActionModel(
                          label: "Prev",
                          disabled: programmer.activeFixtures.isEmpty,
                          onClick: () => _programmerApi.prev()),
                      PanelActionModel(
                          label: "Next",
                          disabled: programmer.activeFixtures.isEmpty,
                          onClick: () => _programmerApi.next()),
                      PanelActionModel(
                          label: "Set",
                          disabled: programmer.activeFixtures.isEmpty,
                          onClick: () => _programmerApi.set()),
                    ],
                    child: _child(fixtures, programmer));
              });
        });
  }

  FixturesApi get _fixturesApi {
    return context.read();
  }

  ProgrammerApi get _programmerApi {
    return context.read();
  }

  Widget _child(List<Fixture> fixtures, ProgrammerState programmerState) {
    return ListView(
        children: fixtures.map((fixture) {
      var selected = programmerState.activeFixtures.contains(FixtureId(fixture: fixture.id));
      return ListTile(
        title: Text(fixture.name),
        subtitle: Text("${fixture.universe}.${fixture.channel.toString().padLeft(3, '0')}"),
        leading: Text(fixture.id.toString()),
        selected: selected,
        selectedColor: Colors.deepOrangeAccent,
        dense: true,
        visualDensity: VisualDensity.compact,
        onTap: () {
          if (selected) {
            _programmerApi.unselectFixtures([FixtureId(fixture: fixture.id)]);
          } else {
            _programmerApi.selectFixtures([FixtureId(fixture: fixture.id)]);
          }
        },
        onLongPress: () {
          _programmerApi.selectFixtures(fixtures
              .where((f) => f.manufacturer == fixture.manufacturer && f.model == fixture.model)
              .map((f) => FixtureId(fixture: f.id))
              .toList());
        },
      );
    }).toList());
  }
}
