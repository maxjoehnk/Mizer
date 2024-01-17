import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/api/plugin/ffi/bindings.dart' as ffi;
import 'package:mizer/api/plugin/ffi/transport.dart';
import 'package:mizer/protos/transport.pb.dart';

class TimeControl extends StatelessWidget {
  final TransportApi api;
  final Stream<Transport> transport;

  TimeControl(this.api, this.transport);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.grey.shade900,
        width: 160,
        child: FutureBuilder(
          future: api.getTransportPointer(),
          builder: (context, AsyncSnapshot<TransportPointer?> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return FFITimeControl(pointer: snapshot.data!);
            }
            return _StreamTimeControl(transport: transport);
          },
        ));
  }
}

class _StreamTimeControl extends StatelessWidget {
  final Stream<Transport> transport;

  const _StreamTimeControl({required this.transport, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: transport,
      initialData: Transport(),
      builder: (context, AsyncSnapshot<Transport> snapshot) => _formatTime(snapshot.data!),
    );
  }

  Widget _formatTime(Transport transport) {
    int hours = transport.timecode.hours.toInt();
    int minutes = transport.timecode.minutes.toInt();
    int seconds = transport.timecode.seconds.toInt();
    int frames = transport.timecode.frames.toInt();

    return _TimeFormat(hours: hours, minutes: minutes, seconds: seconds, frames: frames);
  }
}

class FFITimeControl extends StatefulWidget {
  final TimecodeReader pointer;
  final TextStyle? textStyle;

  const FFITimeControl({required this.pointer, Key? key, this.textStyle}) : super(key: key);

  @override
  _FFITimeControlState createState() => _FFITimeControlState(pointer);
}

class _FFITimeControlState extends State<FFITimeControl> with SingleTickerProviderStateMixin {
  final TimecodeReader pointer;
  late final Ticker ticker;
  ffi.Timecode? timecode;

  _FFITimeControlState(this.pointer);

  @override
  void initState() {
    super.initState();
    ticker = createTicker((elapsed) => setState(() => timecode = pointer.readTimecode()));
    ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    if (timecode == null) {
      return Container();
    }
    return _TimeFormat(
        hours: timecode!.hours,
        minutes: timecode!.minutes,
        seconds: timecode!.seconds,
        frames: timecode!.frames,
        negative: timecode!.is_negative > 0,
        textStyle: widget.textStyle);
  }

  @override
  void dispose() {
    ticker.dispose();
    pointer.dispose();
    super.dispose();
  }
}

class _TimeFormat extends StatelessWidget {
  final int hours;
  final int minutes;
  final int seconds;
  final int frames;
  final bool negative;
  final TextStyle? textStyle;

  const _TimeFormat(
      {Key? key,
      required this.hours,
      required this.minutes,
      required this.seconds,
      required this.frames,
      this.negative = false,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;

    return Text(_formatTime(), textAlign: TextAlign.center, style: textStyle ?? style.headline5);
  }

  String _formatTime() {
    return "${negative ? "-" : ""}${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)}.${_pad(frames)}";
  }

  String _pad(int number) {
    return number.toString().padLeft(2, "0");
  }
}
