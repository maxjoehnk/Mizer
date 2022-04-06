import 'package:flutter/material.dart';
import 'package:mizer/views/preferences/preferences.dart';
import 'package:mizer/windows/base_window_state.dart';
import 'package:nativeshell/nativeshell.dart';

final windowClass = 'PreferencesWindow';

class PreferencesWindow extends WindowState {
  @override
  Widget build(BuildContext context) {
    return BaseWindowState(child: WindowLayoutProbe(child: Scaffold(body: PreferencesView())));
  }

  @override
  WindowSizingMode get windowSizingMode => WindowSizingMode.manual;

  static dynamic toInitData() => {'class': windowClass};

  static PreferencesWindow? fromInitData(dynamic initData) {
    if (initData is Map && initData['class'] == windowClass) {
      return PreferencesWindow();
    }
    return null;
  }

  @override
  Future<void> initializeWindow(Size contentSize) {
    window.setTitle("Preferences");
    window.setGeometry(Geometry(minContentSize: Size(600, 700)));
    return super.initializeWindow(contentSize);
  }
}
