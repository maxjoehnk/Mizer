import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/panes/programmer/sheets/fixture_group_control.dart';
import 'package:mizer/views/presets/preset_group.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/popup/popup_container.dart';
import 'package:mizer/widgets/tabs.dart';

import 'ast.dart';

class PopupProgrammerInput extends StatefulWidget {
  final CueValue? value;
  final void Function(CueValue)? onEnter;
  final bool allowRange;
  final List<Preset>? globalPresets;
  final List<ControlPreset>? controlPresets;

  const PopupProgrammerInput(
      {this.value,
      this.onEnter,
      this.allowRange = false,
      Key? key,
      this.globalPresets,
      this.controlPresets})
      : super(key: key);

  @override
  State<PopupProgrammerInput> createState() => _PopupProgrammerInputState();
}

class _PopupProgrammerInputState extends State<PopupProgrammerInput> {
  late final Map<LogicalKeyboardKey, void Function(BuildContext)> keyMappings;

  ValueAst _ast = ValueAst([]);

  _PopupProgrammerInputState() {
    keyMappings = {
      LogicalKeyboardKey.numpad0: (context) => _push(Value(0)),
      LogicalKeyboardKey.digit0: (context) => _push(Value(0)),
      LogicalKeyboardKey.numpad1: (context) => _push(Value(1)),
      LogicalKeyboardKey.digit1: (context) => _push(Value(1)),
      LogicalKeyboardKey.numpad2: (context) => _push(Value(2)),
      LogicalKeyboardKey.digit2: (context) => _push(Value(2)),
      LogicalKeyboardKey.numpad3: (context) => _push(Value(3)),
      LogicalKeyboardKey.digit3: (context) => _push(Value(3)),
      LogicalKeyboardKey.numpad4: (context) => _push(Value(4)),
      LogicalKeyboardKey.digit4: (context) => _push(Value(4)),
      LogicalKeyboardKey.numpad5: (context) => _push(Value(5)),
      LogicalKeyboardKey.digit5: (context) => _push(Value(5)),
      LogicalKeyboardKey.numpad6: (context) => _push(Value(6)),
      LogicalKeyboardKey.digit6: (context) => _push(Value(6)),
      LogicalKeyboardKey.numpad7: (context) => _push(Value(7)),
      LogicalKeyboardKey.digit7: (context) => _push(Value(7)),
      LogicalKeyboardKey.numpad8: (context) => _push(Value(8)),
      LogicalKeyboardKey.digit8: (context) => _push(Value(8)),
      LogicalKeyboardKey.numpad9: (context) => _push(Value(9)),
      LogicalKeyboardKey.digit9: (context) => _push(Value(9)),
      LogicalKeyboardKey.numpadDivide: (context) => widget.allowRange ? _push(Thru()) : null,
      LogicalKeyboardKey.numpadComma: (context) => _push(Value.dot()),
      LogicalKeyboardKey.comma: (context) => _push(Value.dot()),
      LogicalKeyboardKey.period: (context) => _push(Value.dot()),
      LogicalKeyboardKey.delete: (context) => _clear(),
      LogicalKeyboardKey.clear: (context) => _clear(),
      LogicalKeyboardKey.backspace: (context) => _pop(),
      LogicalKeyboardKey.enter: _build,
      LogicalKeyboardKey.numpadEnter: _build,
      LogicalKeyboardKey.escape: (context) => Navigator.of(context).pop(),
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      if (widget.value!.hasDirect()) {
        _ast.push(Value(widget.value!.direct.toInt()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
      title: "Enter Value",
      height: 320,
      child: Focus(
        autofocus: true,
        onKey: (node, event) {
          if (event.isShiftPressed && event.logicalKey == LogicalKeyboardKey.backspace) {
            _clear();
            return KeyEventResult.ignored;
          }
          if (keyMappings.containsKey(event.logicalKey) && event.isKeyPressed(event.logicalKey)) {
            keyMappings[event.logicalKey]!(context);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 48,
              color: Colors.black45,
              child: Align(
                  alignment: AlignmentDirectional.centerStart, child: Text(_ast.toDisplay()))),
          Expanded(
            child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  width: 260,
                  child: Column(children: [
                    Row(children: [
                      Pad("7", () => _push(Value(7))),
                      Pad("8", () => _push(Value(8))),
                      Pad("0", () => _push(Value(0))),
                      if (widget.allowRange) Pad("Thru", () => _push(Thru()), wide: true),
                    ]),
                    Row(children: [
                      Pad("4", () => _push(Value(4))),
                      Pad("5", () => _push(Value(5))),
                      Pad("6", () => _push(Value(6))),
                      Pad("Clear", () => setState(() => _ast.clear()), wide: true),
                    ]),
                    Row(children: [
                      Pad("1", () => _push(Value(1))),
                      Pad("2", () => _push(Value(2))),
                      Pad("3", () => _push(Value(3))),
                    ]),
                    Row(children: [
                      Pad("0", () => _push(Value(0)), wide: true),
                      Pad(".", () => _push(Value.dot())),
                      Pad("Enter", () => _build(context), wide: true),
                    ]),
                  ])),
              SizedBox(
                width: 484,
                child: PopupInputTabs(tabs: [
                  if (!(widget.controlPresets?.isEmpty ?? true))
                    Tab(
                        label: "Fixture Slots",
                        child: FixtureControlPresets(widget.controlPresets!, onSelect: (double v) {
                          setState(() {
                            _ast = ValueAst([Value.fromDouble(v)]);
                          });
                          _build(context);
                        })),
                  if (!(widget.globalPresets?.isEmpty ?? true))
                    Tab(label: "Presets", child: PresetsTab(widget.globalPresets!, onSelect: () => Navigator.of(context).pop())),
                ]),
              )
            ]),
          )
        ]),
      ),
    );
  }

  _push(ValueAstNode node) {
    setState(() {
      _ast.push(node);
    });
  }

  _pop() {
    setState(() {
      _ast.pop();
    });
  }

  _clear() {
    setState(() => _ast.clear());
  }

  _build(BuildContext context) {
    CueValue? value = _ast.build();
    Navigator.of(context).pop(value);
    if (widget.onEnter != null && value != null) {
      widget.onEnter!(value);
    }
  }
}

