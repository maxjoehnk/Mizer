import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const letters = [
  LogicalKeyboardKey.keyA,
  LogicalKeyboardKey.keyB,
  LogicalKeyboardKey.keyC,
  LogicalKeyboardKey.keyD,
  LogicalKeyboardKey.keyE,
  LogicalKeyboardKey.keyF,
  LogicalKeyboardKey.keyG,
  LogicalKeyboardKey.keyH,
  LogicalKeyboardKey.keyI,
  LogicalKeyboardKey.keyJ,
  LogicalKeyboardKey.keyK,
  LogicalKeyboardKey.keyL,
  LogicalKeyboardKey.keyM,
  LogicalKeyboardKey.keyN,
  LogicalKeyboardKey.keyO,
  LogicalKeyboardKey.keyP,
  LogicalKeyboardKey.keyQ,
  LogicalKeyboardKey.keyR,
  LogicalKeyboardKey.keyS,
  LogicalKeyboardKey.keyT,
  LogicalKeyboardKey.keyU,
  LogicalKeyboardKey.keyV,
  LogicalKeyboardKey.keyW,
  LogicalKeyboardKey.keyX,
  LogicalKeyboardKey.keyY,
  LogicalKeyboardKey.keyZ,
];

class TextFieldFocus extends StatelessWidget {
  final Widget child;

  const TextFieldFocus({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextEditingShortcuts(
      child: Shortcuts(
        shortcuts: {
          ...Map.fromEntries(letters.map((letter) => MapEntry(
              SingleActivator(letter, shift: true), DoNothingAndStopPropagationTextIntent()))),
        },
        child: child,
      ),
    );
  }
}
