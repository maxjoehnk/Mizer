import 'package:flutter/material.dart';

var HIGHLIGHT_CONTROL_COLOR = Colors.grey.shade900;
var DEFAULT_CONTROL_COLOR = Colors.grey.shade800;
var DEFAULT_CONTROL_BACKGROUND = Colors.grey.shade700;

ShapeDecoration ControlDecoration({ Color? color, Gradient? gradient, bool highlight = false }) {
  return ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: highlight == true ? HIGHLIGHT_CONTROL_COLOR : DEFAULT_CONTROL_COLOR,
        width: 4,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    color: gradient == null ? (color ?? DEFAULT_CONTROL_BACKGROUND) : null,
    gradient: gradient,
  );
}
