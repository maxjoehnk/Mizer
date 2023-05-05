import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../fields/number_field.dart';
import '../property_group.dart';

class EnvelopeProperties extends StatefulWidget {
  final EnvelopeNodeConfig config;
  final Function(EnvelopeNodeConfig) onUpdate;

  EnvelopeProperties(this.config, {required this.onUpdate});

  @override
  _EnvelopePropertiesState createState() => _EnvelopePropertiesState(config);
}

class _EnvelopePropertiesState extends State<EnvelopeProperties> {
  EnvelopeNodeConfig state;

  _EnvelopePropertiesState(this.state);

  @override
  void didUpdateWidget(EnvelopeProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Envelope", children: [
      NumberField(
        label: "Attack",
        value: this.widget.config.attack,
        onUpdate: _updateAttack,
        fractions: true,
        min: 0,
      ),
      NumberField(
        label: "Decay",
        value: this.widget.config.decay,
        onUpdate: _updateDecay,
        fractions: true,
        min: 0,
      ),
      NumberField(
        label: "Release",
        value: this.widget.config.release,
        onUpdate: _updateRelease,
        fractions: true,
        min: 0,
      ),
      NumberField(
        label: "Sustain",
        value: this.widget.config.sustain,
        onUpdate: _updateSustain,
        fractions: true,
        min: 0,
      ),
      EnvelopePreview(this.widget.config),
    ]);
  }

  void _updateAttack(num attack) {
    log("_updateAttack $attack", name: "EnvelopeProperties");
    setState(() {
      state.attack = attack.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateSustain(num sustain) {
    log("_updateActive $sustain", name: "EnvelopeProperties");
    setState(() {
      state.sustain = sustain.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateDecay(num decay) {
    log("_updateDecay $decay", name: "EnvelopeProperties");
    setState(() {
      state.decay = decay.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateRelease(num release) {
    log("_updateRelease $release", name: "EnvelopeProperties");
    setState(() {
      state.release = release.toDouble();
      widget.onUpdate(state);
    });
  }
}

class EnvelopePreview extends StatelessWidget {
  final EnvelopeNodeConfig config;

  const EnvelopePreview(this.config, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: EnvelopePainter(config), size: Size(300, 100));
  }
}

class EnvelopePainter extends CustomPainter {
  final EnvelopeNodeConfig config;

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
    }else {
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
