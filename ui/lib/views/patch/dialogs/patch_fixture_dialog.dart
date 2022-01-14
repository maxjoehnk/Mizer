import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';

import 'fixture_selector.dart';

class PatchFixtureDialog extends StatelessWidget {
  final FixturesApi apiClient;
  final FixturesBloc fixturesBloc;

  PatchFixtureDialog(this.apiClient, this.fixturesBloc);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiClient.getFixtureDefinitions(),
        initialData: FixtureDefinitions(),
        builder: (context, AsyncSnapshot<FixtureDefinitions> state) {
          return Dialog(
              child: PatchFixtureDialogStepper(
            definitions: state.data!,
            bloc: fixturesBloc,
          ));
        });
  }
}

class PatchFixtureDialogStepper extends StatefulWidget {
  final FixtureDefinitions definitions;
  final FixturesBloc bloc;

  PatchFixtureDialogStepper({required this.definitions, required this.bloc});

  @override
  _PatchFixtureDialogStepperState createState() => _PatchFixtureDialogStepperState();
}

class _PatchFixtureDialogStepperState extends State<PatchFixtureDialogStepper> {
  int step = 0;
  FixtureDefinition? definition;
  FixtureMode? mode;
  String? name;
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
          definition: definition,
          mode: mode,
          onSelect: (definition, mode) => setState(() {
                this.definition = definition;
                this.mode = mode;
              }));
    }
    if (step == 1) {
      return FixturePatch(this.definition!, this.mode!,
          initialId: widget.bloc.state.fixtures.isEmpty ? 1 : widget.bloc.state.fixtures.map((f) => f.id).reduce(max) + 1,
          initialChannel: widget.bloc.state.fixtures.isEmpty ? 1 : widget.bloc.state.fixtures.map((f) => f.channel + f.channelCount).reduce(max),
          onChange: (event) => setState(() {
                name = event.name;
                universe = event.universe;
                channel = event.channel;
                id = event.id;
                count = event.count;
              }));
    }
    return Container();
  }

  List<Widget> _getActions(BuildContext context) {
    if (step == 0) {
      return [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel")),
        ),
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
          child: TextButton(
              onPressed: () => setState(() => step = 0),
              child: Text("Back")),
        ),
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
        definition: definition!,
        name: name!,
        mode: mode!,
        startId: id,
        universe: universe,
        startChannel: channel,
        count: count));
    Navigator.pop(context);
  }
}

class FixturePatch extends StatefulWidget {
  final FixtureDefinition definition;
  final FixtureMode mode;
  final Function(PatchSettingsEvent) onChange;
  final int initialId;
  final int initialChannel;

  FixturePatch(this.definition, this.mode, {required this.onChange, required this.initialId, required this.initialChannel});

  @override
  _FixturePatchState createState() => _FixturePatchState();
}

class _FixturePatchState extends State<FixturePatch> {
  String name = "";
  int universe = 1;
  int channel = 1;
  int id = 1;
  int count = 1;

  @override
  void initState() {
    super.initState();
    name = widget.definition.name + " 1";
    id = widget.initialId;
    channel = widget.initialChannel;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          PatchSettings(
              name: name,
              universe: universe,
              channel: channel,
              id: id,
              count: count,
              onChange: (event) {
                setState(() {
                  name = event.name;
                  universe = event.universe;
                  channel = event.channel;
                  id = event.id;
                  count = event.count;
                });
                widget.onChange(event);
              }),
          // TODO: show fixture preview
          UniversePreview(),
        ]);
  }
}

class PatchSettings extends StatefulWidget {
  final Function(PatchSettingsEvent) onChange;
  final String name;
  final int universe;
  final int channel;
  final int id;
  final int count;

  PatchSettings({Key? key, required this.channel, required this.universe, required this.name, required this.id, required this.count, required this.onChange}) : super(key: key);

  @override
  _PatchSettingsState createState() =>
      _PatchSettingsState(name: name, universe: universe, channel: channel, id: id, count: count);
}

class _PatchSettingsState extends State<PatchSettings> {
  final TextEditingController _nameController;
  final TextEditingController _universeController;
  final TextEditingController _channelController;
  final TextEditingController _idController;
  final TextEditingController _countController;

  _PatchSettingsState({required String name, required int channel, required int universe, required int id, required int count})
      : _nameController = TextEditingController(text: name),
        _universeController = TextEditingController(text: universe.toString()),
        _channelController = TextEditingController(text: channel.toString()),
        _idController = TextEditingController(text: id.toString()),
        _countController = TextEditingController(text: count.toString()) {
    this._nameController.addListener(() => this._emitUpdate());
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
          decoration: InputDecoration(labelText: "Name"),
          controller: _nameController,
          keyboardType: TextInputType.text,
        ),
      ),
      PatchField(
        child: TextField(
          decoration: InputDecoration(labelText: "Universe"),
          controller: _universeController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
        ),
      ),
      PatchField(
        child: TextField(
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
    ]);
  }

  _emitUpdate() {
    String name = _nameController.text;
    int id = int.parse(_idController.text);
    int universe = int.parse(_universeController.text);
    int channel = int.parse(_channelController.text);
    int count = int.parse(_countController.text);
    var event = PatchSettingsEvent(
        id: id, name: name, universe: universe, channel: channel, count: count);
    this.widget.onChange(event);
  }
}

class PatchSettingsEvent {
  final String name;
  final int id;
  final int universe;
  final int channel;
  final int count;

  PatchSettingsEvent({required this.id, required this.name, required this.universe, required this.channel, required this.count});
}

class UniversePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PatchField extends StatelessWidget {
  final Widget child;

  PatchField({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: this.child, width: 512, height: 64);
  }
}
