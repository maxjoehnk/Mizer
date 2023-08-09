import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:mizer/windows/osc_monitor_window.dart';
import 'package:provider/provider.dart';

class OscMonitorDialog implements DialogBuilder {
  final Connection connection;

  OscMonitorDialog(this.connection);

  @override
  WidgetBuilder widgetBuilder() {
    return (context) => Center(child: Card(child: OscMonitor(connection)));
  }

  @override
  toInitData() {
    return OscMonitorWindow.toInitData(connection);
  }
}

class OscMonitor extends StatefulWidget {
  final Connection connection;

  OscMonitor(this.connection);

  @override
  State<OscMonitor> createState() => _OscMonitorState();
}

class _OscMonitorState extends State<OscMonitor> {
  List<MonitorOscResponse> events = [];
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    var connections = context.read<ConnectionsApi>();
    subscription = connections.monitorOscConnection(widget.connection.osc.connectionId).listen((event) {
      setState(() => events.add(event));
    });
  }


  @override
  void dispose() {
    this.subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Panel(label: "Osc Messages".i18n, child: SingleChildScrollView(
      child: MizerTable(
        columnWidths: {
          1: FixedColumnWidth(128),
          2: FixedColumnWidth(512),
        },
        columns: [
          Text("Path".i18n),
          Text("Arguments".i18n),
        ],
        rows: events.reversed.map((event) => MizerTableRow(
          cells: [
            Text(event.path),
            Text(event.args.map((e) {
              if (e.hasFloat()) {
                return e.float.toString();
              }
              if (e.hasDouble_4()) {
                return e.double_4.toString();
              }
              if (e.hasBool_5()) {
                return e.bool_5.toString();
              }
              if (e.hasColor()) {
                return "RGB(${e.color.red}, ${e.color.green}, ${e.color.blue})";
              }
              if (e.hasInt_1()) {
                return e.int_1.toString();
              }
              if (e.hasLong()) {
                return e.long.toString();
              }
            }).join(", ")),
          ]
        )).toList(),
      ),
    ));
  }
}
