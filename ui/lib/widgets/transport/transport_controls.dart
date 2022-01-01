import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/protos/transport.pb.dart';

import 'time_control.dart';

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
            child: RepaintBoundary(child: TimeControl(api, stream)),
          ),
          RepaintBoundary(child: SpeedControl(stream.map((event) => event.speed).distinct())),
          RepaintBoundary(child: TransportControl(stream.map((event) => event.state).distinct())),
        ]));
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
