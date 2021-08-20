import 'package:flutter/material.dart';

class MizerTable extends StatefulWidget {
  final List<Widget> columns;
  final List<MizerTableRow> rows;

  const MizerTable({this.columns, this.rows, Key key}) : super(key: key);

  @override
  State<MizerTable> createState() => _MizerTableState();
}

class _MizerTableState extends State<MizerTable> {
  MizerTableRow _hoveredRow;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [_header(), ...widget.rows.map(_mapRow)],
    );
  }

  TableRow _header() {
    return TableRow(
      children: widget.columns.map(_wrapHeader).toList(),
    );
  }

  Widget _wrapHeader(Widget header) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: header,
    );
  }

  TableRow _mapRow(MizerTableRow row) {
    return TableRow(
        children: row.cells.map((cell) => _wrapCell(cell, row)).toList(),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white10))));
  }

  Widget _wrapCell(Widget cell, MizerTableRow row) {
    return MouseRegion(
        cursor: row.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onHover: (_) => setState(() => _hoveredRow = row),
        onExit: (_) => setState(() => _hoveredRow = null),
        // We use the Listener as well as the GestureDetector because the onTap event
        // of the GestureDetector has a delay when used with onDoubleTap
        child: Listener(
          onPointerUp: (_) => row.onTap(),
          child: GestureDetector(
            onDoubleTap: row.onDoubleTap,
            onSecondaryTap: row.onSecondaryTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
                color: row.selected ? Colors.white24 : (_hoveredRow == row ? Colors.white10 : null),
                padding: const EdgeInsets.all(16),
                child: cell),
          ),
        ));
  }
}

class MizerTableRow {
  final List<Widget> cells;
  final bool selected;
  final Function() onTap;
  final Function() onDoubleTap;
  final Function() onSecondaryTap;

  MizerTableRow({this.cells, this.selected, this.onTap, this.onDoubleTap, this.onSecondaryTap});
}
