import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'frame_editor.dart';
import 'movement_editor.dart';

class EffectEditor extends StatelessWidget {
  final Effect effect;
  final Function(int, int, double) onUpdateStepValue;
  final Function(int, int, bool, double, double) onUpdateStepCubicPosition;
  final Function(int, int) onFinishInteraction;
  final Function(int, int) onRemoveStep;
  final Function(int) onRemoveChannel;
  final Function(FixtureFaderControl) onAddChannel;

  const EffectEditor(
      {Key? key,
        required this.effect,
        required this.onUpdateStepValue,
        required this.onUpdateStepCubicPosition,
        required this.onFinishInteraction,
        required this.onRemoveStep,
        required this.onRemoveChannel,
        required this.onAddChannel,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            height: 332,
            child: MovementEditor(effect: effect),
          ),
          Expanded(
              child: FrameEditor(
                  effect: effect,
                  onUpdateStepValue: onUpdateStepValue,
                  onUpdateStepCubicPosition: onUpdateStepCubicPosition,
                  onFinishInteraction: onFinishInteraction,
                  onRemoveStep: onRemoveStep,
                  onRemoveChannel: onRemoveChannel,
                  onAddChannel: onAddChannel))
        ]);
  }
}
