import 'package:flutter/widgets.dart';
import 'package:mizer/app.dart';
import 'package:mizer/windows/dmx_monitor_window.dart';
import 'package:mizer/windows/main_window.dart';
import 'package:nativeshell/nativeshell.dart';

void main() async {
  runApp(MizerIntegratedUi());
}

class MizerIntegratedUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MizerApp(child: WindowWidget(onCreateState: (initData) {
      WindowState? state;

      state ??= DmxMonitorWindow.fromInitData(initData);
      state ??= MainWindowState();

      return state;
    }));
  }
}
