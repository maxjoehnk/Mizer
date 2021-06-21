import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/widgets/controls/icon_button.dart';

class Tabs extends StatefulWidget {
  final List<Tab> children;
  final Function onAdd;

  bool get canAdd {
    return onAdd != null;
  }

  Tabs({this.children, this.onAdd});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int activeIndex = 0;

  _TabsState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey.shade800,
          height: 32,
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ...this
                .widget
                .children
                .asMap()
                .map((i, e) => MapEntry(
                    i,
                    TabHeader(e.label,
                        selected: this.activeIndex == i,
                        onSelect: () => setState(() {
                              this.activeIndex = i;
                            }))))
                .values,
            if (widget.canAdd) AddTabButton(onClick: widget.onAdd),
          ]),
        ),
        if (this.active != null) this.active,
      ],
    );
  }

  Widget get active {
    return widget.children[activeIndex]?.child;
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
    return MizerButton(
      active: selected,
      onClick: onSelect,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(this.label),
      ),
    );
  }
}

class AddTabButton extends StatelessWidget {
  final Function onClick;

  AddTabButton({this.onClick});

  @override
  Widget build(BuildContext context) {
    return MizerIconButton(icon: Icons.add, onClick: this.onClick);
  }
}
