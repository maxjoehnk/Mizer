import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/popup/popup_route.dart';

const double TABLE_ROW_HEIGHT = 36;

class MizerTable extends StatefulWidget {
  final List<Widget>? columns;
  final Map<int, TableColumnWidth>? columnWidths;
  final AlignmentDirectional headerAlignment;
  final SliverChildDelegate childrenDelegate;

  MizerTable(
      {this.columns,
      required List<MizerTableRow> rows,
      this.headerAlignment = AlignmentDirectional.centerStart,
      this.columnWidths,
      Key? key})
      : childrenDelegate = SliverTableRowListDelegate(rows, columnWidths),
        super(key: key);

  MizerTable.builder(
      {required MizerTableRow Function(BuildContext context, int index) itemBuilder,
      required this.columns,
      this.columnWidths,
      this.headerAlignment = AlignmentDirectional.centerStart,
      Key? key})
      : childrenDelegate = SliverTableRowChildBuilderDelegate(itemBuilder, columnWidths),
        super();

  @override
  State<MizerTable> createState() => _MizerTableState();
}

class SliverTableRowListDelegate extends SliverChildListDelegate {
  SliverTableRowListDelegate(List<MizerTableRow> rows, Map<int, TableColumnWidth>? columnWidths)
      : super(rows.map((r) => _MizerTableRow(r, columnWidths)).toList());
}

class SliverTableRowChildBuilderDelegate extends SliverChildBuilderDelegate {
  SliverTableRowChildBuilderDelegate(MizerTableRow Function(BuildContext, int) itemBuilder,
      Map<int, TableColumnWidth>? columnWidths)
      : super((context, int) => _MizerTableRow(itemBuilder(context, int), columnWidths));
}

class _MizerTableState extends State<MizerTable> {
  @override
  Widget build(BuildContext context) {
    var header = _header();

    var listView =
        ListView.custom(childrenDelegate: widget.childrenDelegate, itemExtent: TABLE_ROW_HEIGHT, );

    if (header == null) {
      return listView;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      header,
      Expanded(child: listView),
    ]);
  }

  Widget? _header() {
    if (widget.columns == null) {
      return null;
    }

    return Row(
      spacing: 1,
      children: widget.columns!.mapEnumerated(_wrapHeader).toList(),
    );
  }

  Widget _wrapHeader(Widget header, int i) {
    var cell = Container(
      padding: const EdgeInsets.all(16),
      child: Align(child: header, alignment: widget.headerAlignment),
    );

    return _tableCell(cell, widget.columnWidths?[i]);
  }
}

class _MizerTableRow extends StatelessWidget {
  final MizerTableRow row;
  final Map<int, TableColumnWidth>? columnWidths;

  _MizerTableRow(this.row, this.columnWidths);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TABLE_ROW_HEIGHT,
      child: Hoverable(
        onTap: row.onTap,
        onDoubleTap: row.onDoubleTap,
        onSecondaryTap: row.onSecondaryTap,
        builder: (hovered) => Row(
            spacing: 1,
            children: row.cells
                .mapEnumerated(
                    (cell, index) => _tableCell(_wrapCell(cell, row, isHovered: hovered), columnWidths?[index]))
                .toList()),
      ),
    );
  }

  Widget _wrapCell(Widget cell, MizerTableRow row, {bool isHovered = false}) {
    Widget cellContent = Container(
        alignment: row.alignment,
        color: row.selected
            ? Grey800
            : (isHovered ? Grey700 : (row.highlight ? Colors.deepOrange.withOpacity(0.1) : null)),
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
                  behavior: HitTestBehavior.opaque,
                  child: cellContent,
                ),
              );
    }
    return cellContent;
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
      this.padding = const EdgeInsets.symmetric(horizontal: 16)});
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

Widget _tableCell(Widget child, TableColumnWidth? width) {
  if (width is FlexColumnWidth) {
    return Flexible(child: child, flex: width.value.toInt(), fit: FlexFit.tight);
  }

  if (width is FixedColumnWidth) {
    return SizedBox(width: width.value, child: child);
  }

  return Flexible(child: child, flex: 1, fit: FlexFit.tight);
}
