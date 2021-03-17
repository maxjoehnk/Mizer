import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'decoration.dart';

class FaderInput extends StatefulWidget {
  final Function(double) onValue;

  FaderInput({this.onValue});

  @override
  _FaderInputState createState() => _FaderInputState();
}

class _FaderInputState extends State<FaderInput> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    double y = 1 - (this.value * 2);
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onVerticalDragUpdate: (update) => onInput(constraints, update.localPosition),
        onTapDown: (update) => onInput(constraints, update.localPosition),
        child: Container(
          decoration: ControlDecoration(),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Align(
                alignment: AlignmentDirectional(0, y),
                child: Container(color: Colors.grey.shade800, height: 32)),
          ),
        ),
      ),
    );
  }

  void onInput(BoxConstraints constraints, Offset position) {
    double _value = (1.0 - position.dy / constraints.maxHeight).clamp(0.0, 1.0);
    setState(() {
      this.value = _value;
    });
    this.widget.onValue(_value);
  }
}