class NumberPad extends StatelessWidget {
  final int number;
  final void Function() onTap;

  const NumberPad(this.number, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pad("$number", onTap);
  }
}

class Pad extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool wide;
  final bool selected;

  const Pad(this.text, this.onTap, {this.wide = false, this.selected = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: this.onTap,
      builder: (hovered) => Container(
          margin: const EdgeInsets.all(2),
          height: 48,
          width: wide ? 100 : 48,
          child: Center(child: Text("$text")),
          color: _color(hovered)),
    );
  }

  Color _color(bool hovered) {
    if (selected) {
      return Colors.white12;
    }
    return hovered ? Colors.white38 : Colors.white24;
  }
}

class PresetsTab extends StatelessWidget {
  final List<Preset> presets;
  final void Function() onSelect;

  const PresetsTab(this.presets, {super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return PresetList(presets: presets, onSelect: onSelect);
  }
}

class PopupInputTabs extends StatefulWidget {
  final List<Tab> tabs;

  const PopupInputTabs({super.key, required this.tabs});

  @override
  State<PopupInputTabs> createState() => _PopupInputTabsState();
}

class _PopupInputTabsState extends State<PopupInputTabs> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.tabs
                        .mapIndexed((i, e) => Pad(e.label!, () => _onSelectTab(i),
                            wide: true, selected: this.activeIndex == i))
                        .toList()),
              )),
      Expanded(child: active ?? Container()),
    ]);
  }

  Widget? get active {
    if (widget.tabs.isEmpty) {
      return null;
    }
    if (activeIndex >= widget.tabs.length) {
      return null;
    }
    return widget.tabs[activeIndex].child;
  }

  void _onSelectTab(int index) {
    setState(() {
      this.activeIndex = index;
    });
  }
}
