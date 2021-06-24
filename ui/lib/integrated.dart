import 'package:flutter/widgets.dart';
import 'package:mizer/api/plugin/provider.dart';
import 'package:mizer/app.dart';
import 'package:mizer/navigation.dart';
import 'package:mizer/platform/integrated/platform.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/state/provider.dart';
import 'package:nativeshell/nativeshell.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MizerIntegratedUi());
}

class MizerIntegratedUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MizerApp(child: WindowWidget(onCreateState: (initData) {
      return MainWindowState();
    }));
  }
}

class MainWindowState extends WindowState {
  @override
  Widget build(BuildContext context) {
    return Provider<Platform>(
        create: (_) => IntegratedPlatform(),
        child: PluginApiProvider(child: StateProvider(child: Home())));
  }

  @override
  WindowSizingMode get windowSizingMode => WindowSizingMode.atLeastIntrinsicSize;
}
