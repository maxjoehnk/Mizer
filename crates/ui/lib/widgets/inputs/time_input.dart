import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/widgets/hoverable.dart';

int getFraction(double number, int digits) => (number % 1 * pow(10, digits)).floor();

class _ValueAst {
  List<_ValueAstNode> nodes;
  bool isBeats;

  _ValueAst(this.nodes, {this.isBeats = true});

  factory _ValueAst.fromTimer(CueTime? time) {
    if (time == null) {
      return _ValueAst([]);
    }
    var value = time.hasSeconds() ? time.seconds : time.beats;
    return _ValueAst([_Value(value.truncate(), fractions: getFraction(value, 2))],
        isBeats: time.hasBeats());
  }

  String toDisplay() {
    return nodes.map((node) => node.toDisplay()).join(" ");
  }

  void push(_ValueAstNode node) {
    if (nodes.isNotEmpty && nodes.last.canJoin(node)) {
      nodes.last.join(node);
    } else {
      nodes.add(node);
    }
  }

  void clear() {
    nodes = [];
  }

  CueTime? build() {
    if (nodes.isEmpty) {
      return null;
    }
    var value = nodes[0] as _Value;
    return value.getTime(isBeats);
  }
}

abstract class _ValueAstNode {
  String toDisplay();

  bool canJoin(_ValueAstNode node);

  void join(covariant _ValueAstNode node);
}

class _Value implements _ValueAstNode {
  int? value;
  int? fractions;
  bool dot;

  _Value(this.value, {this.dot = false, this.fractions}) {
    if (this.fractions != null) {
      this.dot = true;
    }
  }

  factory _Value.dot() {
    return _Value(null, dot: true);
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
  bool canJoin(_ValueAstNode node) {
    return node is _Value;
  }

  @override
  void join(covariant _Value node) {
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

class DirectTimeInput extends StatefulWidget {
  final void Function(CueTime?)? onEnter;
  final CueTime? time;
  final bool allowSeconds;
  final bool allowBeats;
  final bool autofocus;

  const DirectTimeInput(
      {this.onEnter,
      this.time,
      this.allowSeconds = true,
      this.allowBeats = true,
      this.autofocus = false,
      Key? key})
      : super(key: key);

  @override
  State<DirectTimeInput> createState() => _DirectTimeInputState();
}

class _DirectTimeInputState extends State<DirectTimeInput> {
  late final Map<LogicalKeyboardKey, void Function(BuildContext)> keyMappings;

  late _ValueAst _ast;

  _DirectTimeInputState() {
    keyMappings = {
      LogicalKeyboardKey.numpad0: (context) => _push(_Value(0)),
      LogicalKeyboardKey.digit0: (context) => _push(_Value(0)),
      LogicalKeyboardKey.numpad1: (context) => _push(_Value(1)),
      LogicalKeyboardKey.digit1: (context) => _push(_Value(1)),
      LogicalKeyboardKey.numpad2: (context) => _push(_Value(2)),
      LogicalKeyboardKey.digit2: (context) => _push(_Value(2)),
      LogicalKeyboardKey.numpad3: (context) => _push(_Value(3)),
      LogicalKeyboardKey.digit3: (context) => _push(_Value(3)),
      LogicalKeyboardKey.numpad4: (context) => _push(_Value(4)),
      LogicalKeyboardKey.digit4: (context) => _push(_Value(4)),
      LogicalKeyboardKey.numpad5: (context) => _push(_Value(5)),
      LogicalKeyboardKey.digit5: (context) => _push(_Value(5)),
      LogicalKeyboardKey.numpad6: (context) => _push(_Value(6)),
      LogicalKeyboardKey.digit6: (context) => _push(_Value(6)),
      LogicalKeyboardKey.numpad7: (context) => _push(_Value(7)),
      LogicalKeyboardKey.digit7: (context) => _push(_Value(7)),
      LogicalKeyboardKey.numpad8: (context) => _push(_Value(8)),
      LogicalKeyboardKey.digit8: (context) => _push(_Value(8)),
      LogicalKeyboardKey.numpad9: (context) => _push(_Value(9)),
      LogicalKeyboardKey.digit9: (context) => _push(_Value(9)),
      LogicalKeyboardKey.numpadComma: (context) => _push(_Value.dot()),
      LogicalKeyboardKey.comma: (context) => _push(_Value.dot()),
      LogicalKeyboardKey.period: (context) => _push(_Value.dot()),
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
    _ast = _ValueAst.fromTimer(widget.time);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.autofocus,
      onKey: (node, event) {
        if (keyMappings.containsKey(event.logicalKey) && event.isKeyPressed(event.logicalKey)) {
          keyMappings[event.logicalKey]!(context);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Column(children: [
        Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 48,
                color: Colors.black45,
                child: Align(
                    alignment: AlignmentDirectional.centerStart, child: Text(_ast.toDisplay()))),
          ),
          Column(children: [
            if (widget.allowBeats) _timeMode(true, "Beats"),
            if (widget.allowSeconds) _timeMode(false, "Seconds"),
          ])
        ]),
        Row(children: [
          _Pad("7", () => _push(_Value(7))),
          _Pad("8", () => _push(_Value(8))),
          _Pad("0", () => _push(_Value(0))),
        ]),
        Row(children: [
          _Pad("4", () => _push(_Value(4))),
          _Pad("5", () => _push(_Value(5))),
          _Pad("6", () => _push(_Value(6))),
          _Pad("Clear", () => setState(() => _ast.clear()), wide: true),
        ]),
        Row(children: [
          _Pad("1", () => _push(_Value(1))),
          _Pad("2", () => _push(_Value(2))),
          _Pad("3", () => _push(_Value(3))),
        ]),
        Row(children: [
          _Pad("0", () => _push(_Value(0)), wide: true),
          _Pad(".", () => _push(_Value.dot())),
          _Pad("Enter", () => _build(context), wide: true),
        ]),
      ]),
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

  _push(_ValueAstNode node) {
    setState(() {
      _ast.push(node);
    });
  }

  _build(BuildContext context) {
    CueTime? value = _ast.build();
    if (widget.onEnter != null) {
      widget.onEnter!(value);
    }
  }
}

class _Pad extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool wide;

  const _Pad(this.text, this.onTap, {this.wide = false, Key? key}) : super(key: key);

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
