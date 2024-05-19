import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

class EnvelopeSettingsPreview extends StatelessWidget {
  final List<NodeSetting> settings;

  const EnvelopeSettingsPreview(this.settings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(settings);
    var attack = _getSetting("Attack");
    var decay = _getSetting("Decay");
    var sustain = _getSetting("Sustain");
    var release = _getSetting("Release");

    if (attack == null || decay == null || sustain == null || release == null) {
      return Container();
    }

    var config = EnvelopeConfig(attack, decay, sustain, release);

    return EnvelopePreview(config);
  }

  double? _getSetting(String label) {
    return settings
        .firstWhereOrNull((element) => element.hasFloatValue() && element.id == label)
        ?.floatValue
        .value;
  }
}

class EnvelopeConfig {
  final double attack;
  final double decay;
  final double sustain;
  final double release;

  EnvelopeConfig(this.attack, this.decay, this.sustain, this.release);
}

class EnvelopePreview extends StatelessWidget {
  final EnvelopeConfig config;

  const EnvelopePreview(this.config, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: EnvelopePainter(config), size: Size(300, 100));
  }
}

class EnvelopePainter extends CustomPainter {
  final EnvelopeConfig config;

  EnvelopePainter(this.config);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(0.25 * size.width, -1 * size.height);
    _drawAxis(canvas);
    Paint paint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(config.attack, 1);
    if (config.sustain > 0) {
      path
        ..lineTo(config.decay + config.attack, config.sustain)
        ..lineTo(config.attack + config.decay + 1, config.sustain)
        ..lineTo(config.release + config.decay + 1 + config.attack, 0);
    } else {
      path.lineTo(config.release + config.decay + config.attack, 0);
    }

    canvas.drawPath(path, paint);
  }

  void _drawAxis(Canvas canvas) {
    Paint paint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    var yAxis = Path()
      ..moveTo(0, 0)
      ..lineTo(0, 1);
    canvas.drawPath(yAxis, paint);
    var xAxis = Path()
      ..moveTo(0, 0)
      ..lineTo(4, 0);
    canvas.drawPath(xAxis, paint);
  }

  @override
  bool shouldRepaint(covariant EnvelopePainter oldDelegate) {
    return oldDelegate.config != this.config;
  }
}
