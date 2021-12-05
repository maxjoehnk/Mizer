import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/inputs/decoration.dart';
import 'package:provider/provider.dart';

class SequencerControl extends StatelessWidget {
  final String label;
  final Color? color;
  final Node node;

  const SequencerControl({required this.label, this.color, required this.node, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sequencerApi = context.read<SequencerApi>();

    return FutureBuilder<Sequence>(
      future: sequencerApi.getSequence(node.config.sequencerConfig.sequenceId),
      builder: (context, state) {
        return Container(
          decoration: ControlDecoration(color: color),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _sequenceGo(sequencerApi),
              child: Container(
                child: Text(state.data?.name ?? "")
              ),
            ),
          ),
        );
      }
    );
  }

  void _sequenceGo(SequencerApi sequencerApi) {
    sequencerApi.sequenceGo(node.config.sequencerConfig.sequenceId);
  }
}
