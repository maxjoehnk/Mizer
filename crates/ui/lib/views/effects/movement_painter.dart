import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'dart:math' as math;

class MovementPainter extends CustomPainter {
  final EffectChannel? pan;
  final EffectChannel? tilt;

  MovementPainter(this.pan, this.tilt);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1 * size.height, -1 * size.height);
    _drawAxis(canvas);
    _drawSecondaryAxis(canvas);
    if (pan != null && tilt != null) {
      _drawMovement(canvas);
    }
  }

  void _drawAxis(Canvas canvas) {
    Paint axisPaint = Paint()
      ..color = Color(0x55ffffff)
      ..style = PaintingStyle.stroke;
    var xAxis = Path()
      ..moveTo(0, 0.5)
      ..lineTo(1, 0.5);
    var yAxis = Path()
      ..moveTo(0.5, 0)
      ..lineTo(0.5, 1);
    canvas.drawPath(xAxis, axisPaint);
    canvas.drawPath(yAxis, axisPaint);
  }

  void _drawSecondaryAxis(Canvas canvas) {
    Paint axisPaint = Paint()
      ..color = Color(0x22ffffff)
      ..style = PaintingStyle.stroke;
    var axis = [
      Path()
        ..moveTo(0, 0.25)
        ..lineTo(1, 0.25),
      Path()
        ..moveTo(0, 0.75)
        ..lineTo(1, 0.75),
      Path()
        ..moveTo(0.25, 0)
        ..lineTo(0.25, 1),
      Path()
        ..moveTo(0.75, 0)
        ..lineTo(0.75, 1),
    ];
    axis.forEach((element) => canvas.drawPath(element, axisPaint));
  }

  void _drawMovement(Canvas canvas) {
    var pan = this.pan!;
    var tilt = this.tilt!;
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    
    if (pan.steps.isEmpty || tilt.steps.isEmpty) return;
    
    var path = Path();
    
    // Sample the movement path over time to create accurate 2D movement
    const int totalSamples = 100;
    
    for (var sample = 0; sample <= totalSamples; sample++) {
      double t = sample / totalSamples.toDouble();
      double timePosition = t * (pan.steps.length - 1);
      
      double x = _sampleChannelAtTime(pan, timePosition);
      double y = _sampleChannelAtTime(tilt, timePosition);
      
      if (sample == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    canvas.drawPath(path, linePaint);
  }
  
  /// Sample a channel's value at a specific time position
  double _sampleChannelAtTime(EffectChannel channel, double timePosition) {
    if (channel.steps.isEmpty) return 0.0;
    if (timePosition <= 0) return channel.steps.first.value.direct;
    if (timePosition >= channel.steps.length - 1) return channel.steps.last.value.direct;
    
    int stepIndex = timePosition.floor();
    double localT = timePosition - stepIndex;
    
    if (stepIndex >= channel.steps.length - 1) {
      return channel.steps.last.value.direct;
    }
    
    var currentStep = channel.steps[stepIndex];
    var nextStep = channel.steps[stepIndex + 1];
    
    double startValue = currentStep.value.direct;
    double endValue = nextStep.value.direct;
    
    // Handle different curve types
    if (nextStep.hasCubic()) {
      // Use cubic bezier interpolation with control points
      double p0 = startValue;
      double p1 = nextStep.cubic.c0b;
      double p2 = nextStep.cubic.c1b;
      double p3 = endValue;
      
      return _cubicBezier(p0, p1, p2, p3, localT);
    } else if (nextStep.hasQuadratic()) {
      // Use quadratic bezier interpolation
      double p0 = startValue;
      double p1 = nextStep.quadratic.c0b;
      double p2 = endValue;
      
      return _quadraticBezier(p0, p1, p2, localT);
    } else {
      // Linear interpolation
      return startValue + (endValue - startValue) * localT;
    }
  }
  
  /// Cubic bezier curve evaluation
  double _cubicBezier(double p0, double p1, double p2, double p3, double t) {
    double u = 1.0 - t;
    return u * u * u * p0 + 3 * u * u * t * p1 + 3 * u * t * t * p2 + t * t * t * p3;
  }
  
  /// Quadratic bezier curve evaluation
  double _quadraticBezier(double p0, double p1, double p2, double t) {
    double u = 1.0 - t;
    return u * u * p0 + 2 * u * t * p1 + t * t * p2;
  }


  @override
  bool shouldRepaint(MovementPainter oldDelegate) {
    return oldDelegate.pan != pan || oldDelegate.tilt != tilt;
  }
}
