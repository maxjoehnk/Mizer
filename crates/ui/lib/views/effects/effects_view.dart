import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/views/effects/dialogs/add_effect_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:protobuf/protobuf.dart';

import 'package:mizer/views/effects/effect_editor.dart';

class EffectsView extends StatefulWidget {
  const EffectsView({Key? key}) : super(key: key);

  @override
  State<EffectsView> createState() => _EffectsViewState();
}

class _EffectsViewState extends State<EffectsView> {
  StreamSubscription<EffectState>? _subscription;
  Effect? effect;
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    EffectsBloc bloc = context.read();
    _subscription = bloc.stream.listen((effects) {
      if (effect == null) {
        return;
      }
      setState(() {
        this.effect = effects.firstWhereOrNull((e) => e.id == this.effect?.id);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    EffectsBloc bloc = context.read();
    return HotkeyConfiguration(
      hotkeyGroupSelector: (hotkeys) => hotkeys["effects"],
      hotkeyMap: {
        "add_effect": () => _addEffect(context, bloc),
        "delete": () => _deleteEffect(bloc),
      },
      child: BlocBuilder<EffectsBloc, EffectState>(builder: (context, effects) {
        return Column(
          spacing: PANEL_GAP_SIZE,
          children: [
            Expanded(
              child: Panel(
                label: "Effects".i18n,
                child: MizerTable(
                  columns: [
                    Text("ID"),
                    Text("Name"),
                  ],
                  columnWidths: {
                    0: FixedColumnWidth(64),
                  },
                  rows: effects
                      .search([(e) => e.name], searchQuery)
                      .map((e) => MizerTableRow(
                              cells: [
                                Text(e.id.toString()),
                                Text(e.name),
                              ],
                              onTap: () => setState(() => this.effect = e),
                              selected: this.effect?.id == e.id))
                      .toList(),
                ),
                actions: [
                  PanelActionModel(
                      label: "Add Effect".i18n,
                      hotkeyId: "add_effect",
                      onClick: () => _addEffect(context, bloc)),
                  PanelActionModel(
                      label: "Delete".i18n,
                      hotkeyId: "delete",
                      disabled: this.effect == null,
                      onClick: () => _deleteEffect(bloc)),
                ],
                onSearch: (query) => setState(() => searchQuery = query),
              ),
            ),
            if (effect != null)
              SizedBox(
                height: GRID_4_SIZE * 5,
                  child: EffectEditor(
                effect: effect!,
                onUpdateStepValue: _onUpdateStepValue,
                onUpdateStepCubicPosition: _onUpdateStepCubicPosition,
                onFinishInteraction: (channelIndex, stepIndex) =>
                    _onUpdateEffectStep(bloc, channelIndex, stepIndex),
                onRemoveStep: (channelIndex, stepIndex) =>
                    _onRemoveEffectStep(bloc, channelIndex, stepIndex),
                onRemoveChannel: (channelIndex) => _onRemoveEffectChannel(bloc, channelIndex),
                onAddChannel: (control) => _onAddEffectChannel(bloc, control),
                onAddStep: (channelIndex, step) => _onAddEffectStep(bloc, channelIndex, step),
              ))
          ],
        );
      }),
    );
  }

  void _onUpdateStepValue(int channelIndex, int stepIndex, double y) {
    if (effect != null) {
      var effect = this.effect!.deepCopy();
      effect.channels[channelIndex].steps[stepIndex].value = CueValue(direct: y);
      setState(() {
        this.effect = effect;
      });
    }
  }

  void _onUpdateStepCubicPosition(int channelIndex, int stepIndex, bool first, double x, double y) {
    if (effect != null) {
      var effect = this.effect!.deepCopy();
      var cubic = effect.channels[channelIndex].steps[stepIndex].cubic;
      if (!first) {
        cubic = CubicControlPoint(
          c0a: x,
          c0b: y,
          c1a: cubic.c1a,
          c1b: cubic.c1b,
        );
      } else {
        cubic = CubicControlPoint(
          c0a: cubic.c0a,
          c0b: cubic.c0b,
          c1a: x,
          c1b: y,
        );
      }
      effect.channels[channelIndex].steps[stepIndex].cubic = cubic;
      setState(() {
        this.effect = effect;
      });
    }
  }

  void _onUpdateEffectStep(EffectsBloc bloc, int channelIndex, int stepIndex) {
    if (effect == null) {
      return;
    }
    var step = effect!.channels[channelIndex].steps[stepIndex];
    bloc.add(UpdateEffectStep(
        effectId: effect!.id, channelIndex: channelIndex, stepIndex: stepIndex, step: step));
  }

  void _onRemoveEffectStep(EffectsBloc bloc, int channelIndex, int stepIndex) {
    if (effect == null) {
      return;
    }
    bloc.add(
        RemoveEffectStep(effectId: effect!.id, channelIndex: channelIndex, stepIndex: stepIndex));
  }

  void _onRemoveEffectChannel(EffectsBloc bloc, int channelIndex) {
    if (effect == null) {
      return;
    }
    bloc.add(RemoveEffectChannel(effectId: effect!.id, channelIndex: channelIndex));
  }

  void _onAddEffectChannel(EffectsBloc bloc, EffectControl control) {
    if (effect == null) {
      return;
    }
    bloc.add(AddEffectChannel(effectId: effect!.id, control: control));
  }

  void _onAddEffectStep(EffectsBloc bloc, int channelIndex, EffectStep step) {
    if (effect == null) {
      return;
    }
    bloc.add(AddEffectStep(effectId: effect!.id, channelIndex: channelIndex, step: step));
  }

  void _addEffect(BuildContext context, EffectsBloc bloc) async {
    String? name = await showDialog(context: context, builder: (context) => new AddEffectDialog());
    if (name == null) {
      return;
    }
    bloc.add(AddEffect(name));
  }

  void _deleteEffect(EffectsBloc bloc) {
    bloc.add(DeleteEffect(effect!.id));
  }
}
