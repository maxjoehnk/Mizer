import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/popup/popup_route.dart';

const double TABLE_ROW_HEIGHT = 36;

class MizerTable extends StatefulWidget {
  final List<Widget>? columns;
  final List<MizerTableRow> rows;
  final Map<int, TableColumnWidth>? columnWidths;
  final AlignmentDirectional headerAlignment;

  const MizerTable({this.columns, required this.rows, this.headerAlignment = AlignmentDirectional.centerStart, this.columnWidths, Key? key})
      : super(key: key);

  @override
  State<MizerTable> createState() => _MizerTableState();
}

class _MizerTableState extends State<MizerTable> {
  MizerTableRow? _hoveredRow;

  @override
  Widget build(BuildContext context) {
    var header = _header();
    return Table(
      children: [if (header != null) header, ...widget.rows.map(_mapRow)],
      columnWidths: widget.columnWidths,
      border: TableBorder.all(color: Grey900),
    );
  }

  TableRow? _header() {
    if (widget.columns == null) {
      return null;
    }
    return TableRow(
      children: widget.columns!.map(_wrapHeader).toList(),
    );
  }

  Widget _wrapHeader(Widget header) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Align(child: header, alignment: widget.headerAlignment),
    );
  }

  TableRow _mapRow(MizerTableRow row) {
    return TableRow(
        children: row.cells.map((cell) => _wrapCell(cell, row)).toList(),
    );
  }

  Widget _wrapCell(Widget cell, MizerTableRow row) {
    Widget cellContent = Container(
        alignment: row.alignment,
        height: TABLE_ROW_HEIGHT,
        color: row.selected
            ? Grey800
            : (_hoveredRow == row
                ? Grey700
                : (row.highlight ? Colors.deepOrange.withOpacity(0.1) : null)),
        padding: row.padding,
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
  final bool inactive;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onSecondaryTap;
  final Alignment alignment;
  final EdgeInsets padding;

  MizerTableRow(
      {required this.cells,
      this.selected = false,
      this.highlight = false,
      this.inactive = false,
      this.onTap,
      this.onDoubleTap,
      this.onSecondaryTap,
      this.alignment = Alignment.centerLeft,
      this.padding = const EdgeInsets.symmetric(horizontal: 16)
      });
}

class PopupTableCell extends StatelessWidget {
  final Widget child;
  final Widget popup;
  final Function()? onTap;

  PopupTableCell({required this.child, required this.popup, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onSecondaryTapDown: (details) => Navigator.of(context)
          .push(MizerPopupRoute(position: details.globalPosition, child: popup)),
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        child: child,
        constraints: BoxConstraints.expand(),
      ),
    );
  }
}
