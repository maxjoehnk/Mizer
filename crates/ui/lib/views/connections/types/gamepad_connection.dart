import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/api/plugin/ffi/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:provider/provider.dart';

class GamepadConnectionView extends StatefulWidget {
  final GamepadConnection device;

  GamepadConnectionView({required this.device});

  @override
  State<GamepadConnectionView> createState() => _GamepadConnectionViewState();
}

class _GamepadConnectionViewState extends State<GamepadConnectionView>
    with SingleTickerProviderStateMixin {
  GamepadStatePointer? _pointer;
  Ticker? _ticker;
  GamepadState? _state;

  @override
  void initState() {
    super.initState();
    var connectionsApi = context.read<ConnectionsApi>();
    connectionsApi.getGamepadPointer(widget.device.id).then((pointer) {
      _pointer = pointer;
      _ticker = this.createTicker((elapsed) {
        setState(() {
          _state = _pointer!.readState();
        });
      });
      _ticker!.start();
    });
  }

  @override
  void dispose() {
    _pointer?.dispose();
    _ticker?.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DPad(_state!.dpad),
          Stick(_state!.leftStick),
          Stick(_state!.rightStick),
          Buttons(_state!),
          Shoulder(_state!.leftTrigger, _state!.leftShoulder),
          Shoulder(_state!.rightTrigger, _state!.rightShoulder),
          Misc(_state!),
        ],
      ),
    );
  }
}

class DPad extends StatelessWidget {
  final GamepadDpadState state;

  const DPad(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomPaint(painter: DpadPainter(state), size: Size.square(100)),
    );
  }
}

class DpadPainter extends CustomPainter {
  static const double WIDTH = 30;
  static const double HEIGHT = 20;
  static const double MARGIN = 8;

  final GamepadDpadState state;

  DpadPainter(this.state);

  @override
  void paint(Canvas canvas, Size size) {
    var dy = (size.height - HEIGHT) / 2;
    var dx = (size.width - WIDTH);
    _drawPad(canvas, Offset(MARGIN, dy), state.left);
    _drawArrow(canvas, Offset(MARGIN, dy), AxisDirection.left);
    _drawPad(canvas, Offset(dx - MARGIN, dy), state.right);
    _drawArrow(canvas, Offset(dx - MARGIN + 16, dy), AxisDirection.right);
    _drawPad(canvas, Offset(dy, MARGIN), state.up, rotate: true);
    _drawArrow(canvas, Offset(dy, MARGIN), AxisDirection.up);
    _drawPad(canvas, Offset(dy, dx - MARGIN), state.down, rotate: true);
    _drawArrow(canvas, Offset(dy, dx - MARGIN + 16), AxisDirection.down);
  }

  void _drawPad(Canvas canvas, Offset offset, bool pressed, {bool rotate = false}) {
    Paint borderPaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    double width = rotate ? HEIGHT : WIDTH;
    double height = rotate ? WIDTH : HEIGHT;
    var rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(offset.dx, offset.dy, width, height), Radius.circular(2));
    canvas.drawRRect(rect, borderPaint);
    if (pressed) {
      Paint pressedPaint = Paint()
        ..color = Colors.deepOrange
        ..style = PaintingStyle.fill;
      canvas.drawRRect(rect.deflate(4), pressedPaint);
    }
  }

  void _drawArrow(Canvas canvas, Offset offset, AxisDirection direction) {
    Paint borderPaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.fill;
    Path arrow = _arrow(direction);
    canvas.drawPath(arrow.shift(Offset(5, 5)).shift(offset), borderPaint);
  }

  @override
  bool shouldRepaint(DpadPainter oldDelegate) {
    return oldDelegate.state != this.state;
  }

  Path _arrow(AxisDirection direction) {
    if (direction == AxisDirection.left) {
      return _leftArrow();
    } else if (direction == AxisDirection.right) {
      return _rightArrow();
    } else if (direction == AxisDirection.up) {
      return _upArrow();
    } else {
      return _downArrow();
    }
  }

  Path _upArrow() {
    return Path()
      ..moveTo(5, 0)
      ..lineTo(0, 3)
      ..lineTo(10, 3)
      ..lineTo(5, 0);
  }

  Path _leftArrow() {
    return Path()
      ..moveTo(0, 5)
      ..lineTo(3, 0)
      ..lineTo(3, 10)
      ..lineTo(0, 5);
  }

  Path _rightArrow() {
    return Path()
      ..moveTo(3, 5)
      ..lineTo(0, 0)
      ..lineTo(0, 10)
      ..lineTo(3, 5);
  }

  Path _downArrow() {
    return Path()
      ..moveTo(5, 3)
      ..lineTo(0, 0)
      ..lineTo(10, 0)
      ..lineTo(5, 3);
  }
}

class Buttons extends StatelessWidget {
  final GamepadState state;

