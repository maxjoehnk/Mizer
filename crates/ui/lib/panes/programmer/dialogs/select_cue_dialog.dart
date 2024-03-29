import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/tile.dart';

const double MAX_DIALOG_WIDTH = 512;
const double MAX_DIALOG_HEIGHT = 512;
const double TILE_SIZE = 96;

class SelectCueDialog extends StatelessWidget {
  final Sequence sequence;

  const SelectCueDialog(this.sequence, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Cue",
      content: Container(
        width: MAX_DIALOG_WIDTH,
        height: MAX_DIALOG_HEIGHT,
        child: GridView.count(
            crossAxisCount: (MAX_DIALOG_WIDTH / TILE_SIZE).floor(),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: sequence.cues
                .map((cue) => Tile(
                    title: cue.id.toString(),
                    child: Center(child: Text(cue.name)),
                    onClick: () => Navigator.of(context).pop(cue)))
                .toList()),
      ),
      actions: [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
      ],
    );
  }
}
