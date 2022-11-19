import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

int getFraction(double number, int digits) => (number % 1 * pow(10, digits)).floor();

class ValueAst {
  List<ValueAstNode> nodes;
  bool isBeats;

  ValueAst(this.nodes, { this.isBeats = false });

  factory ValueAst.fromTimer(CueTimer? timer) {
    if (timer == null) {
      return ValueAst([]);
    }
    if (timer.hasDirect()) {
      var value = timer.direct.hasSeconds() ? timer.direct.seconds : timer.direct.beats;
      return ValueAst([Value(value.truncate(), fractions: getFraction(value, 2))], isBeats: timer.direct.hasBeats());
    } else {
      var from = timer.range.from.hasSeconds() ? timer.range.from.seconds : timer.range.from.beats;
      var to = timer.range.to.hasSeconds() ? timer.range.to.seconds : timer.range.to.beats;

      return ValueAst([
        Value(from.truncate(), fractions: getFraction(from, 2)),
        Thru(),
        Value(to.truncate(), fractions: getFraction(to, 2))
      ], isBeats: timer.range.from.hasBeats());
    }
  }

  String toDisplay() {
    return nodes.map((node) => node.toDisplay()).join(" ");
  }

  void push(ValueAstNode node) {
    if (nodes.isNotEmpty && nodes.last.canJoin(node)) {
      nodes.last.join(node);
    } else {
      nodes.add(node);
    }
  }

  void clear() {
    nodes = [];
  }

  CueTimer? build() {
    if (nodes.firstWhereOrNull((node) => node is Thru) != null && nodes.length == 3) {
      var from = nodes[0] as Value;
      var to = nodes[2] as Value;
      return CueTimer(range: CueTimerRange(from: from.getTime(isBeats), to: to.getTime(isBeats)));
    } else if (nodes.length == 1) {
      var value = nodes[0] as Value;
      return CueTimer(direct: value.getTime(isBeats));
    }

    return null;
  }
}

abstract class ValueAstNode {
  String toDisplay();

  bool canJoin(ValueAstNode node);

  void join(covariant ValueAstNode node);
}

class Value implements ValueAstNode {
  int? value;
  int? fractions;
  bool dot;

  Value(this.value, {this.dot = false, this.fractions}) {
    if (this.fractions != null) {
      this.dot = true;
    }
  }

  factory Value.dot() {
    return Value(null, dot: true);
  }

  double get val {
    return double.parse(toDisplay());
  }

  CueTime getTime(bool isBeats) {
    if (isBeats) {
      return CueTime(beats: val);
    } else {
      return CueTime(seconds: val);
    }
  }

  @override
  String toDisplay() {
    return "$value${dot ? "." : ""}${fractions ?? ""}";
  }

  @override
  bool canJoin(ValueAstNode node) {
    return node is Value;
  }

  @override
  void join(covariant Value node) {
    if (node.dot) {
      dot = true;
    }
    if (node.value != null) {
      if (dot) {
        fractions = int.parse("${fractions ?? ""}${node.value}").toInt();
      } else {
        value = int.parse("${value ?? ""}${node.value}").toInt();
      }
    }
  }
}

class Thru implements ValueAstNode {
  @override
  String toDisplay() {
    return "..";
  }

  @override
  bool canJoin(ValueAstNode node) {
    return false;
  }

  @override
  void join(ValueAstNode node) {}
}

class PopupTimeInput extends StatefulWidget {
  final void Function(CueTimer?)? onEnter;
  final CueTimer? timer;

  const PopupTimeInput({this.onEnter, this.timer, Key? key}) : super(key: key);

  @override
  State<PopupTimeInput> createState() => _PopupTimeInputState();
}

class _PopupTimeInputState extends State<PopupTimeInput> {
  late final Map<LogicalKeyboardKey, void Function(BuildContext)> keyMappings;

  late ValueAst _ast;

  _PopupTimeInputState() {
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
      LogicalKeyboardKey.numpadDivide: (context) => _push(Thru()),
      LogicalKeyboardKey.numpadComma: (context) => _push(Value.dot()),
      LogicalKeyboardKey.comma: (context) => _push(Value.dot()),
      LogicalKeyboardKey.period: (context) => _push(Value.dot()),
      LogicalKeyboardKey.delete: (context) => setState(() => _ast.clear()),
      LogicalKeyboardKey.clear: (context) => setState(() => _ast.clear()),
      LogicalKeyboardKey.enter: _build,
      LogicalKeyboardKey.numpadEnter: _build,
      LogicalKeyboardKey.keyB: (context) => setState(() => _ast.isBeats = true),
      LogicalKeyboardKey.keyS: (context) => setState(() => _ast.isBeats = false),
      LogicalKeyboardKey.escape: (context) => Navigator.of(context).pop(),
    };
  }

  @override
  void initState() {
    super.initState();
    _ast = ValueAst.fromTimer(widget.timer);
  }

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
      title: "Enter Time",
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
        child: Column(children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 48,
                      color: Colors.black45,
                      child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(_ast.toDisplay()))),
                ),
                Column(children: [
                  _timeMode(true, "Beats"),
                  _timeMode(false, "Seconds"),
                ])
              ]),
          Row(children: [
            Pad("7", () => _push(Value(7))),
            Pad("8", () => _push(Value(8))),
            Pad("0", () => _push(Value(0))),
            Pad("Thru", () => _push(Thru()), wide: true),
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

  Widget _timeMode(bool isBeats, String label) {
    return Hoverable(
        onTap: () => setState(() => _ast.isBeats = isBeats),
        builder: (hovered) => Container(
            width: 64,
            padding: const EdgeInsets.all(2),
            child: Text(label, textAlign: TextAlign.end),
            color: isBeats == _ast.isBeats ? Colors.white24 : Colors.black12));
  }

  _push(ValueAstNode node) {
    setState(() {
      _ast.push(node);
    });
  }

  _build(BuildContext context) {
    CueTimer? value = _ast.build();
    Navigator.of(context).pop(value);
    if (widget.onEnter != null) {
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
