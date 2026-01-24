import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, Session>(
        builder: (context, session) => Panel(
          label: "Session".i18n,
          child: MizerTable(
              columns: [Text("Name".i18n), Text("IP".i18n), Text("Role".i18n), Text("Clock".i18n), Text("Ping".i18n)],
              rows: session.devices.map((device) => MizerTableRow(cells: [
                Text(device.name),
                Text(device.ips.join(", ")),
                Text(device.clock.master ? "Primary".i18n : "Replica".i18n),
                Text("+${device.clock.drift}ms"),
                Text("${device.ping}ms")
              ])).toList(),
        )));
  }
}
