import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/available_nodes.dart';

// Selector to add new nodes, might need a better name

class NodeSelectionContainer extends StatefulWidget {
  final Widget child;
  final Function(Node_NodeType, Offset) onSelectNewNode;

  NodeSelectionContainer({this.child, this.onSelectNewNode});

  @override
  _NodeSelectionContainerState createState() => _NodeSelectionContainerState();
}

class _NodeSelectionContainerState extends State<NodeSelectionContainer> {
  bool active = false;
  Offset position;

  @override
  Widget build(BuildContext context) {
    var children = [Container(color: Colors.transparent), this.widget.child];
    if (active) {
      children.add(NodeSelection(position, onSelection: (nodeType) {
        setState(() {
          this.active = false;
        });
        this.widget.onSelectNewNode(nodeType, position);
      }));
    }
    return GestureDetector(
        onSecondaryTapUp: (event) {
          setState(() {
            active = true;
            position = event.localPosition;
          });
        },
        onTap: () {
          setState(() {
            active = false;
          });
        },
        child: Stack(
          children: children,
          clipBehavior: Clip.none,
        ));
  }
}

const MAX_ROWS = 15;
const double COLUMN_WIDTH = 150;

class NodeSelection extends StatelessWidget {
  final Offset offset;
  final Function(Node_NodeType) onSelection;

  NodeSelection(this.offset, { this.onSelection });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(2, 2), blurRadius: 4)
              ]),
          child: Table(
              defaultColumnWidth: FixedColumnWidth(COLUMN_WIDTH),
              children: mapNodeEntries(NODES))),
    );
  }

  List<TableRow> mapNodeEntries(List<NodeCategoryData> categories) {
    List<Widget> widgets = buildWidgets(categories);
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

  List<Widget> buildWidgets(List<NodeCategoryData> categories) {
    List<Widget> widgets = [];
    for (var category in categories) {
      widgets.add(NodeCategory(category.text));
      for (var node in category.nodes) {
        widgets.add(
            NodeEntry(node.text, onTap: () => this.onSelection(node.nodeType)));
      }
    }
    return widgets;
  }
}

const double ROW_HEIGHT = 26;

class NodeCategory extends StatelessWidget {
  final String text;

  NodeCategory(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        color: Colors.black26,
        height: ROW_HEIGHT,
        child: Text(this.text,
            style: TextStyle(
                color: Colors.white.withOpacity(0.87), fontSize: 12)));
  }
}

class NodeEntry extends StatefulWidget {
  final String text;
  final Function() onTap;

  NodeEntry(this.text, { this.onTap });

  @override
  _NodeEntryState createState() => _NodeEntryState();
}

class _NodeEntryState extends State<NodeEntry> {
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
            decoration: BoxDecoration(
                color: hover ? Colors.black12 : Colors.transparent),
            height: ROW_HEIGHT,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(this.widget.text)));
  }
}
