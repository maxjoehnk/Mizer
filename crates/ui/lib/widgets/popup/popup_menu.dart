import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';

const MAX_ROWS = 10;
const double COLUMN_WIDTH = 175;
const double ROW_HEIGHT = 26;

class PopupEntry<T> {
  final String label;
  final String? description;

  const PopupEntry({required this.label, this.description});
}

class PopupItem<T> extends PopupEntry<T> {
  final T value;
  final String? searchLabel;
  final SortOrder? sortOrder;

  const PopupItem(this.value, String label, {this.searchLabel, this.sortOrder, super.description}) : super(label: label);
}

enum SortOrder {
  First,
}

class PopupCategory<T> extends PopupEntry<T> {
  final List<PopupEntry<T>> items;

  const PopupCategory({required super.label, required this.items, super.description});
}

class PopupMenu<T> extends StatefulWidget {
  final List<PopupEntry<T>> categories;
  final Function(T) onSelect;
  final bool showDescription;

  PopupMenu({required this.categories, required this.onSelect, this.showDescription = true });

  @override
  State<PopupMenu<T>> createState() =>
      _PopupMenuState<T>(categories.whereType<PopupCategory<T>>().first);
}

class _PopupMenuState<T> extends State<PopupMenu<T>> {
  PopupCategory<T> selected;
  PopupEntry<T>? hovered;
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
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300, minWidth: 150, maxWidth: widget.showDescription ? 150 : 200),
            child: SingleChildScrollView(
              child: Column(
                  children: widget.categories
                      .map((c) => buildEntry(c))
                      .toList()),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300, minWidth: 150, maxWidth: widget.showDescription ? 150 : 250),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildWidgets(selected.items.sorted((lhs, rhs) {
                  if (lhs is PopupCategory && rhs is PopupItem) {
                    return -1;
                  }
                  if (lhs is PopupItem && rhs is PopupCategory) {
                    return 1;
                  }
                  if (lhs is PopupCategory && rhs is PopupCategory) {
                    return lhs.label.compareTo(rhs.label);
                  }

                  if ((lhs as PopupItem).sortOrder == SortOrder.First && (rhs as PopupItem).sortOrder != SortOrder.First) {
                    return -1;
                  }
                  if ((rhs as PopupItem).sortOrder == SortOrder.First && (lhs as PopupItem).sortOrder != SortOrder.First) {
                    return 1;
                  }
                  return lhs.label.compareTo(rhs.label);
                })),
              ),
            ),
          ),
          if (widget.showDescription)
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
    var items = flatten(widget.categories)
        .fuzzySearch([(item) => item.searchLabel ?? item.label], text);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 300, minWidth: 150, maxWidth: widget.showDescription ? 300 : 450),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildWidgets(items, inSearch: true),
            ),
          ),
        ),
        if (widget.showDescription)
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300, maxWidth: 150),
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
      ],
    );
  }

  Widget buildEntry(PopupEntry<T> entry, { inSearch = false }) {
    if (entry is PopupItem<T>) {
      return PopupItemButton.text(inSearch ? entry.searchLabel ?? entry.label : entry.label,
          onTap: () => _onTap(entry), onEnter: () => setState(() => hovered = entry));
    }
    if (entry is PopupCategory<T>) {
      return PopupItemButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Text(entry.label)),
              Icon(Icons.arrow_right, size: 12),
            ],
          ),
          onEnter: () => setState(() => hovered = entry),
          onTap: () => _onTap(entry));
    }
    return Container();
  }

  List<Widget> buildWidgets(Iterable<PopupEntry<T>> items, { inSearch = false }) {
    return items
        .map((item) => buildEntry(item, inSearch: inSearch))
        .toList();
  }

  _onTap(PopupEntry<T> entry) {
    if (entry is PopupItem<T>) {
      widget.onSelect(entry.value);
      Navigator.pop(context);
    }
    if (entry is PopupCategory<T>) {
      setState(() => selected = entry);
    }
  }
}

Iterable<PopupItem<T>> flatten<T>(List<PopupEntry<T>> entries) {
  return entries.map<Iterable<PopupItem<T>>>((e) {
    if (e is PopupItem<T>) {
      return [e];
    } else if (e is PopupCategory<T>) {
      return flatten(e.items);
    }
    return [];
  }).flattened;
}

class PopupItemButton extends StatefulWidget {
  final Widget child;
  final Function() onTap;
  final Function() onEnter;

  PopupItemButton({required this.child, required this.onTap, required this.onEnter});

  factory PopupItemButton.text(String text,
      {required Function() onTap, required Function() onEnter}) {
    return PopupItemButton(child: Text(text), onTap: onTap, onEnter: onEnter);
  }

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
            child: widget.child));
  }
}
