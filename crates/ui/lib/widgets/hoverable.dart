import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class Hoverable extends StatefulWidget {
  final bool disabled;
  final void Function()? onTap;
  final void Function(TapDownDetails)? onTapDown;
  final void Function(TapUpDetails)? onTapUp;
  final void Function()? onSecondaryTap;
  final void Function(TapDownDetails)? onSecondaryTapDown;
  final void Function()? onDoubleTap;
  final Widget Function(bool) builder;

  const Hoverable(
      {this.disabled = false,
      this.onTap,
      this.onTapDown,
      this.onTapUp,
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
    var hasTap = widget.onTap == null && widget.onTapDown == null;
    return MouseRegion(
      cursor: (widget.disabled == true || hasTap)
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onHover: (e) {
        if (e.kind == PointerDeviceKind.touch) {
          return;
        }
        if (hasTap) {
          return;
        }
        setState(() => hovering = !widget.disabled);
      },
      onExit: (e) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: _callWhenNotDisabled(widget.onTap),
        onTapDown: _callDetailsWhenNotDisabled(widget.onTapDown),
        onTapUp: _callDetailsWhenNotDisabled(widget.onTapUp),
        onSecondaryTap: _callWhenNotDisabled(widget.onSecondaryTap),
        onSecondaryTapDown: _callDetailsWhenNotDisabled(widget.onSecondaryTapDown),
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

  void Function(T)? _callDetailsWhenNotDisabled<T>(void Function(T)? function) {
    if (function == null) {
      return null;
    }
    return (T details) {
      if (widget.disabled) {
        return;
      }
      function(details);
    };
  }
}
