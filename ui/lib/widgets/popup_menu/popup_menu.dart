import 'package:flutter/material.dart';
import 'package:mizer/widgets/controls/button.dart';

const MAX_ROWS = 15;
const double COLUMN_WIDTH = 150;
const double ROW_HEIGHT = 26;

class PopupItem<T> {
  final String label;
  final T value;

  PopupItem(this.value, this.label);
}

class PopupCategory<T> {
  final String label;
  final List<PopupItem<T>> items;

  PopupCategory({this.label, this.items});
}

class PopupMenu<T> extends StatefulWidget {
  final List<PopupCategory<T>> categories;
  final Function(T) onSelect;

  PopupMenu({this.categories, this.onSelect});

  @override
  State<PopupMenu<T>> createState() => _PopupMenuState<T>(categories.first);
}

class _PopupMenuState<T> extends State<PopupMenu<T>> {
  PopupCategory<T> selected;

  _PopupMenuState(this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.all(Radius.circular(2)),
            boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4)]),
        child: Column(children: [
          Row(
              children: widget.categories
                  .map((c) => MizerButton(
                      active: c == selected,
                      onClick: () => setState(() => selected = c),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(c.label),
                      )))
                  .toList()),
          Table(
            defaultColumnWidth: FixedColumnWidth(COLUMN_WIDTH),
            children: mapNodeEntries(selected.items),
          )
        ]));
  }

  List<TableRow> mapNodeEntries(List<PopupItem<T>> items) {
    List<Widget> widgets = buildWidgets(items);
    List<List<Widget>> columns = buildColumns(widgets);
    List<TableRow> rows = [];
    int rowIndex = 0;

    for (var _ in columns[0]) {
      var row = TableRow(
          children: columns.map((column) {
            if (rowIndex >= column.length) {
              return Container();
            }
            return column[rowIndex];
          }).toList());
      rows.add(row);
      rowIndex++;
    }

    return rows;
  }

  List<List<Widget>> buildColumns(List<Widget> widgets) {
    List<List<Widget>> columns = [];
    var i = 0;
    List<Widget> column = [];
    for (var widget in widgets) {
      column.add(widget);
      i++;
      if (i % MAX_ROWS == 0) {
        columns.add(column);
        column = [];
      }
    }
    if (column.length > 0) {
      columns.add(column);
    }

    return columns;
  }

  List<Widget> buildWidgets(List<PopupItem<T>> items) {
    List<Widget> widgets = [];
    for (var item in items) {
      widgets.add(PopupItemButton(item.label, onTap: () {
        widget.onSelect(item.value);
        Navigator.pop(context);
      }));
    }
    return widgets;
  }
}

class PopupItemButton extends StatefulWidget {
  final String text;
  final Function() onTap;

  PopupItemButton(this.text, {this.onTap});

  @override
  _PopupItemButtonState createState() => _PopupItemButtonState();
}

class _PopupItemButtonState extends State<PopupItemButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.widget.onTap,
        onHover: (isHovering) {
          setState(() => hover = isHovering);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(color: hover ? Colors.black12 : Colors.transparent),
            height: ROW_HEIGHT,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(this.widget.text)));
  }
}
