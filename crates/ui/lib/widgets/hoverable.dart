import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class Hoverable extends StatefulWidget {
  final bool disabled;
  final void Function()? onTap;
  final void Function()? onSecondaryTap;
  final void Function(TapDownDetails)? onSecondaryTapDown;
  final void Function()? onDoubleTap;
  final Widget Function(bool) builder;

  const Hoverable(
      {this.disabled = false,
      this.onTap,
      this.onSecondaryTap,
      this.onSecondaryTapDown,
      this.onDoubleTap,
      required this.builder,
      Key? key})
      : super(key: key);

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: (widget.disabled == true || widget.onTap == null)
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onHover: (e) {
        if (e.kind == PointerDeviceKind.touch) {
          return;
        }
        if (widget.onTap == null) {
          return;
        }
        setState(() => hovering = !widget.disabled);
      },
      onExit: (e) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: _callWhenNotDisabled(widget.onTap),
        onSecondaryTap: _callWhenNotDisabled(widget.onSecondaryTap),
        onSecondaryTapDown: _callDownWhenNotDisabled(widget.onSecondaryTapDown),
        onDoubleTap: _callWhenNotDisabled(widget.onDoubleTap),
        behavior: HitTestBehavior.opaque,
        child: widget.builder(hovering),
      ),
    );
  }

  void Function()? _callWhenNotDisabled(void Function()? function) {
    if (function == null) {
      return null;
    }
    return () {
      if (widget.disabled) {
        return;
      }
      function();
    };
  }

  void Function(TapDownDetails)? _callDownWhenNotDisabled(void Function(TapDownDetails)? function) {
    if (function == null) {
      return null;
    }
    return (TapDownDetails details) {
      if (widget.disabled) {
        return;
      }
      function(details);
    };
  }
}
