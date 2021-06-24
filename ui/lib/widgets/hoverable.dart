import 'package:flutter/widgets.dart';

class Hoverable extends StatefulWidget {
  final Function() onClick;
  final Widget Function(bool) builder;

  const Hoverable({this.onClick, this.builder, Key key}) : super(key: key);

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (e) => setState(() => hovering = true),
      onExit: (e) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onClick,
        behavior: HitTestBehavior.opaque,
        child: widget.builder(hovering),
      ),
    );
  }
}
