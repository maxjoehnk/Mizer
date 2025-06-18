import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

class HistoryView extends StatefulWidget {
  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return HotkeyConfiguration(
      hotkeySelector: (hotkeys) => hotkeys.global,
      hotkeyMap: {
        "undo": () => _undo(),
        "redo": () => _redo(),
      },
      child: StreamBuilder<History>(
          stream: context.read<SessionApi>().getHistory(),
          builder: (context, state) {
            int pointer = state.data?.pointer.toInt() ?? 0;
            int lastItem = state.data?.items.length ?? 0;

            return Panel(
              label: "History",
              child: MizerTable(
                columns: [Text("Label"), Text("Timestamp")],
                rows: (state.data?.items ?? [])
                    .mapEnumerated((item, i) {
                      var inactive = (i + 1) > pointer;

                      var textStyle = inactive ? TextStyle(color: Colors.white24) : null;
                      return MizerTableRow(cells: [
                        Text(item.label, style: textStyle),
                        Text(
                            DateTime.fromMillisecondsSinceEpoch(item.timestamp.toInt())
                                .toString(),
                            style: textStyle)
                      ]);
                    })
                    .reversed
                    .toList(),
              ),
              actions: [
                PanelActionModel(
                    label: "Undo", hotkeyId: "undo", onClick: _undo, disabled: pointer == 0),
                PanelActionModel(
                    label: "Redo", hotkeyId: "redo", onClick: _redo, disabled: pointer >= lastItem),
              ],
            );
          }),
    );
  }

  _undo() async {
    await context.read<SessionApi>().undo();
  }

  _redo() async {
    await context.read<SessionApi>().redo();
  }
}
