import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/api/plugin/ffi/transport.dart';

const PADDING = 1;

class BeatIndicator extends StatefulWidget {
  final TransportApi api;
  final Stream<double> beatStream;

  const BeatIndicator(this.api, {required this.beatStream, super.key});

  @override
  State<BeatIndicator> createState() => _BeatIndicatorState();
}

class _BeatIndicatorState extends State<BeatIndicator> {
  late Future<TransportPointer?> transportPointer;

  @override
  void initState() {
    super.initState();
    this.transportPointer = widget.api.getTransportPointer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: transportPointer,
      builder: (context, AsyncSnapshot<TransportPointer?> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return _FFIBeatIndicator(pointer: snapshot.data!);
        }
        return _StreamBeatIndicator(widget.beatStream);
      },
    );
  }
}

class _StreamBeatIndicator extends StatelessWidget {
  final Stream<double> beatStream;

  const _StreamBeatIndicator(this.beatStream, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: beatStream,
      initialData: 0.toDouble(),
      builder: (context, AsyncSnapshot<double> snapshot) {
        return _BeatIndicator(snapshot.requireData);
      },
    );
  }
}

class _FFIBeatIndicator extends StatefulWidget {
  final TransportPointer pointer;

  const _FFIBeatIndicator({super.key, required this.pointer});

  @override
  State<_FFIBeatIndicator> createState() => _FFIBeatIndicatorState();
}

class _FFIBeatIndicatorState extends State<_FFIBeatIndicator> with SingleTickerProviderStateMixin {
  late final Ticker ticker;
  double beat = 0;

  @override
  void initState() {
    super.initState();
    ticker = createTicker((elapsed) => setState(() => beat = widget.pointer.readBeat()));
    ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return _BeatIndicator(beat);
  }
}

class _BeatIndicator extends StatelessWidget {
  final double activeBeat;

  const _BeatIndicator(this.activeBeat, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
              clipBehavior: Clip.antiAlias,
              child: CustomPaint(painter: BeatIndicatorPainter(activeBeat: activeBeat.floor()))),
        ));
  }
}

class BeatIndicatorPainter extends CustomPainter {
  int activeBeat;

  BeatIndicatorPainter({this.activeBeat = 0});

  @override
  void paint(Canvas canvas, Size size) {
    var barWidth = size.width / 2 - PADDING / 2;
    var barHeight = size.height / 2 - PADDING / 2;

    void _draw(int i, int x, int y) {
      var paint = Paint()
        ..color = i == activeBeat ? Colors.deepOrange.shade500 : Colors.white10
        ..style = PaintingStyle.fill;
      canvas.drawRect(
          Rect.fromLTWH(
              (x * barWidth) + PADDING * x, (y * barHeight) + PADDING * y, barWidth, barWidth),
          paint);
    }

    _draw(0, 0, 0);
    _draw(1, 1, 0);
    _draw(2, 1, 1);
    _draw(3, 0, 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
