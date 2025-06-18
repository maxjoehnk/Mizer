import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:mizer/windows/midi_monitor_window.dart';
import 'package:provider/provider.dart';

class MidiMonitorDialog implements DialogBuilder {
  final Connection connection;

  MidiMonitorDialog(this.connection);

  @override
  WidgetBuilder widgetBuilder() {
    return (context) => Center(child: Card(child: MidiMonitor(connection)));
  }

  @override
  toInitData() {
    return MidiMonitorWindow.toInitData(connection);
  }
}

class MidiMonitor extends StatefulWidget {
  final Connection connection;

  MidiMonitor(this.connection);

  @override
  State<MidiMonitor> createState() => _MidiMonitorState();
}

class _MidiMonitorState extends State<MidiMonitor> {
  List<MonitorMidiResponse> events = [];
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    var connections = context.read<ConnectionsApi>();
    subscription = connections.monitorMidiConnection(widget.connection.name).listen((event) {
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
    return Panel(
        label: "Midi Messages".i18n,
        child: MizerTable(
          columnWidths: {
            0: FixedColumnWidth(128),
            1: FixedColumnWidth(128),
            2: FixedColumnWidth(128),
            3: FixedColumnWidth(128),
            4: FixedColumnWidth(128),
          },
          columns: [
            Text("Timestamp".i18n),
            Text("Event".i18n),
            Text("Channel".i18n),
            Text("Note".i18n),
            Text("Value".i18n),
            Text("Data".i18n),
          ],
          rows: events.reversed
              .map((event) => MizerTableRow(cells: [
                    Text(event.timestamp.toInt().toString()),
                    Text(_getEventType(event)),
                    Text(_getChannel(event)),
                    Text(_getNote(event)),
                    Text(_getValue(event)),
                    Text(_getData(event)),
                  ]))
              .toList(),
        ));
  }

  String _getEventType(MonitorMidiResponse event) {
    switch (event.whichMessage()) {
      case MonitorMidiResponse_Message.cc:
        return "CC".i18n;
      case MonitorMidiResponse_Message.noteOn:
        return "Note On".i18n;
      case MonitorMidiResponse_Message.noteOff:
        return "Note Off".i18n;
      case MonitorMidiResponse_Message.sysEx:
        return "SysEx".i18n;
      default:
        return "Unknown".i18n;
    }
  }

  String _getChannel(MonitorMidiResponse event) {
    switch (event.whichMessage()) {
      case MonitorMidiResponse_Message.cc:
        return (event.cc.channel + 1).toString();
      case MonitorMidiResponse_Message.noteOn:
        return (event.noteOn.channel + 1).toString();
      case MonitorMidiResponse_Message.noteOff:
        return (event.noteOff.channel + 1).toString();
      default:
        return "";
    }
  }

  String _getNote(MonitorMidiResponse event) {
    switch (event.whichMessage()) {
      case MonitorMidiResponse_Message.cc:
        return event.cc.note.toString();
      case MonitorMidiResponse_Message.noteOn:
        return event.noteOn.note.toString();
      case MonitorMidiResponse_Message.noteOff:
        return event.noteOff.note.toString();
      default:
        return "";
    }
  }

  String _getValue(MonitorMidiResponse event) {
    switch (event.whichMessage()) {
      case MonitorMidiResponse_Message.cc:
        return event.cc.value.toString();
      case MonitorMidiResponse_Message.noteOn:
        return event.noteOn.value.toString();
      case MonitorMidiResponse_Message.noteOff:
        return event.noteOff.value.toString();
      default:
        return "";
    }
  }

  String _getData(MonitorMidiResponse event) {
    switch (event.whichMessage()) {
      case MonitorMidiResponse_Message.sysEx:
        return event.sysEx.data.map((e) => e.toString().padLeft(2, "0")).join(" ");
      case MonitorMidiResponse_Message.unknown:
        return event.unknown.map((e) => e.toString().padLeft(2, "0")).join(" ");
      default:
        return "";
    }
  }
}
