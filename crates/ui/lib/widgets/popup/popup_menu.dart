import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/widgets/hoverable.dart';

const MAX_ROWS = 10;
const double COLUMN_WIDTH = 175;
const double ROW_HEIGHT = 26;

class PopupItem<T> {
  final String label;
  final T value;
  final String? description;

  const PopupItem(this.value, this.label, {this.description});
}

class PopupCategory<T> {
  final String label;
  final List<PopupItem<T>> items;

  const PopupCategory({required this.label, required this.items});
}

class PopupMenu<T> extends StatefulWidget {
  final List<PopupCategory<T>> categories;
  final Function(T) onSelect;

  PopupMenu({required this.categories, required this.onSelect});

  @override
  State<PopupMenu<T>> createState() => _PopupMenuState<T>(categories.first);
}

class _PopupMenuState<T> extends State<PopupMenu<T>> {
  PopupCategory<T> selected;
  PopupItem<T>? hovered;
  TextEditingController _searchController = TextEditingController();

  _PopupMenuState(this.selected) {
    _searchController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      debugLabel: "PopupMenu",
      autofocus: true,
      child: Container(
          constraints: BoxConstraints(maxHeight: 300, maxWidth: 450),
          decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4)]),
          child: Column(
            children: [
              Container(
                height: 40,
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                ),
              ),
              Expanded(
                child: _searchController.text.isEmpty
                    ? categoryView()
                    : searchView(_searchController.text),
              ),
            ],
          )),
    );
  }

  Widget categoryView() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: Column(
                children: widget.categories
                    .map((c) => Hoverable(
                        builder: (bool hovered) {
                          var active = c == selected;
                          return Container(
                              width: 140,
                              padding: const EdgeInsets.all(4),
                              color: hovered ? Colors.white24 : (active ? Colors.white10 : null),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(child: Text(c.label)),
                                  Icon(Icons.arrow_right, size: 12),
                                ],
                              ));
                        },
                        onTap: () => setState(() => selected = c)))
                    .toList()),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300, minWidth: 150, maxWidth: 150),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildWidgets(selected.items),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300, minWidth: 150, maxWidth: 150),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: hovered?.description != null
                        ? [Text(hovered!.description!, style: TextStyle(color: Colors.white70))]
                        : []),
              ),
            ),
          ),
        ]);
  }

  Widget searchView(String text) {
    var items =
        widget.categories.map((e) => e.items).flattened.search([(item) => item.label], text);
    return Container(
      constraints: BoxConstraints(maxHeight: 300, minWidth: 150, maxWidth: 300),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buildWidgets(items),
        ),
      ),
    );
  }

  List<Widget> buildWidgets(Iterable<PopupItem<T>> items) {
    return items
        .sortedBy((item) => item.label)
        .map((item) => PopupItemButton(item.label,
            onTap: () {
              widget.onSelect(item.value);
              Navigator.pop(context);
            },
            onEnter: () => setState(() => hovered = item)))
        .toList();
  }
}

class PopupItemButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final Function() onEnter;

  PopupItemButton(this.text, {required this.onTap, required this.onEnter});

  @override
  _PopupItemButtonState createState() => _PopupItemButtonState();
}

class _PopupItemButtonState extends State<PopupItemButton> {
  bool hover = false;
  bool focus = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.widget.onTap,
        onHover: (isHovering) {
          if (isHovering) {
            this.widget.onEnter();
          }
          setState(() => hover = isHovering);
        },
        canRequestFocus: true,
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            this.widget.onEnter();
          }
          setState(() => focus = hasFocus);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration:
                BoxDecoration(color: (hover || focus) ? Colors.black12 : Colors.transparent),
            height: ROW_HEIGHT,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(this.widget.text)));
  }
}
