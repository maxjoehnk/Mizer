// @dart=2.11
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/protos/transport.pb.dart';

const double TRANSPORT_CONTROLS_HEIGHT = 64;

class TransportControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = context.read<TransportApi>();
    var stream = api.watchTransport().asBroadcastStream();

    return Container(
        height: TRANSPORT_CONTROLS_HEIGHT,
        color: Colors.grey.shade800,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RepaintBoundary(child: TimeControl(stream)),
          ),
          RepaintBoundary(child: SpeedControl(stream.map((event) => event.speed).distinct())),
          RepaintBoundary(child: TransportControl(stream.map((event) => event.state).distinct())),
        ]));
  }
}

class TimeControl extends StatelessWidget {
  final Stream<Transport> transport;

  TimeControl(this.transport);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.grey.shade900,
        width: 160,
        child: StreamBuilder(
          stream: transport,
          initialData: Transport(),
          builder: (context, snapshot) => Text(_formatTime(snapshot.data), textAlign: TextAlign.center, style: style.headline5)
        ));
  }

  String _formatTime(Transport transport) {
    int hours = transport.timecode.hours.toInt();
    int minutes = transport.timecode.minutes.toInt();
    int seconds = transport.timecode.seconds.toInt();
    int frames = transport.timecode.frames.toInt();

    return "${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)}.${_pad(frames)}";
  }

  String _pad(int number) {
    return number.toString().padLeft(2, "0");
  }
}

class SpeedControl extends StatelessWidget {
  final Stream<double> bpm;

  SpeedControl(this.bpm);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Container(
        padding: const EdgeInsets.all(8),
        width: 96,
        color: Colors.grey.shade900,
        child: StreamBuilder(
          stream: bpm,
          initialData: 0,
          builder: (context, snapshot) => Text(snapshot.data.toString(), textAlign: TextAlign.center, style: style.headline5)
        ));
  }
}

class TransportControl extends StatelessWidget {
  final Stream<TransportState> state;

  TransportControl(this.state);

  @override
  Widget build(BuildContext context) {
    var api = context.read<TransportApi>();
    return StreamBuilder(
      stream: state,
      initialData: TransportState.Playing,
      builder: (context, snapshot) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(children: [
          Container(
              margin: const EdgeInsets.only(left: 4),
              color: snapshot.data == TransportState.Stopped ? Colors.deepOrange : null,
              child: IconButton(onPressed: () => api.setState(TransportState.Stopped), icon: Icon(Icons.stop))),
          Container(
              margin: const EdgeInsets.only(left: 4),
              color: snapshot.data == TransportState.Paused ? Colors.deepOrange : null,
              child: IconButton(onPressed: () => api.setState(TransportState.Paused), icon: Icon(Icons.pause))),
          Container(
              margin: const EdgeInsets.only(left: 4),
              color: snapshot.data == TransportState.Playing ? Colors.deepOrange : null,
              child: IconButton(onPressed: () => api.setState(TransportState.Playing), icon: Icon(Icons.play_arrow))),
        ]),
      )
    );
  }
}
