import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/dialogs/name_dialog.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/patch/dialogs/group_store_mode_dialog.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';
import 'package:provider/provider.dart';

const double MAX_DIALOG_HEIGHT = 512;

class AssignFixturesToGroupDialog extends StatefulWidget {
  final PresetsBloc bloc;
  final ProgrammerApi api;

  static Future<AssignFixturesDialogResult?> open(BuildContext context) async {
    var programmerApi = context.read<ProgrammerApi>();
    var presetsBloc = context.read<PresetsBloc>();
    _InternalDialogResult? result = await showDialog(
        context: context,
        builder: (context) => AssignFixturesToGroupDialog(presetsBloc, programmerApi));

    if (result == null) {
      return null;
    }

    StoreGroupMode? mode;
    if (result.newGroup) {
      mode = StoreGroupMode.STORE_GROUP_MODE_OVERWRITE;
    } else {
      mode = await _getStoreMode(context);
    }
    if (mode == null) {
      return null;
    }

    return AssignFixturesDialogResult(result.group, mode);
  }

  static _getStoreMode(BuildContext context) async {
    return await showDialog(context: context, builder: (context) => GroupStoreModeDialog());
  }

  const AssignFixturesToGroupDialog(this.bloc, this.api, {Key? key}) : super(key: key);

  @override
  State<AssignFixturesToGroupDialog> createState() => _AssignFixturesToGroupDialogState();
}

class _AssignFixturesToGroupDialogState extends State<AssignFixturesToGroupDialog> {
  bool _creating = false;

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Group",
      onConfirm: _creating ? null : () => _newGroup(context),
      padding: false,
      content: Container(
          width: MAX_TILE_DIALOG_WIDTH,
          height: MAX_DIALOG_HEIGHT,
          margin: const EdgeInsets.only(bottom: GRID_GAP_SIZE),
          child: SingleChildScrollView(
            child: PanelGrid(
                children: widget.bloc.state.groups
                    .map((g) => PanelGridTile.idWithText(
                          id: "G${g.id}",
                          text: g.name,
                          onTap: () => Navigator.of(context).pop(_InternalDialogResult(g)),
                        ))
                    .toList()),
          )),
      actions: [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
        PopupAction("New Group", () => _newGroup(context))
      ],
    );
  }

  _newGroup(BuildContext context) async {
    setState(() => _creating = true);
    String? name = await context.showNameDialog();
    setState(() => _creating = false);
    if (name == null) {
      return;
    }
    var group = await widget.api.addGroup(name);
    widget.bloc.add(AddGroup(group));
    Navigator.of(context).pop(_InternalDialogResult(group, newGroup: true));
  }
}

class _InternalDialogResult {
  final Group group;
  final bool newGroup;

  _InternalDialogResult(this.group, {this.newGroup = false});
}

class AssignFixturesDialogResult {
  final Group group;
  final StoreGroupMode mode;

  AssignFixturesDialogResult(this.group, this.mode);
}
