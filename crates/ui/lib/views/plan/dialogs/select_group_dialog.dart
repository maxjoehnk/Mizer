import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/views/plan/dialogs/name_group_dialog.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/tile.dart';

const double MAX_DIALOG_WIDTH = 512;
const double MAX_DIALOG_HEIGHT = 512;
const double TILE_SIZE = 96;

class SelectGroupDialog extends StatelessWidget {
  final ProgrammerApi api;

  const SelectGroupDialog({required this.api, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Group",
      content: Container(
        width: MAX_DIALOG_WIDTH,
        height: MAX_DIALOG_HEIGHT,
        child: FutureBuilder(
            future: api.getGroups(),
            builder: (context, AsyncSnapshot<Groups> data) {
              List<Group> groups = data.hasData ? data.data!.groups : [];
              groups.sort((lhs, rhs) => lhs.id - rhs.id);

              return GridView.count(
                  crossAxisCount: (MAX_DIALOG_WIDTH / TILE_SIZE).floor(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    ...groups.map((s) => Tile(
                          title: s.id.toString(),
                          child: Center(child: Text(s.name)),
                          onClick: () => Navigator.of(context).pop(s),
                        )),
                    Tile(
                      child: Icon(Icons.add),
                      onClick: () => _addGroup(context),
                    )
                  ]);
            }),
      ),
      actions: [PopupAction("Cancel", () => Navigator.of(context).pop())],
    );
  }

  Future<void> _addGroup(BuildContext context) async {
    var name = await showDialog(context: context, builder: (context) => NameGroupDialog());
    if (name == null) {
      return;
    }
    var group = await api.addGroup(name);
    Navigator.of(context).pop(group);
  }
}
