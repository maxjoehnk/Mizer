import 'package:flutter/material.dart';

class MizerTable extends StatefulWidget {
  final List<Widget> columns;
  final List<MizerTableRow> rows;
  final Map<int, TableColumnWidth>? columnWidths;

  const MizerTable({required this.columns, required this.rows, this.columnWidths, Key? key}) : super(key: key);

  @override
  State<MizerTable> createState() => _MizerTableState();
}

class _MizerTableState extends State<MizerTable> {
  MizerTableRow? _hoveredRow;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [_header(), ...widget.rows.map(_mapRow)],
      columnWidths: widget.columnWidths,
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
    Widget cellContent = Container(
        alignment: Alignment.centerLeft,
        height: 48,
        color: row.selected ? Colors.white24 : (_hoveredRow == row ? Colors.white10 : null),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: cell);

    // The cell has probably interactive elements if it's not a text widget so we don't apply the tap handling
    if (cell is Text) {
      cellContent = Listener(
        onPointerUp: (_) => row.onTap!(),
        behavior: HitTestBehavior.opaque,
        child: GestureDetector(
          onDoubleTap: row.onDoubleTap,
          onSecondaryTap: row.onSecondaryTap,
          behavior: HitTestBehavior.opaque,
          child: cellContent,
        ),
      );
    }
    return MouseRegion(
        cursor: row.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onHover: (_) => setState(() => _hoveredRow = row),
        onExit: (_) => setState(() => _hoveredRow = null),
        // We use the Listener as well as the GestureDetector because the onTap event
        // of the GestureDetector has a delay when used with onDoubleTap
        child: cellContent);
  }
}

class MizerTableRow {
  final List<Widget> cells;
  final bool selected;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onSecondaryTap;

  MizerTableRow({required this.cells, this.selected = false, this.onTap, this.onDoubleTap, this.onSecondaryTap});
}
