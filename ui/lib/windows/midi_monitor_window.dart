import 'package:flutter/material.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/dialogs/midi_monitor.dart';
import 'package:mizer/windows/base_window_state.dart';
import 'package:nativeshell/nativeshell.dart';

final windowClass = 'MidiMonitorWindow';

class MidiMonitorWindow extends WindowState {
  final Connection connection;

  MidiMonitorWindow(this.connection);

  @override
  Widget build(BuildContext context) {
    return BaseWindowState(child: WindowLayoutProbe(child: Scaffold(body: MidiMonitor(connection))));
  }

  @override
  WindowSizingMode get windowSizingMode => WindowSizingMode.atLeastIntrinsicSize;

  static dynamic toInitData(Connection connection) =>
      {'class': windowClass, 'connection': connection.writeToBuffer()};

  static MidiMonitorWindow? fromInitData(dynamic initData) {
    if (initData is Map && initData['class'] == windowClass) {
      return MidiMonitorWindow(Connection.fromBuffer(initData['connection']));
    }
    return null;
  }

  @override
  Future<void> initializeWindow(Size contentSize) {
    window.setTitle("MIDI Monitor (${connection.name})");
    return super.initializeWindow(contentSize);
  }
}
