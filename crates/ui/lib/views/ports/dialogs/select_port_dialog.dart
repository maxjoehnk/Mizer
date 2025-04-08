import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/ports.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/dialogs/name_dialog.dart';
import 'package:mizer/protos/ports.pb.dart';
import 'package:mizer/state/ports_bloc.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';
import 'package:provider/provider.dart';

const double MAX_DIALOG_HEIGHT = 512;

class SelectPortDialog extends StatefulWidget {
  final PortsBloc bloc;
  final PortsApi api;

  static Future<NodePort?> open(BuildContext context) async {
    var portsBloc = context.read<PortsBloc>();
    var portsApi = context.read<PortsApi>();
    NodePort? result = await showDialog(
        context: context,
        builder: (context) => SelectPortDialog(portsBloc, portsApi));

    return result;
  }

  const SelectPortDialog(this.bloc, this.api, {Key? key}) : super(key: key);

  @override
  State<SelectPortDialog> createState() => _SelectPortDialogState();
}

class _SelectPortDialogState extends State<SelectPortDialog> {
  bool _creating = false;

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Select Port",
      onConfirm: _creating ? null : () => _newPort(context),
      padding: false,
      content: Container(
          width: MAX_TILE_DIALOG_WIDTH,
          height: MAX_DIALOG_HEIGHT,
          child: PanelGrid(
              children: widget.bloc.state.ports
                  .map((port) => PanelGridTile.idWithText(
                        id: port.id.toString(),
                        text: port.name,
                        onTap: () => Navigator.of(context).pop(port),
                      ))
                  .toList())),
      actions: [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
        PopupAction("New Port", () => _newPort(context))
      ],
    );
  }

  _newPort(BuildContext context) async {
    setState(() => _creating = true);
    String? name = await context.showNameDialog();
    if (name == null) {
      setState(() => _creating = false);
      return;
    }
    var port = await widget.api.addPort(name: name);
    widget.bloc.add(FetchPorts());
    Navigator.of(context).pop(port);
  }
}
