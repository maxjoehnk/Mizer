// @dart=2.11
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'decoration.dart';

class ButtonInput extends StatefulWidget {
  final Function(double) onValue;
  final String label;
  final Color color;

  ButtonInput({ this.label, this.onValue, this.color });

  @override
  _ButtonInputState createState() => _ButtonInputState();
}

class _ButtonInputState extends State<ButtonInput> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ControlDecoration(color: widget.color),
        padding: const EdgeInsets.all(4),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTapDown: (_) {
                setState(() => this.pressed = true);
                this.widget.onValue(1);
              },
              onTapUp: (_) {
                setState(() => this.pressed = false);
                this.widget.onValue(0);
              },
              child: Container(
                child: widget.label == null ? null : Text(widget.label),
                decoration: ShapeDecoration(
                  color: this.pressed ? Colors.black45 : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              )),
        ));
  }
}
