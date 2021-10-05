import 'package:flutter/widgets.dart';
import 'package:nativeshell/nativeshell.dart';

import '../navigation.dart';
import 'base_window_state.dart';

class MainWindowState extends WindowState {
  @override
  Widget build(BuildContext context) {
    return BaseWindowState(child: WindowLayoutProbe(child: Home()));
  }

  @override
  WindowSizingMode get windowSizingMode => WindowSizingMode.atLeastIntrinsicSize;

  @override
  Future<void> initializeWindow(Size contentSize) {
    window.setTitle("Mizer");
    return super.initializeWindow(contentSize);
  }
}
