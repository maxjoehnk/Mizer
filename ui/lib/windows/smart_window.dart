import 'package:flutter/material.dart';
import 'package:mizer/views/smart/smart_view.dart';
import 'package:mizer/windows/base_window_state.dart';
import 'package:nativeshell/nativeshell.dart';

final windowClass = 'SmartWindow';

class SmartWindow extends WindowState {
  SmartWindow();

  @override
  Widget build(BuildContext context) {
    return BaseWindowState(child: WindowLayoutProbe(child: LanguageSwitcher(child: Scaffold(body: SmartView()))));
  }

  @override
  WindowSizingMode get windowSizingMode => WindowSizingMode.atLeastIntrinsicSize;

  static dynamic toInitData() =>
      {'class': windowClass};

  static SmartWindow? fromInitData(dynamic initData) {
    if (initData is Map && initData['class'] == windowClass) {
      return SmartWindow();
    }
    return null;
  }

  @override
  Future<void> initializeWindow(Size contentSize) {
    window.setTitle("Smart Window");
    return super.initializeWindow(contentSize);
  }
}
