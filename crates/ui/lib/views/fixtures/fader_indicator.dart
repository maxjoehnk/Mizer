import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pbenum.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:provider/provider.dart';

class IntensityIndicator extends StatelessWidget {
  final Widget child;
  final Iterable<ProgrammerChannel>? fixtureState;

  const IntensityIndicator({super.key, required this.child, this.fixtureState});

  @override
  Widget build(BuildContext context) {
    var value = this.getValue(context);
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null) CustomPaint(size: Size.fromWidth(8), painter: FaderIndicatorPainter(value)),
          Expanded(child: SizedBox(width: 2)),
          child,
        ]
    );
  }

  double? getValue(BuildContext context) {
    var programmerChannel = fixtureState?.firstWhereOrNull((element) => element.control == FixtureControl.INTENSITY);
    if (programmerChannel == null) {
      return null;
    }
    if (programmerChannel.hasPreset()) {
      PresetsBloc bloc = context.read();
      var preset = bloc.state.getPreset(programmerChannel.preset);
      if (preset == null) {
        return null;
      }
      return preset.fader;
    }
    return programmerChannel.fader;
  }
}

class FaderIndicatorPainter extends CustomPainter {
  final double value;

  FaderIndicatorPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    var strokePaint = Paint()
      ..color = Colors.white54
      ..style = PaintingStyle.stroke;
    var backgroundPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    var fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 1, size.width, size.height - 1), backgroundPaint);
    canvas.drawRect(Rect.fromLTWH(0, 1, size.width, size.height - 1), strokePaint);
    canvas.drawRect(Rect.fromLTWH(0, size.height * (1 - value), size.width, size.height * value), fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

