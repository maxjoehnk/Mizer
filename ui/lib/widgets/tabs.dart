import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Tabs extends StatefulWidget {
  final List<Tab> children;

  Tabs({this.children});

  @override
  _TabsState createState() => _TabsState(this.children[0].child);
}

class _TabsState extends State<Tabs> {
  Widget active;

  _TabsState(this.active);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            children: this
                .widget
                .children
                .map((e) => TabHeader(e.label,
                    selected: this.active == e.child,
                    onSelect: () => setState(() {
                          this.active = e.child;
                        })))
                .toList()),
        this.active,
      ],
    );
  }
}

class Tab {
  final String label;
  final Widget child;

  Tab({this.label, this.child});
}

class TabHeader extends StatelessWidget {
  final String label;
  final Function onSelect;
  final bool selected;

  TabHeader(this.label, {this.onSelect, this.selected});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: this.onSelect,
        child: Container(
          color: this.selected ? Colors.grey.shade800 : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(this.label),
        ),
      ),
    );
  }
}
