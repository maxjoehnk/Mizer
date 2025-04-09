import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/programmer.pb.dart';

class PresetValueIndicator extends StatelessWidget {
  final Preset preset;

  const PresetValueIndicator({required this.preset, super.key});

  @override
  Widget build(BuildContext context) {
    if (preset.hasColor()) {
      return ColorPresetIndicator(preset: preset);
    }
    if (preset.hasFader()) {
      return FaderPresetIndicator(preset: preset);
    }
    if (preset.hasPosition()) {
      return PositionPresetIndicator(preset: preset);
    }
    return Container();
  }
}

class ColorPresetIndicator extends StatelessWidget {
  final Preset preset;

  const ColorPresetIndicator({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: GRID_3_SIZE,
      height: GRID_3_SIZE,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
              (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
          borderRadius: BorderRadius.circular(GRID_3_SIZE)),
    );
  }
}

class FaderPresetIndicator extends StatelessWidget {
  final Preset preset;

  const FaderPresetIndicator({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: GRID_3_SIZE,
      height: GRID_3_SIZE,
      decoration: BoxDecoration(
          color: Color.from(alpha: 1, red: preset.fader, green: preset.fader, blue: preset.fader),
          borderRadius: BorderRadius.circular(GRID_3_SIZE)),
    );
  }
}

class PositionPresetIndicator extends StatelessWidget {
  final Preset preset;

  const PositionPresetIndicator({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    var pan = preset.position.hasPan() ? preset.position.pan : null;
    var tilt = preset.position.hasTilt() ? preset.position.tilt : null;

    return Container(
      margin: tilt == null ? EdgeInsets.symmetric(vertical: 12) : EdgeInsets.all(0),
      width: pan == null ? 24 : 48,
      height: tilt == null ? 24 : 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Grey800, borderRadius: BorderRadius.circular(8)),
      child: CustomPaint(painter: PositionPainter(pan: pan, tilt: tilt)),
    );
  }
}

class PositionPainter extends CustomPainter {
  final double? pan;
  final double? tilt;

  PositionPainter({required this.pan, required this.tilt});

  @override
  void paint(Canvas canvas, Size size) {
    var x = size.width * (pan ?? 0.5);
    var y = size.height * (tilt ?? 0.5);

    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x, y), 4, paint);
  }

  @override
  bool shouldRepaint(covariant PositionPainter oldDelegate) {
    return pan != oldDelegate.pan || tilt != oldDelegate.tilt;
  }
}
