import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';
import 'package:mizer/i18n.dart';

class SelectSequenceDialog extends StatelessWidget {
  final SequencerApi api;

  const SelectSequenceDialog({required this.api, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Sequence".i18n,
      onConfirm: () => _newSequence(context),
      padding: false,
      content: Container(
        width: MAX_TILE_DIALOG_WIDTH,
        height: MAX_DIALOG_HEIGHT,
        child: SingleChildScrollView(
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
      ),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("New Sequence".i18n, () => _newSequence(context))
      ],
    );
  }

  _newSequence(BuildContext context) async {
    var sequence = await api.addSequence();
    Navigator.of(context).pop(sequence);
  }
}