  const Buttons(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomPaint(painter: ButtonsPainter(state), size: Size.square(100)),
    );
  }
}

class ButtonsPainter extends CustomPainter {
  static const double RADIUS = 15;
  static const double PADDING = 20;

  final GamepadState state;

  ButtonsPainter(this.state);

  @override
  void paint(Canvas canvas, Size size) {
    _drawButton(canvas, size.topCenter(Offset(0, PADDING)), state.north);
    _drawButton(canvas, size.bottomCenter(Offset(0, -PADDING)), state.south);
    _drawButton(canvas, size.centerLeft(Offset(PADDING, 0)), state.west);
    _drawButton(canvas, size.centerRight(Offset(-PADDING, 0)), state.east);
  }

  void _drawButton(Canvas canvas, Offset offset, bool pressed) {
    Paint stickPaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(offset, RADIUS, stickPaint);
    if (pressed) {
      Paint pressedPaint = Paint()
        ..color = Colors.deepOrange
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offset, RADIUS - 4, pressedPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Stick extends StatelessWidget {
  final GamepadStickState state;

  const Stick(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomPaint(painter: StickPainter(state), size: Size.square(100)),
    );
  }
}

class StickPainter extends CustomPainter {
  final GamepadStickState state;

  StickPainter(this.state);

  @override
  void paint(Canvas canvas, Size size) {
    var x = (state.x + 1) / 2;
    var y = 1 - (state.y + 1) / 2;
    _drawFrame(size, canvas);
    _drawPosition(canvas, Offset(size.width * x, size.height * y));
  }

  void _drawFrame(Size size, Canvas canvas) {
    var center = size.width / 2;
    Paint stickPaint = Paint()
      ..color = state.pressed ? Colors.deepOrange : Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    Paint gridPaint = Paint()
      ..color = Color(0x22ffffff)
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), center, stickPaint);
    canvas.drawLine(Offset(0, center), Offset(size.width, center), gridPaint);
    canvas.drawLine(Offset(center, 0), Offset(center, size.height), gridPaint);
  }

  void _drawPosition(Canvas canvas, Offset offset) {
    Paint paint = Paint()
      ..color = state.pressed ? Colors.deepOrange : Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    canvas.drawLine(offset - Offset(4, 0), offset + Offset(4, 0), paint);
    canvas.drawLine(offset - Offset(0, 4), offset + Offset(0, 4), paint);
  }

  @override
  bool shouldRepaint(StickPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}

class Shoulder extends StatelessWidget {
  final double trigger;
  final bool button;

  const Shoulder(this.trigger, this.button, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomPaint(painter: ShoulderPainter(trigger, button), size: Size(40, 100)),
    );
  }
}

class ShoulderPainter extends CustomPainter {
  final double trigger;
  final bool button;

  ShoulderPainter(this.trigger, this.button);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    Paint pressedPaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill;
    Radius radius = Radius.circular(2);
    var buttonRect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, 20), radius);
    canvas.drawRRect(buttonRect, paint);
    if (button) {
      canvas.drawRRect(buttonRect.deflate(4), pressedPaint);
    }
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 30, size.width, 70), radius), paint);
    canvas.drawRect(Rect.fromLTWH(4, 96, size.width - 8, -62 * trigger), pressedPaint);
  }

  @override
  bool shouldRepaint(ShoulderPainter oldDelegate) {
    return oldDelegate.button != button || oldDelegate.trigger != trigger;
  }
}

class Misc extends StatelessWidget {
  final GamepadState state;

  const Misc(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomPaint(painter: MiscPainter(state), size: Size(50, 100)),
    );
  }
}

class MiscPainter extends CustomPainter {
  final GamepadState state;

  MiscPainter(this.state);

  @override
  void paint(Canvas canvas, Size size) {
    _drawButton(canvas, Offset.zero, "Select", size, state.select);
    _drawButton(canvas, Offset(0, 36), "Start", size, state.start);
    _drawButton(canvas, Offset(0, 72), "Mode", size, state.mode);
  }

  void _drawButton(Canvas canvas, Offset offset, String text, Size size, bool pressed) {
    Paint paint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    Paint pressedPaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill;
    var buttonRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, 28).shift(offset), Radius.circular(2));
    canvas.drawRRect(buttonRect, paint);
    if (pressed) {
      canvas.drawRRect(buttonRect.deflate(4), pressedPaint);
    }
    var painter = TextPainter(
        text: TextSpan(text: text, style: TextStyle(color: Colors.white54)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    painter.layout(maxWidth: size.width);
    painter.paint(canvas, Offset(4, 4) + offset);
    painter.dispose();
  }

  @override
  bool shouldRepaint(MiscPainter oldDelegate) {
    return oldDelegate.state.select != state.select ||
        oldDelegate.state.start != state.start ||
        oldDelegate.state.mode != state.mode;
  }
}
