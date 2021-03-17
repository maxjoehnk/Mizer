import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'decoration.dart';

class ButtonInput extends StatefulWidget {
  final Function(double) onValue;

  ButtonInput({ this.onValue });

  @override
  _ButtonInputState createState() => _ButtonInputState();
}

class _ButtonInputState extends State<ButtonInput> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ControlDecoration(),
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
                decoration: ShapeDecoration(
                  color: this.pressed ? Colors.grey.shade800 : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              )),
        ));
  }
}
