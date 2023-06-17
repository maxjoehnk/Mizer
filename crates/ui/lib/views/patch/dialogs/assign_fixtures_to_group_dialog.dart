import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/patch/dialogs/group_name_dialog.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/tile.dart';

const double MAX_DIALOG_WIDTH = 512;
const double MAX_DIALOG_HEIGHT = 512;
const double TILE_SIZE = 96;

class AssignFixturesToGroupDialog extends StatelessWidget {
  final PresetsBloc bloc;
  final ProgrammerApi api;

  const AssignFixturesToGroupDialog(this.bloc, this.api, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Group",
      content: Container(
          width: MAX_DIALOG_WIDTH,
          height: MAX_DIALOG_HEIGHT,
          child: GridView.count(
              crossAxisCount: (MAX_DIALOG_WIDTH / TILE_SIZE).floor(),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                ...bloc.state.groups.map((g) => Tile(
                      title: g.id.toString(),
                      child: Center(child: Text(g.name)),
                      onClick: () => Navigator.of(context).pop(g),
                    )),
                Tile(
                  child: Icon(Icons.add),
                  onClick: () async {
                    String? name =
                        await showDialog(context: context, builder: (context) => GroupNameDialog());
                    if (name == null) {
                      return;
                    }
                    var group = await api.addGroup(name);
                    bloc.add(AddGroup(group));
                    Navigator.of(context).pop(group);
                  },
                )
              ])),
      actions: [PopupAction("Cancel", () => Navigator.of(context).pop())],
    );
  }
}
