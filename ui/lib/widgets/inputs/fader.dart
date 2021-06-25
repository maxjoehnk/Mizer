import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'decoration.dart';

class FaderInput extends StatefulWidget {
  final Function(double) onValue;
  final double value;

  FaderInput({this.onValue, this.value});

  @override
  _FaderInputState createState() => _FaderInputState(value ?? 0);
}

class _FaderInputState extends State<FaderInput> {
  double value = 0;

  _FaderInputState(this.value);

  @override
  Widget build(BuildContext context) {
    double y = 1 - (this.value * 2);
    return LayoutBuilder(
      builder: (context, constraints) => Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            _onScroll(event.scrollDelta.direction);
          }
        },
        child: GestureDetector(
          onVerticalDragUpdate: (update) => _onInput(constraints, update.localPosition),
          onTapDown: (update) => _onInput(constraints, update.localPosition),
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
      ),
    );
  }

  void _onInput(BoxConstraints constraints, Offset position) {
    double _value = (1.0 - position.dy / constraints.maxHeight).clamp(0.0, 1.0);
    setState(() {
      this.value = _value;
    });
    this.widget.onValue(_value);
  }
  
  void _onScroll(double direction) {
    double _value = value;
    if (direction < 0) {
      _value += 0.1;
    }else {
      _value -= 0.1;
    }
    _value = _value.clamp(0.0, 1.0);
    setState(() {
      this.value = _value;
    });
    this.widget.onValue(_value);
  }
}
