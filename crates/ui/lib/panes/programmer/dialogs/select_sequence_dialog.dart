import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';

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
      padding: false,
      content: Container(
        width: MAX_DIALOG_WIDTH,
        height: MAX_DIALOG_HEIGHT,
        child: FutureBuilder(
            future: api.getSequences(),
            builder: (context, AsyncSnapshot<Sequences> data) {
              List<Sequence> sequences = data.hasData ? data.data!.sequences : [];
              sequences.sort((lhs, rhs) => lhs.id - rhs.id);

              return PanelGrid(children: sequences
                      .map((s) => PanelGridTile.idWithText(
                            id: s.id.toString(),
                            text: s.name,
                            onTap: () => Navigator.of(context).pop(s),
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
