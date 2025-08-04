import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/number_field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/text_field.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/table/table.dart';

import 'package:mizer/views/patch/dialogs/fixture_selector.dart';

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
            apiClient: apiClient,
            definitions: state.data!,
            bloc: fixturesBloc,
          );
        });
  }
}

class PatchFixtureDialogStepper extends StatefulWidget {
  final FixturesApi apiClient;
  final FixtureDefinitions definitions;
  final FixturesBloc bloc;

  PatchFixtureDialogStepper({required this.definitions, required this.bloc, required this.apiClient});

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
        apiClient: widget.apiClient,
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
  final FixturesApi apiClient;
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
      required this.initialChannel, required this.apiClient});

  @override
  _FixturePatchState createState() => _FixturePatchState();
}

class _FixturePatchState extends State<FixturePatch> {
  String name = "";
  int universe = 1;
  int channel = 1;
  int id = 1;
  int count = 1;
  Fixtures fixturesPreview = Fixtures();

  @override
  void initState() {
    super.initState();
    name = widget.definition.name + " 1";
    id = widget.initialId;
    channel = widget.initialChannel;
    _fetchPreview();
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
                    _fetchPreview();
                  },
                  onConfirm: widget.onConfirm),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FixturePatchPreview(fixtures: fixturesPreview),
            )),
          ]),
    );
  }

  _fetchPreview() async {
    var request = AddFixturesRequest(
        request: AddFixtureRequest(
          id: id,
          name: name,
          universe: universe,
          channel: channel,
          definitionId: widget.definition.id,
          mode: widget.mode.name,
        ),
        count: count);
    var fixtures = await widget.apiClient.previewFixtures(request);
    setState(() {
      fixturesPreview = fixtures;
    });
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
  String name;
  int universe;
  int channel;
  int id;
  int count;

  _PatchSettingsState(
      {required this.name,
      required this.channel,
      required this.universe,
      required this.id,
      required this.count});


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Emit an initial update so confirming the pre-filled values works properly
      this._emitUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 512,
      child: Column(spacing: 2, mainAxisSize: MainAxisSize.min, children: [
        TextPropertyField(
          autofocus: true,
          big: true,
          label: "Name",
          value: name,
          onChanged: (value) {
            name = value;
            _emitUpdate();
          },
        ),
        NumberField(
          label: "Universe",
          big: true,
          value: universe,
          onUpdate: (value) {
            universe = value.toInt();
            _emitUpdate();
          },
          bar: false,
          min: 1,
          max: 524288,
        ),
        NumberField(
          label: "Channel",
          big: true,
          value: channel,
          onUpdate: (value) {
            channel = value.toInt();
            _emitUpdate();
          },
          bar: false,
          min: 1,
          max: 512,
        ),
        NumberField(
          label: "Start ID",
          big: true,
          value: id,
          onUpdate: (value) {
            id = value.toInt();
            _emitUpdate();
          },
          bar: false,
        ),
        NumberField(
          label: "Count",
          big: true,
          value: count,
          onUpdate: (value) {
            count = value.toInt();
            _emitUpdate();
          },
          bar: false,
          min: 1,
        ),
      ]),
    );
  }

  _emitUpdate() {
    var event = PatchSettingsEvent(id: id, name: name, universe: universe, channel: channel, count: count);
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
  final Fixtures fixtures;

  const FixturePatchPreview({Key? key, required this.fixtures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MizerTable(
      columnWidths: {
        0: FixedColumnWidth(64),
        2: FixedColumnWidth(128),
      },
      columns: [
        Text("Id"),
        Text("Name"),
        Text("Address"),
      ],
      rows: fixtures.fixtures.sorted((lhs, rhs) => lhs.id.compareTo(rhs.id)).map((f) {
        var startAddress = f.channel;
        var endAddress = f.channel + f.channelCount - 1;

        return MizerTableRow(cells: [
          Text(f.id.toString()),
          Text(f.name),
          Text("${f.universe}:$startAddress - ${f.universe}:$endAddress"),
        ]);
      }).toList(),
    );
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
