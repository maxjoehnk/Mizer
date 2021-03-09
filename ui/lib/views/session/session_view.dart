import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, Session>(
        builder: (context, session) => ListView(
            padding: const EdgeInsets.all(8.0),
            children: session.devices.map((device) => SessionCard(device)).toList()));
  }
}

class SessionCard extends StatelessWidget {
  final SessionDevice device;

  SessionCard(this.device);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(device.name),
        Text(device.ips.join(", ")),
        Text("Clock: ${device.clock.master ? "master" : "slave"} (+${device.clock.drift}ms)"),
        Text("Ping: ${device.ping}ms")
      ]),
    ));
  }
}
