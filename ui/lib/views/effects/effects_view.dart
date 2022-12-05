import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/views/effects/dialogs/add_effect_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:protobuf/protobuf.dart';

import 'effect_editor.dart';

class EffectsView extends StatefulWidget {
  const EffectsView({Key? key}) : super(key: key);

  @override
  State<EffectsView> createState() => _EffectsViewState();
}

class _EffectsViewState extends State<EffectsView> {
  Effect? effect;

  @override
  Widget build(BuildContext context) {
    EffectsBloc bloc = context.read();
    return HotkeyProvider(
      hotkeySelector: (hotkeys) => hotkeys.effects,
      hotkeyMap: {
        "add_effect": () => _addEffect(context, bloc),
        "delete": () => _deleteEffect(bloc),
      },
      child: BlocBuilder<EffectsBloc, EffectState>(builder: (context, effects) {
        return Column(
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
                  PanelAction(
                      label: "Add Effect".i18n,
                      hotkeyId: "add_effect",
                      onClick: () => _addEffect(context, bloc)),
                  PanelAction(
                      label: "Delete".i18n,
                      hotkeyId: "delete",
                      disabled: this.effect == null,
                      onClick: () => _deleteEffect(bloc)),
                ],
              ),
            ),
            if (effect != null)
              Expanded(
                  child: EffectEditor(
                effect: effect!,
                onUpdateStepValue: _onUpdateStepValue,
                onUpdateStepCubicPosition: _onUpdateStepCubicPosition,
                onFinishInteraction: (channelIndex, stepIndex) => _onUpdateEffectStep(bloc, channelIndex, stepIndex),
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
    bloc.add(UpdateEffectStep(effectId: effect!.id, channelIndex: channelIndex, stepIndex: stepIndex, step: step));
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
