import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ShapeDecoration ControlDecoration() {
  return ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.grey.shade800,
        width: 4,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    color: Colors.grey.shade700,
  );
}
