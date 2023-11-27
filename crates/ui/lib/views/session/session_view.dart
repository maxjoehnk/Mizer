import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
        builder: (context, session) => Column(
              children: [
                Expanded(
                  child: Panel(
                      label: "Session",
                      child: SingleChildScrollView(
                        child: MizerTable(
                          columns: [
                            Text("Name"),
                            Text("IP"),
                            Text("Role"),
                            Text("Clock"),
                            Text("Ping")
                          ],
                          rows: session.currentSession.devices
                              .map((device) => MizerTableRow(cells: [
                                    Text(device.name),
                                    Text(device.ips.join(", ")),
                                    Text(device.role.name.toCapitalCase()),
                                    Text("+${device.clock.drift}ms"),
                                    Text("${device.ping}ms")
                                  ]))
                              .toList(),
                        ),
                      )),
                ),
                Expanded(
                    child: Panel(
                        label: "Available Sessions",
                        child: SingleChildScrollView(
                          child: MizerTable(
                              columns: [Text("Name"), Text("Hostname"), Text("IPs"), Container()],
                              rows: session.availableSessions
                                  .map((s) => MizerTableRow(cells: [
                                        Text(s.name),
                                        Text(s.hostname),
                                        Text(s.ips.join(", ")),
                                        MizerButton(child: Text("Join")),
                                      ]))
                                  .toList()),
                        )))
              ],
            ));
  }
}
