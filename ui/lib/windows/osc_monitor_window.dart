import 'package:flutter/material.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/dialogs/osc_monitor.dart';
import 'package:mizer/windows/base_window_state.dart';
import 'package:nativeshell/nativeshell.dart';

final windowClass = 'OscMonitorWindow';

class OscMonitorWindow extends WindowState {
  final Connection connection;

  OscMonitorWindow(this.connection);

  @override
  Widget build(BuildContext context) {
    return BaseWindowState(child: WindowLayoutProbe(child: LanguageSwitcher(child: Scaffold(body: OscMonitor(connection)))));
  }

  @override
  WindowSizingMode get windowSizingMode => WindowSizingMode.atLeastIntrinsicSize;

  static dynamic toInitData(Connection connection) =>
      {'class': windowClass, 'connection': connection.writeToBuffer()};

  static OscMonitorWindow? fromInitData(dynamic initData) {
    if (initData is Map && initData['class'] == windowClass) {
      return OscMonitorWindow(Connection.fromBuffer(initData['connection']));
    }
    return null;
  }

  @override
  Future<void> initializeWindow(Size contentSize) {
    window.setTitle("OSC Monitor (${connection.name})");
    return super.initializeWindow(contentSize);
  }
}
