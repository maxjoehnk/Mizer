import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';

class SelectCueDialog extends StatelessWidget {
  final Sequence sequence;

  const SelectCueDialog(this.sequence, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Cue",
      content: Container(
        width: MAX_TILE_DIALOG_WIDTH,
        height: MAX_DIALOG_HEIGHT,
        child: PanelGrid(
            children: sequence.cues
                .map((cue) => PanelGridTile.idWithText(
                    id: cue.id.toString(),
                    text: cue.name,
                    onTap: () => Navigator.of(context).pop(cue)))
                .toList()),
      ),
      actions: [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
      ],
    );
  }
}
