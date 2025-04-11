import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/views/ports/port_name.dart';
import 'package:mizer/widgets/popup/popup_value_input.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

class PortsSheet extends StatefulWidget {
  final Sequence sequence;
  final int? activeCue;

  const PortsSheet({super.key, required this.sequence, this.activeCue});

  @override
  State<PortsSheet> createState() => _PortsSheetState();
}

class _PortsSheetState extends State<PortsSheet> {
  final _horizontalScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    var columnWidths = {
      0: FixedColumnWidth(75),
    };
    for (var i = 1; i <= widget.sequence.ports.length; i++) {
      columnWidths[i] = FixedColumnWidth(50);
    }

    return Scrollbar(
        controller: _horizontalScroll,
        child: SingleChildScrollView(
          controller: _horizontalScroll,
          child: MizerTable(
            columnWidths: columnWidths,
            columns: [
              Text("Cue"),
              ...widget.sequence.ports.map((portId) => PortName(portId: portId)),
            ],
            rows: _buildRows(context),
          ),
        ));
  }

  List<MizerTableRow> _buildRows(BuildContext context) {
    List<MizerTableRow> rows = [];
    for (var cue in widget.sequence.cues) {
      List<Widget> cells = [
        Text(cue.name),
      ];
      for (var port in widget.sequence.ports) {
        var cuePort = cue.ports.firstWhereOrNull((cuePort) => cuePort.portId == port);
        if (cuePort == null) {
          cells.add(PopupTableCell(
              child: Text("-"),
              popup: PopupValueInput(onEnter: (value) => _setPortValue(cue, port, value))));
          continue;
        }
        cells.add(PopupTableCell(
            child: Text("${cuePort.value}"),
            popup: PopupValueInput(
                value: CueValue(direct: cuePort.value),
                onEnter: (value) => _setPortValue(cue, port, value))));
      }
      rows.add(MizerTableRow(cells: cells));
    }
    return rows;
  }

  void _setPortValue(Cue cue, int portId, CueValue? value) {
    if (value == null) {
      context
          .read<SequencerBloc>()
          .add(ClearPortValue(sequenceId: widget.sequence.id, cueId: cue.id, portId: portId));
    } else {
      context.read<SequencerBloc>().add(SetPortValue(
          sequenceId: widget.sequence.id, cueId: cue.id, portId: portId, value: value.direct));
    }

    setState(() {});
  }
}
