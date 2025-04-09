import 'package:flutter/material.dart';
import 'package:mizer/views/presets/preset_indicator.dart';

class PositionIndicator extends StatelessWidget {
  final double? pan;
  final double? tilt;

  const PositionIndicator({super.key, this.pan, this.tilt});

  @override
  Widget build(BuildContext context) {
    if (pan == null && tilt == null) {
      return Container();
    }
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.all(4),
        width: 32,
        height: 32,
        child: CustomPaint(painter: PositionPainter(pan: pan, tilt: tilt)));
  }
}
