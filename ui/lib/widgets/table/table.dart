import 'package:flutter/material.dart';
import 'package:mizer/widgets/popup/popup_route.dart';

const double TABLE_ROW_HEIGHT = 36;

class MizerTable extends StatefulWidget {
  final List<Widget> columns;
  final List<MizerTableRow> rows;
  final Map<int, TableColumnWidth>? columnWidths;

  const MizerTable({required this.columns, required this.rows, this.columnWidths, Key? key})
      : super(key: key);

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
        height: TABLE_ROW_HEIGHT,
        color: row.selected ? Colors.white24 : (_hoveredRow == row ? Colors.white10 : (row.highlight
            ? Colors.deepOrange.withOpacity(0.1)
            : null)),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: cell);

    // The cell has probably interactive elements if it's not a text widget so we don't apply the tap handling
    if (cell is Text) {
      // We use the Listener as well as the GestureDetector because the onTap event
      // of the GestureDetector has a delay when used with onDoubleTap
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
        onHover: row.onTap != null ? (_) => setState(() => _hoveredRow = row) : null,
        onExit: row.onTap != null ? (_) => setState(() => _hoveredRow = null) : null,
        child: cellContent);
  }
}

class MizerTableRow {
  final List<Widget> cells;
  final bool selected;
  final bool highlight;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onSecondaryTap;

  MizerTableRow(
      {required this.cells, this.selected = false, this.highlight = false, this.onTap, this.onDoubleTap, this.onSecondaryTap});
}

class PopupTableCell extends StatelessWidget {
  final Widget child;
  final Widget popup;
  final Function()? onTap;

  PopupTableCell({ required this.child, required this.popup, this.onTap });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onSecondaryTapDown: (details) => Navigator.of(context).push(MizerPopupRoute(
              position: details.globalPosition,
              child: popup
          )),
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        child: child,
        constraints: BoxConstraints.expand(),
      ),
    );
  }
}
