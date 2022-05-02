import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MizerButton extends StatefulWidget {
  final Function()? onClick;
  final Widget child;
  final bool active;

  MizerButton({ required this.child, this.onClick, this.active = false });

  @override
  _MizerButtonState createState() => _MizerButtonState();
}

class _MizerButtonState extends State<MizerButton> {
  bool hovering = false;
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      debugLabel: "MizerButton",
      onFocusChange: (hasFocus) => setState(() => focused = hasFocus),
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          if (widget.onClick != null) {
            widget.onClick!();
          }
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (e) => setState(() => hovering = true),
        onExit: (e) => setState(() => hovering = false),
        child: GestureDetector(
          onTap: widget.onClick,
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(2),
            child: Center(child: widget.child),
          ),
        ),
      ),
    );
  }

  Color? get _backgroundColor {
    if (hovering || focused) {
      return Colors.grey.shade600;
    }
    if (widget.active) {
      return Colors.grey.shade700;
    }

    return null;
  }
}
