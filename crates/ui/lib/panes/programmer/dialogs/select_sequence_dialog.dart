import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/tile.dart';

const double MAX_DIALOG_WIDTH = 512;
const double MAX_DIALOG_HEIGHT = 512;
const double TILE_SIZE = 96;

class SelectSequenceDialog extends StatelessWidget {
  final SequencerApi api;

  const SelectSequenceDialog({required this.api, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Sequence",
      onConfirm: () => _newSequence(context),
      content: Container(
        width: MAX_DIALOG_WIDTH,
        height: MAX_DIALOG_HEIGHT,
        child: FutureBuilder(
            future: api.getSequences(),
            builder: (context, AsyncSnapshot<Sequences> data) {
              List<Sequence> sequences = data.hasData ? data.data!.sequences : [];
              sequences.sort((lhs, rhs) => lhs.id - rhs.id);

              return GridView.count(
                  crossAxisCount: (MAX_DIALOG_WIDTH / TILE_SIZE).floor(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: sequences
                      .map((s) => Tile(
                            title: s.id.toString(),
                            child: Center(child: Text(s.name)),
                            onClick: () => Navigator.of(context).pop(s),
                          ))
                      .toList());
            }),
      ),
      actions: [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
        PopupAction("New Sequence", () => _newSequence(context))
      ],
    );
  }

  _newSequence(BuildContext context) async {
    var sequence = await api.addSequence();
    Navigator.of(context).pop(sequence);
  }
}
