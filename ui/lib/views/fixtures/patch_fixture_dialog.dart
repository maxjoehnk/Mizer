import 'package:flutter/material.dart';
import 'package:mizer/protos/fixtures.pbgrpc.dart';
import 'package:mizer/state/fixtures_bloc.dart';

import 'fixture_selector.dart';

class PatchFixtureDialog extends StatelessWidget {
  final FixturesApiClient apiClient;
  final FixturesBloc fixturesBloc;

  PatchFixtureDialog(this.apiClient, this.fixturesBloc);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiClient.getFixtureDefinitions(GetFixtureDefinitionsRequest()),
        initialData: FixtureDefinitions(),
        builder: (context, state) {
          return Dialog(
              child: PatchFixtureDialogStepper(
            definitions: state.data,
            bloc: fixturesBloc,
          ));
        });
  }
}

class PatchFixtureDialogStepper extends StatefulWidget {
  final FixtureDefinitions definitions;
  final FixturesBloc bloc;

  PatchFixtureDialogStepper({this.definitions, this.bloc});

  @override
  _PatchFixtureDialogStepperState createState() => _PatchFixtureDialogStepperState();
}

class _PatchFixtureDialogStepperState extends State<PatchFixtureDialogStepper> {
  int step = 0;
  FixtureDefinition definition;
  FixtureMode mode;
  int universe = 1;
  int channel = 1;
  int id = 1;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Patch Fixture",
            style: textTheme.headline6,
          ),
        ),
        Expanded(child: _getStep()),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: _getActions(context))
      ],
    );
  }

  Widget _getStep() {
    if (step == 0) {
      return FixtureSelector(widget.definitions,
          onSelect: (definition, mode) => setState(() {
                this.definition = definition;
                this.mode = mode;
              }));
    }
    if (step == 1) {
      return FixturePatch(this.mode,
          onChange: (event) => setState(() {
                universe = event.universe;
                channel = event.channel;
                id = event.id;
                count = event.count;
              }));
    }
    return null;
  }

  List<Widget> _getActions(BuildContext context) {
    if (step == 0) {
      return [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: this.mode == null ? null : () => setState(() => step += 1),
              child: Text("Next")),
        ),
      ];
    }
    if (step == 1) {
      return [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () => this.addFixture(context), child: Text("Add Fixtures")),
        )
      ];
    }
    return [];
  }

  Future addFixture(BuildContext context) async {
    widget.bloc.add(AddFixtures(
        definition: definition,
        mode: mode,
        startId: id,
        universe: universe,
        startChannel: channel,
        count: count));
    Navigator.pop(context);
  }
}

class FixturePatch extends StatefulWidget {
  final FixtureMode mode;
  final Function(PatchSettingsEvent) onChange;

  FixturePatch(this.mode, {this.onChange});

  @override
  _FixturePatchState createState() => _FixturePatchState();
}

class _FixturePatchState extends State<FixturePatch> {
  int universe = 1;
  int channel = 1;
  int id = 1;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          PatchSettings(
              universe: 1,
              channel: 1,
              id: 1,
              count: 1,
              onChange: (event) {
                setState(() {
                  universe = event.universe;
                  channel = event.channel;
                  id = event.id;
                  count = event.count;
                });
                widget.onChange(event);
              }),
          UniversePreview(),
        ]);
  }
}

class PatchSettings extends StatefulWidget {
  final Key key;
  final Function(PatchSettingsEvent) onChange;
  final int universe;
  final int channel;
  final int id;
  final int count;

  PatchSettings({this.key, this.channel, this.universe, this.id, this.count, this.onChange});

  @override
  _PatchSettingsState createState() =>
      _PatchSettingsState(universe: universe, channel: channel, id: id, count: count);
}

class _PatchSettingsState extends State<PatchSettings> {
  final TextEditingController _universeController;
  final TextEditingController _channelController;
  final TextEditingController _idController;
  final TextEditingController _countController;

  bool createNodes = true;

  _PatchSettingsState({int channel, int universe, int id, int count})
      : _universeController = TextEditingController(text: universe.toString()),
        _channelController = TextEditingController(text: channel.toString()),
        _idController = TextEditingController(text: id.toString()),
        _countController = TextEditingController(text: count.toString()) {
    this._universeController.addListener(() => this._emitUpdate());
    this._channelController.addListener(() => this._emitUpdate());
    this._idController.addListener(() => this._emitUpdate());
    this._countController.addListener(() => this._emitUpdate());
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      PatchField(
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(labelText: "Universe"),
          controller: _universeController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
        ),
      ),
      PatchField(
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(labelText: "Channel"),
          controller: _channelController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
        ),
      ),
      PatchField(
        child: TextField(
          decoration: InputDecoration(labelText: "Start ID"),
          controller: _idController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
        ),
      ),
      PatchField(
        child: TextField(
          decoration: InputDecoration(labelText: "Count"),
          controller: _countController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
        ),
      ),
      PatchField(
          child: Row(
        children: [
          Checkbox(
            value: createNodes,
            onChanged: (value) => setState(() {
              createNodes = value;
              this._emitUpdate();
            }),
          ),
          Text("Create Nodes")
        ],
      ))
    ]);
  }

  _emitUpdate() {
    int id = int.parse(_idController.text);
    int universe = int.parse(_universeController.text);
    int channel = int.parse(_channelController.text);
    int count = int.parse(_countController.text);
    var event = PatchSettingsEvent(
        id: id, universe: universe, channel: channel, count: count, createNodes: createNodes);
    this.widget.onChange(event);
  }
}

class PatchSettingsEvent {
  final int id;
  final int universe;
  final int channel;
  final int count;
  final bool createNodes;

  PatchSettingsEvent({this.id, this.universe, this.channel, this.count, this.createNodes});
}

class UniversePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PatchField extends StatelessWidget {
  final Widget child;

  PatchField({@required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: this.child, width: 512, height: 64);
  }
}
