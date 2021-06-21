import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MizerSelect<T> extends StatefulWidget {
  final List<SelectOption<T>> options;
  final T value;
  final Function(T) onChanged;

  const MizerSelect({@required this.options, this.value, this.onChanged, Key key})
      : super(key: key);

  @override
  _MizerSelectState<T> createState() => _MizerSelectState<T>();
}

class _MizerSelectState<T> extends State<MizerSelect<T>> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          RenderBox renderBox = context.findRenderObject();
          Navigator.of(context).push(_MizerSelectRoute(
            renderBox: renderBox,
            options: widget.options,
            value: widget.value,
            onChanged: widget.onChanged,
          ));
        },
        child: Row(children: [
          if (label != null) Expanded(child: Text(label)),
          Icon(Icons.arrow_drop_down)
        ]),
      ),
    );
  }

  String get label {
    var value = this
        .widget
        .options
        .firstWhere((element) => element.value == this.widget.value, orElse: () => null);
    if (value == null) {
      return null;
    }
    return value.label;
  }
}

class _MizerSelectRoute<T> extends PopupRoute {
  final List<SelectOption<T>> options;
  final T value;
  final Function(T) onChanged;
  final RenderBox renderBox;

  _MizerSelectRoute({@required this.options, this.value, this.onChanged, this.renderBox, Key key}) : super();

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var theme = Theme.of(context).textTheme;

    return Stack(
      children: [Positioned(
        width: size.width,
        top: offset.dy + size.height,
        left: offset.dx,
        child: DefaultTextStyle(
          style: theme.bodyText2,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: options
                      .map((option) => _MizerSelectOption(
                          option: option, onSelect: () {
                            onChanged(option.value);
                            Navigator.of(context).pop();
                          }))
                      .toList())),
        ),
      )],
    );
  }

  @override
  Duration get transitionDuration => Duration.zero;
}

class _MizerSelectOption<T> extends StatefulWidget {
  final SelectOption<T> option;
  final Function onSelect;

  const _MizerSelectOption({this.option, this.onSelect, Key key}) : super(key: key);

  @override
  _MizerSelectOptionState<T> createState() => _MizerSelectOptionState<T>();
}

class _MizerSelectOptionState<T> extends State<_MizerSelectOption<T>> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (e) => setState(() => this.hovering = true),
      onExit: (e) => setState(() => this.hovering = false),
      child: GestureDetector(
        onTap: widget.onSelect,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          color: hovering ? Colors.grey.shade800 : null,
          child: Text(widget.option.label, textAlign: TextAlign.start),
        ),
      ),
    );
  }
}

class SelectOption<T> {
  T value;
  String label;

  SelectOption({this.value, this.label});
}
