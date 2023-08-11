import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/table/table.dart';

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
          return PatchFixtureDialogStepper(
            definitions: state.data!,
            bloc: fixturesBloc,
          );
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
    var windowSize = MediaQuery.of(context).size;
    return ActionDialog(
      title: "Patch Fixture",
      content: SizedBox(
          child: _getStep(), width: windowSize.width * 0.9, height: windowSize.height * 0.8),
      actions: _getActions(context),
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
      return FixturePatch(
        this.definition!,
        this.mode!,
        initialId: widget.bloc.state.fixtures.isEmpty
            ? 1
            : widget.bloc.state.fixtures.map((f) => f.id).reduce(max) + 1,
        initialChannel: widget.bloc.state.fixtures.isEmpty
            ? 1
            : widget.bloc.state.fixtures.map((f) => f.channel + f.channelCount).reduce(max),
        onChange: (event) => setState(() {
          name = event.name;
          universe = event.universe;
          channel = event.channel;
          id = event.id;
          count = event.count;
        }),
        onConfirm: () => this.addFixtures(context),
      );
    }
    return Container();
  }

  List<PopupAction> _getActions(BuildContext context) {
    if (step == 0) {
      return [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
        PopupAction("Next", () => this.mode == null ? null : setState(() => step += 1)),
      ];
    }
    if (step == 1) {
      return [
        PopupAction("Back", () => setState(() => step = 0)),
        PopupAction("Add Fixtures", () => this.addFixtures(context)),
      ];
    }
    return [];
  }

  Future addFixtures(BuildContext context) async {
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
  final Function() onConfirm;
  final int initialId;
  final int initialChannel;

  FixturePatch(this.definition, this.mode,
      {required this.onChange,
      required this.onConfirm,
      required this.initialId,
      required this.initialChannel});

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PatchSettings(
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
                  },
                  onConfirm: widget.onConfirm),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FixturePatchPreview(
                  mode: widget.mode,
                  universe: universe,
                  startChannel: channel,
                  startId: id,
                  count: count),
            )),
          ]),
    );
  }
}

class PatchSettings extends StatefulWidget {
  final Function(PatchSettingsEvent) onChange;
  final Function() onConfirm;
  final String name;
  final int universe;
  final int channel;
  final int id;
  final int count;

  PatchSettings(
      {Key? key,
      required this.channel,
      required this.universe,
      required this.name,
      required this.id,
      required this.count,
      required this.onChange,
      required this.onConfirm})
      : super(key: key);

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

  _PatchSettingsState(
      {required String name,
      required int channel,
      required int universe,
      required int id,
      required int count})
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
          textInputAction: TextInputAction.next,
        ),
      ),
      PatchField(
        child: TextField(
          decoration: InputDecoration(labelText: "Universe"),
          controller: _universeController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
          textInputAction: TextInputAction.next,
        ),
      ),
      PatchField(
        child: TextField(
          decoration: InputDecoration(labelText: "Channel"),
          controller: _channelController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
          textInputAction: TextInputAction.next,
        ),
      ),
      PatchField(
        child: TextField(
          decoration: InputDecoration(labelText: "Start ID"),
          controller: _idController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
          textInputAction: TextInputAction.next,
        ),
      ),
      PatchField(
        child: TextField(
          decoration: InputDecoration(labelText: "Count"),
          controller: _countController,
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => widget.onConfirm(),
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
    var event =
        PatchSettingsEvent(id: id, name: name, universe: universe, channel: channel, count: count);
    this.widget.onChange(event);
  }
}

class PatchSettingsEvent {
  final String name;
  final int id;
  final int universe;
  final int channel;
  final int count;

  PatchSettingsEvent(
      {required this.id,
      required this.name,
      required this.universe,
      required this.channel,
      required this.count});
}

class FixturePatchPreview extends StatelessWidget {
  final FixtureMode mode;
  final int universe;
  final int startChannel;
  final int count;
  final int startId;

  const FixturePatchPreview(
      {Key? key,
      required this.mode,
      required this.universe,
      required this.startChannel,
      required this.startId,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MizerTableRow> rows = _getRows();

    return SingleChildScrollView(
      child: MizerTable(
        columnWidths: {
          0: FixedColumnWidth(64),
          1: FixedColumnWidth(128),
        },
        columns: [
          Text("Id"),
          Text("Address"),
        ],
        rows: rows,
      ),
    );
  }

  List<MizerTableRow> _getRows() {
    List<MizerTableRow> rows = [];

    var channelCount = mode.channels.map((e) {
      if (e.hasFine()) {
        return 2;
      }
      if (e.hasFinest()) {
        return 3;
      }
      return 1;
    }).sum;
    for (var i = 0; i < count; i++) {
      var id = startId + i;
      var startAddress = startChannel + (i * channelCount);
      var endAddress = startAddress + channelCount - 1;

      rows.add(MizerTableRow(cells: [
        Text(id.toString()),
        Text("$universe:$startAddress - $universe:$endAddress"),
      ]));
    }

    return rows;
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
