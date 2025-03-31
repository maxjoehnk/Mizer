import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/widgets/hoverable.dart';

class MizerSelect<T> extends StatefulWidget {
  final List<SelectItem<T>> options;
  final T? value;
  final Function(T) onChanged;
  final bool disabled;
  final bool openTop;

  const MizerSelect(
      {required this.options,
      this.disabled = false,
      this.value,
      required this.onChanged,
      this.openTop = false,
      Key? key})
      : super(key: key);

  @override
  _MizerSelectState<T> createState() => _MizerSelectState<T>();
}

class _MizerSelectState<T> extends State<MizerSelect<T>> {
  @override
  Widget build(BuildContext context) {
    return Hoverable(
      disabled: widget.disabled,
      onTap: () {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Navigator.of(context).push(_MizerSelectRoute<T>(
          renderBox: renderBox,
          options: widget.options,
          onChanged: widget.onChanged,
          openTop: widget.openTop,
        ));
      },
      builder: (hovered) => Container(
        color: hovered ? Colors.black12 : Colors.transparent,
        child: Row(children: [
          Expanded(
              child: label == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
                      child: Text(label!,
                          style: TextStyle(color: widget.disabled ? Colors.white70 : null)),
                    )),
          Icon(Icons.arrow_drop_down)
        ]),
      ),
    );
  }

  String? get label {
    var value = this.flatOptions.firstWhereOrNull((element) => element.value == this.widget.value);
    if (value == null) {
      return null;
    }
    return [...value.parents, value.label].join(" / ");
  }

  List<FlatSelectItem<T>> get flatOptions {
    return this.widget.options.flatOptionList();
  }
}

class FlatSelectItem<T> {
  final String label;
  final List<String> parents;
  final T value;

  FlatSelectItem(this.label, this.parents, this.value);
}

class _MizerSelectRoute<T> extends PopupRoute {
  final List<SelectItem<T>> options;
  final Function(T) onChanged;
  final RenderBox renderBox;
  final bool openTop;

  _MizerSelectRoute(
      {required this.options,
      required this.onChanged,
      required this.renderBox,
      required this.openTop})
      : super();

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return MizerSelectContainer<T>(
        options: options, onChanged: onChanged, renderBox: renderBox, openTop: openTop);
  }

  @override
  Duration get transitionDuration => Duration.zero;
}

class MizerSelectContainer<T> extends StatefulWidget {
  final List<SelectItem<T>> options;
  final Function(T) onChanged;
  final RenderBox renderBox;
  final bool openTop;

  const MizerSelectContainer(
      {required this.options,
      required this.onChanged,
      required this.renderBox,
      required this.openTop,
      Key? key})
      : super(key: key);

  @override
  _MizerSelectContainerState<T> createState() => _MizerSelectContainerState();
}

class _MizerSelectContainerState<T> extends State<MizerSelectContainer<T>> {
  List<SelectGroup<T>> tree = [];

  @override
  Widget build(BuildContext context) {
    var size = widget.renderBox.size;
    var offset = widget.renderBox.localToGlobal(Offset.zero);
    var globalSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          width: size.width,
          top: widget.openTop ? null : offset.dy + size.height,
          bottom: widget.openTop ? globalSize.height - offset.dy : null,
          left: offset.dx,
          child: _MizerSelectList<T>(
            options: widget.options,
            onChanged: (value) => widget.onChanged(value),
            onOpenChild: (group) => _openGroup(group),
          ),
        ),
        ..._getLists(size, offset),
      ],
    );
  }

  List<Widget> _getLists(Size size, Offset offset) {
    var globalSize = MediaQuery.of(context).size;
    return this
        .tree
        .mapIndexed((index, element) => Positioned(
              width: size.width,
              top: widget.openTop ? null : offset.dy + size.height,
              bottom: widget.openTop ? globalSize.height - offset.dy : null,
              left: offset.dx - ((index + 1) * size.width),
              child: _MizerSelectList<T>(
                options: element.options,
                onChanged: (value) => widget.onChanged(value),
                onOpenChild: (group) => _openGroup(group),
              ),
            ))
        .toList();
  }

  void _openGroup(SelectGroup<T> group) {
    if (widget.options.contains(group)) {
      setState(() {
        tree = [group];
      });
    } else {
      // TODO: this will fail when switching sub groups but this feature is not used right now.
      setState(() {
        tree.add(group);
      });
    }
  }
}

class _MizerSelectList<T> extends StatelessWidget {
  final List<SelectItem<T>> options;
  final Function(T) onChanged;
  final Function(SelectGroup<T>) onOpenChild;

  const _MizerSelectList(
      {required this.options, required this.onChanged, required this.onOpenChild, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return DefaultTextStyle(
        style: theme.bodyMedium!,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(2),
            ),
            constraints: BoxConstraints(
              minHeight: 32,
              maxHeight: 500,
            ),
            child: ListView(
                shrinkWrap: true,
                children: options.map((option) {
                  if (option is SelectOption<T>) {
                    return _MizerSelectOption<T>(
                        option: option,
                        onSelect: () {
                          onChanged(option.value);
                          Navigator.of(context).pop();
                        });
                  }
                  if (option is SelectGroup<T>) {
                    return _MizerSelectOption<T>(
                      option: option,
                      onSelect: () => onOpenChild(option),
                    );
                  }
                  return Container();
                }).toList())));
  }
}

class _MizerSelectOption<T> extends StatelessWidget {
  final SelectItem<T> option;
  final void Function() onSelect;

  const _MizerSelectOption({required this.option, required this.onSelect, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
        onTap: onSelect,
        builder: (hovering) => Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              color: hovering ? Colors.grey.shade800 : null,
              child: Row(
                children: [
                  Expanded(child: Text(option.label, textAlign: TextAlign.start)),
                  if (option is SelectGroup<T>) Icon(Icons.arrow_right),
                ],
              ),
            ));
  }
}

abstract class SelectItem<T> {
  final String label;

  SelectItem(this.label);
}

class SelectOption<T> extends SelectItem<T> {
  final T value;

  SelectOption({required this.value, required String label}) : super(label);
}

class SelectGroup<T> extends SelectItem<T> {
  // TODO: currently doesn't support nested groups as the widget doesn't support this yet
  final List<SelectItem<T>> options;

  SelectGroup(String label, this.options) : super(label);
}

extension SelectItemList<T> on List<SelectItem<T>> {
  List<FlatSelectItem<T>> flatOptionList({ List<String>? parents = null }) {
    return this
        .map((e) {
          if (e is SelectOption<T>) {
            return [FlatSelectItem(e.label, parents ?? [], e.value)];
          } else if (e is SelectGroup<T>) {
            return e.options.flatOptionList(parents: [...parents ?? [], e.label]);
          } else {
            return [] as List<FlatSelectItem<T>>;
          }
        })
        .flattened
        .toList();
  }
}
