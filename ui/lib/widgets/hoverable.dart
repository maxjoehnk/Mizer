// @dart=2.11
import 'package:flutter/widgets.dart';

class Hoverable extends StatefulWidget {
  final bool disabled;
  final Function() onTap;
  final Function() onSecondaryTap;
  final Function() onDoubleTap;
  final Widget Function(bool) builder;

  const Hoverable({this.disabled = false, this.onTap, this.onSecondaryTap, this.onDoubleTap, this.builder, Key key}) : super(key: key);

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: (widget.disabled == true || widget.onTap == null) ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onHover: (e) => setState(() => hovering = true),
      onExit: (e) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onSecondaryTap: widget.onSecondaryTap,
        onDoubleTap: widget.onDoubleTap,
        behavior: HitTestBehavior.opaque,
        child: widget.builder(hovering),
      ),
    );
  }
}
