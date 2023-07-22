import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:protobuf/protobuf.dart';

const double STEP_SIZE = 12;

class StepSequencerField extends StatefulWidget {
  final NodeSetting_StepSequencerValue value;
  final Function(NodeSetting_StepSequencerValue) onUpdate;

  const StepSequencerField({required this.value, required this.onUpdate, super.key});

  @override
  State<StepSequencerField> createState() => _StepSequencerFieldState();
}

class _StepSequencerFieldState extends State<StepSequencerField> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.value.steps
            .slices(16)
            .mapIndexed((i, bar) => Row(
                children: bar
                    .mapIndexed((j, e) => SequencerStep(
                          index: j,
                          step: e,
                          onToggle: () => _onToggle((i + 1) * j),
                        ))
                    .toList()))
            .toList());
  }

  _onToggle(int i) {
    var value = widget.value.deepCopy();
    value.steps[i] = !value.steps[i];
    widget.onUpdate(value);
  }
}

class SequencerStep extends StatelessWidget {
  final int index;
  final bool step;
  final Function() onToggle;

  const SequencerStep({required this.step, super.key, required this.onToggle, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index < 4 || (index >= 8 && index < 12) ? Colors.grey.shade800 : Colors.grey.shade900,
      child: Hoverable(
          onTap: onToggle,
          builder: (hovered) => Container(
                width: STEP_SIZE,
                height: STEP_SIZE,
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  color: step
                      ? Colors.grey.shade500
                      : hovered
                          ? Colors.grey.shade600
                          : Colors.transparent,
                ),
              )),
    );
  }
}
