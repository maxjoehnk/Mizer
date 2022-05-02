import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, Session>(
        builder: (context, session) => Panel(
          label: "Session",
          child: MizerTable(
              columns: [Text("Name"), Text("IP"), Text("Role"), Text("Clock"), Text("Ping")],
              rows: session.devices.map((device) => MizerTableRow(cells: [
                Text(device.name),
                Text(device.ips.join(", ")),
                Text(device.clock.master ? "master" : "slave"),
                Text("+${device.clock.drift}ms"),
                Text("${device.ping}ms")
              ])).toList(),
        )));
  }
}
