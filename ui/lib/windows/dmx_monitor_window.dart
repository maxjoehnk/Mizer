import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/dialogs/dmx_monitor.dart';
import 'package:mizer/windows/base_window_state.dart';
import 'package:nativeshell/nativeshell.dart';

final windowClass = 'DmxMonitorWindow';

class DmxMonitorWindow extends WindowState {
  final Connection connection;

  DmxMonitorWindow(this.connection);

  @override
  Widget build(BuildContext context) {
    return BaseWindowState(child: Scaffold(body: DmxMonitor(connection)));
  }

  @override
  WindowSizingMode get windowSizingMode => WindowSizingMode.atLeastIntrinsicSize;

  static dynamic toInitData(Connection connection) =>
      {'class': windowClass, 'connection': connection.writeToBuffer()};

  static DmxMonitorWindow? fromInitData(dynamic initData) {
    if (initData is Map && initData['class'] == windowClass) {
      return DmxMonitorWindow(Connection.fromBuffer(initData['connection']));
    }
    return null;
  }

  @override
  Future<void> initializeWindow(Size contentSize) {
    window.setTitle("DMX Monitor (${connection.name})");
    return super.initializeWindow(contentSize);
  }
}
