import 'package:flutter/material.dart' hide View, NavigationBar, Route;
import 'package:mizer/shell/menu.dart';
import 'package:mizer/panes/console/console_pane.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/navigation_bloc.dart';
import 'package:mizer/shell/status_bar.dart';

import '../consts.dart';
import '../panes/programmer/programmer_view.dart';
import '../panes/selection/selection_pane.dart';
import 'navigation_bar.dart';
import 'transport/transport_controls.dart';
import 'view_router.dart';

const double SHEET_SIZE = 150;
const double SHEET_PADDING = 0;
const double TAB_STRIP_HEIGHT = 32;
const double BOTTOM_PANE_CONTAINER_HEIGHT = SHEET_SIZE + TAB_STRIP_HEIGHT + SHEET_PADDING;

class Shell extends StatefulWidget {
  @override
  _ShellState createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  bool _showProgrammer = false;
  bool _showSelection = false;
  bool _showConsole = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Black,
        body: HotkeyConfiguration(
          hotkeySelector: (hotkeys) => hotkeys.global,
          hotkeyMap: _getShortcuts(),
          child: Column(
            children: [
              ApplicationMenu(),
              Expanded(
                child: Row(
                  children: [
                    NavigationBar(),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SafeArea(
                            child: Container(
                                padding: const EdgeInsets.all(
                                  PANEL_GAP_SIZE
                                ),
                                child: ViewRouter(),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration()),
                          ),
                        ),
                        if (_showConsole)
                          SizedBox(
                              height: BOTTOM_PANE_CONTAINER_HEIGHT,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 2,
                                  right: 2,
                                  bottom: 2,
                                ),
                                child: ConsolePane(),
                              )),
                        if (_showSelection)
                          SizedBox(
                              height: BOTTOM_PANE_CONTAINER_HEIGHT,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 2,
                                  right: 2,
                                  bottom: 2,
                                ),
                                child: SelectionPane(),
                              )),
                        if (_showProgrammer)
                          SizedBox(
                              height: BOTTOM_PANE_CONTAINER_HEIGHT,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 2,
                                  right: 2,
                                  bottom: 2,
                                ),
                                child: ProgrammerView(),
                              )),
                        RepaintBoundary(
                            child: TransportControls(
                          showProgrammer: _showProgrammer,
                          toggleProgrammer: () => _toggleProgrammerPane(),
                          showSelection: _showSelection,
                          toggleSelection: () => _toggleSelectionPane(),
                          showConsole: _showConsole,
                          toggleConsole: () => _toggleConsolePane(),
                        )),
                      ],
                    ))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              RepaintBoundary(
                child: StatusBar(),
              )
            ],
          ),
        ));
  }

  void _toggleSelectionPane() {
    return setState(() {
      _showSelection = !_showSelection;
      _showProgrammer = false;
      _showConsole = false;
    });
  }

  void _toggleProgrammerPane() {
    return setState(() {
      _showProgrammer = !_showProgrammer;
      _showSelection = false;
      _showConsole = false;
    });
  }

  void _toggleConsolePane() {
    return setState(() {
      _showConsole = !_showConsole;
      _showSelection = false;
      _showProgrammer = false;
    });
  }

  Map<String, Function()> _getShortcuts() {
    Map<String, Function()> shortcuts = {
      'programmer_pane': () => _toggleProgrammerPane(),
      'selection_pane': () => _toggleSelectionPane(),
      'console_pane': () => _toggleConsolePane(),
    };
    for (int i = 0; i < 15; i++) {
      var hotkey = 'view_${i + 1}';
      shortcuts[hotkey] = () => context.navigate(MizerViewRoute(index: i));
    }
    return shortcuts;
  }
}
