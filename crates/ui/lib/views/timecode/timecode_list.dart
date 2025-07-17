import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/plugin/ffi/timecode.dart';
import 'package:mizer/api/plugin/ffi/transport.dart';
import 'package:mizer/dialogs/name_dialog.dart';
import 'package:mizer/protos/timecode.pb.dart';
import 'package:mizer/shell/transport/time_control.dart';
import 'package:mizer/state/timecode_bloc.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';
import 'package:provider/provider.dart';

class TimecodeList extends StatelessWidget {
  final List<Timecode> timecodes;
  final Function(Timecode) onSelect;
  final Timecode? selectedTimecode;
  final TimecodePointer? timecodePointer;

  TimecodeList(
      {required this.timecodes,
      required this.onSelect,
      this.selectedTimecode,
      Key? key,
      this.timecodePointer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
        label: "Timecodes",
        actions: [
          PanelActionModel(label: "Add Timecode", onClick: () => _addTimecode(context)),
          PanelActionModel(
              label: "Delete",
              disabled: selectedTimecode == null,
              onClick: () => _deleteTimecode(context))
        ],
        child: PanelGrid(
            children: timecodes
                .map((t) => TimecodePane(
                    timecode: t,
                    selected: t.id == selectedTimecode?.id,
                    onSelect: () => onSelect(t),
                    reader: timecodePointer?.getTrackReader(t.id)))
                .toList()));
  }

  Future<void> _addTimecode(BuildContext context) async {
    String? name = await context.showRenameDialog();
    if (name == null) {
      return;
    }
    TimecodeBloc bloc = context.read();
    bloc.addTimecode(name);
  }

  void _deleteTimecode(BuildContext context) {
    TimecodeBloc bloc = context.read();
    bloc.deleteTimecode(selectedTimecode!.id);
  }
}

class TimecodePane extends StatelessWidget {
  final Timecode timecode;
  final bool selected;
  final Function() onSelect;
  final TimecodeReader? reader;

  TimecodePane(
      {required this.timecode,
      required this.selected,
      required this.onSelect,
      Key? key,
      this.reader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;

    return PanelGridTile(
      onSecondaryTapDown: (details) => context.showRenameDialog(name: timecode.name).then((name) {
        if (name != null) {
          _renameTimecode(context, name);
        }
      }),
      onTap: onSelect,
      selected: selected,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(timecode.id.toString(), textAlign: TextAlign.start),
        AutoSizeText(timecode.name, textAlign: TextAlign.center, maxLines: 2),
        if (reader != null)
          FFITimeControl(
            pointer: reader!,
            textStyle: style.bodyMedium,
          ),
      ])
    );
  }

  void _renameTimecode(BuildContext context, String name) {
    TimecodeBloc bloc = context.read();
    bloc.renameTimecode(timecode.id, name);
  }
}
