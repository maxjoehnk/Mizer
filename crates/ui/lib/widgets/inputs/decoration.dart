import 'package:flutter/material.dart';

var HIGHLIGHT_CONTROL_COLOR = Colors.grey.shade900;
var HOVER_CONTROL_COLOR = Colors.grey.shade700;
var DEFAULT_CONTROL_COLOR = Colors.grey.shade800;
var DEFAULT_CONTROL_BACKGROUND = Colors.grey.shade700;

ShapeDecoration ControlDecoration(
    {Color? color, Gradient? gradient, bool highlight = false, bool hover = false}) {
  return ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: hover == true
            ? HOVER_CONTROL_COLOR
            : (highlight == true ? HIGHLIGHT_CONTROL_COLOR : DEFAULT_CONTROL_COLOR),
        width: 2,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
    color: gradient == null ? (color ?? DEFAULT_CONTROL_BACKGROUND) : null,
    gradient: gradient,
  );
}
