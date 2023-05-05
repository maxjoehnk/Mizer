import 'package:flutter/material.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/widgets/controls/icon_button.dart';

import 'panel.dart';

class Tabs extends StatefulWidget {
  final List<Tab> children;
  final List<PanelAction>? actions;
  final Function()? onAdd;
  final bool padding;
  final int? tabIndex;
  final Function(int)? onSelectTab;

  bool get canAdd {
    return onAdd != null;
  }

  Tabs({required this.children, this.actions, this.tabIndex, this.onSelectTab, this.onAdd, this.padding = true});

  @override
  _TabsState createState() => _TabsState(activeIndex: this.tabIndex ?? 0);
}

class _TabsState extends State<Tabs> {
  int activeIndex = 0;

  _TabsState({ this.activeIndex = 0 });

  @override
  void didUpdateWidget(Tabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabIndex == null || widget.tabIndex == oldWidget.tabIndex) {
      return;
    }
    setState(() {
      activeIndex = widget.tabIndex!;
    });
  }

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
                .map((i, e) =>
                MapEntry(
                    i,
                    e.header(
                      this.activeIndex == i,
                          () => _onSelectTab(i),
                    )))
                .values,
            if (widget.canAdd) AddTabButton(onClick: widget.onAdd!),
          ]),
        ),
        if (this.active != null) Expanded(child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: widget.padding ? const EdgeInsets.all(8.0) : const EdgeInsets.all(0),
                child: this.active,
              ),
            ),
            if (widget.actions != null) PanelActions(actions: widget.actions!)
          ],
        )),
      ],
    );
  }

  Widget? get active {
    if (widget.children.isEmpty) {
      return null;
    }
    return widget.children[activeIndex].child;
  }

  void _onSelectTab(int index) {
    if (widget.onSelectTab != null) {
      widget.onSelectTab!(index);
      return;
    }
    setState(() {
      this.activeIndex = index;
    });
  }
}

class Tab {
  final String? label;
  final Widget child;
  late Widget Function(bool, Function()) header;

  Tab({this.label, required this.child, Widget Function(bool, Function())? header}) {
    this.header =
        header ?? (active, setActive) => TabHeader(label!, selected: active, onSelect: setActive);
  }
}

class TabHeader extends StatelessWidget {
  final String label;
  final Function() onSelect;
  final bool selected;

  TabHeader(this.label, {required this.onSelect, this.selected = false});

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
  final Function() onClick;

  AddTabButton({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return MizerIconButton(
      icon: Icons.add,
      onClick: this.onClick,
      label: "Add Tab",
    );
  }
}
