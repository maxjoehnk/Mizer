import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

import 'package:mizer/widgets/popup/ast.dart';

class PopupValueInput extends StatefulWidget {
  final CueValue? value;
  final void Function(CueValue)? onEnter;
  final bool allowRange;

  const PopupValueInput({this.value, this.onEnter, this.allowRange = false, Key? key}) : super(key: key);

  @override
  State<PopupValueInput> createState() => _PopupValueInputState();
}

class _PopupValueInputState extends State<PopupValueInput> {
  late final Map<LogicalKeyboardKey, void Function(BuildContext)> keyMappings;

  ValueAst _ast = ValueAst([]);

  _PopupValueInputState() {
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
      LogicalKeyboardKey.delete: (context) => setState(() => _ast.clear()),
      LogicalKeyboardKey.clear: (context) => setState(() => _ast.clear()),
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
      width: 286,
      height: 320,
      child: Focus(
        autofocus: true,
        onKey: (node, event) {
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
        ]),
      ),
    );
  }

  _push(ValueAstNode node) {
    setState(() {
      _ast.push(node);
    });
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
    return Hoverable(
      onTap: onTap,
      builder: (hovered) => Container(
          margin: const EdgeInsets.all(2),
          height: 48,
          width: 48,
          child: Center(child: Text("$number")),
          color: hovered ? Colors.white38 : Colors.white24),
    );
  }
}

class Pad extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool wide;

  const Pad(this.text, this.onTap, {this.wide = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: this.onTap,
      builder: (hovered) => Container(
          margin: const EdgeInsets.all(2),
          height: 48,
          width: wide ? 100 : 48,
          child: Center(child: Text("$text")),
          color: hovered ? Colors.white38 : Colors.white24),
    );
  }
}
