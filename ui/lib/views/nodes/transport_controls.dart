import 'dart:developer';

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
    return StreamBuilder<Transport>(
        stream: api.watchTransport(),
        initialData: Transport(),
        builder: (context, snapshot) {
          return Container(
              height: TRANSPORT_CONTROLS_HEIGHT,
              color: Colors.grey.shade800,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TimeControl(snapshot.data),
                ),
                SpeedControl(snapshot.data.speed),
                TransportControl(snapshot.data.state),
              ]));
        });
  }
}

const MINUTE = 60;
const HOUR = 60 * MINUTE;

class TimeControl extends StatelessWidget {
  final Transport transport;

  TimeControl(this.transport);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.grey.shade900,
        width: 160,
        child: Text(_formatTime(), textAlign: TextAlign.center, style: style.headline5));
  }

  String _formatTime() {
    var hours = (transport.time / HOUR).floor();
    var minutes = (transport.time / MINUTE).floor() - hours * HOUR;
    var seconds = transport.time.floor() - minutes * MINUTE;
    var millis = ((transport.time - transport.time.floor()) * 10).floor();

    return "${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)}.$millis";
  }

  String _pad(int number) {
    return number.toString().padLeft(2, "0");
  }
}

class SpeedControl extends StatelessWidget {
  final double bpm;

  SpeedControl(this.bpm);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Container(
        padding: const EdgeInsets.all(8),
        width: 96,
        color: Colors.grey.shade900,
        child: Text(bpm.toString(), textAlign: TextAlign.center, style: style.headline5));
  }
}

class TransportControl extends StatelessWidget {
  final TransportState state;

  TransportControl(this.state);

  @override
  Widget build(BuildContext context) {
    var api = context.read<TransportApi>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(children: [
        Container(
            margin: const EdgeInsets.only(left: 4),
            color: state == TransportState.Stopped ? Colors.deepOrange : null,
            child: IconButton(onPressed: () => api.setState(TransportState.Stopped), icon: Icon(Icons.stop))),
        Container(
            margin: const EdgeInsets.only(left: 4),
            color: state == TransportState.Paused ? Colors.deepOrange : null,
            child: IconButton(onPressed: () => api.setState(TransportState.Paused), icon: Icon(Icons.pause))),
        Container(
            margin: const EdgeInsets.only(left: 4),
            color: state == TransportState.Playing ? Colors.deepOrange : null,
            child: IconButton(onPressed: () => api.setState(TransportState.Playing), icon: Icon(Icons.play_arrow))),
      ]),
    );
  }
}
