import 'package:flutter/widgets.dart';
import 'package:mizer/dialogs/backend_dialog_controller.dart';
import 'package:mizer/session/window_title_updater.dart';
import 'package:mizer/widgets/global_hotkeys.dart';
import 'package:nativeshell/nativeshell.dart';

import '../home.dart';
import 'base_window_state.dart';

const double WIDTH = 800;
const double HEIGHT = 700;

class MainWindowState extends WindowState {
  @override
  Widget build(BuildContext context) {
    return BaseWindowState(
      child: WindowLayoutProbe(
        child: LanguageSwitcher(
          child: GlobalHotkeyConfiguration(
            child: BackendDialogController(
              child: WindowTitleUpdater(
                child: Home(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  WindowSizingMode get windowSizingMode => WindowSizingMode.atLeastIntrinsicSize;

  @override
  Future<void> initializeWindow(Size intrinsicSize) async {
    await window.setTitle("Mizer");
    Size contentSize = Size(intrinsicSize.width > WIDTH ? intrinsicSize.width : WIDTH,
        intrinsicSize.height > HEIGHT ? intrinsicSize.height : HEIGHT);
    await window.setGeometry(Geometry(minFrameSize: Size(WIDTH, HEIGHT), minContentSize: contentSize));
    await window.show();
    await window.setMaximized(true);
  }
}
