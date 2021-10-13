import 'package:flutter/services.dart';

const Map<String, LogicalKeyboardKey> keyMappings = {
  "ctrl": LogicalKeyboardKey.controlLeft,
  "alt": LogicalKeyboardKey.altLeft,
  "shift": LogicalKeyboardKey.shiftLeft,
  "0": LogicalKeyboardKey.digit0,
  "1": LogicalKeyboardKey.digit1,
  "2": LogicalKeyboardKey.digit2,
  "3": LogicalKeyboardKey.digit3,
  "4": LogicalKeyboardKey.digit4,
  "5": LogicalKeyboardKey.digit5,
  "6": LogicalKeyboardKey.digit6,
  "7": LogicalKeyboardKey.digit7,
  "8": LogicalKeyboardKey.digit8,
  "9": LogicalKeyboardKey.digit9,
  "a": LogicalKeyboardKey.keyA,
  "b": LogicalKeyboardKey.keyB,
  "c": LogicalKeyboardKey.keyC,
  "d": LogicalKeyboardKey.keyD,
  "e": LogicalKeyboardKey.keyE,
  "f": LogicalKeyboardKey.keyF,
  "g": LogicalKeyboardKey.keyG,
  "h": LogicalKeyboardKey.keyH,
  "i": LogicalKeyboardKey.keyI,
  "j": LogicalKeyboardKey.keyJ,
  "k": LogicalKeyboardKey.keyK,
  "l": LogicalKeyboardKey.keyL,
  "m": LogicalKeyboardKey.keyM,
  "n": LogicalKeyboardKey.keyN,
  "o": LogicalKeyboardKey.keyO,
  "p": LogicalKeyboardKey.keyP,
  "q": LogicalKeyboardKey.keyQ,
  "r": LogicalKeyboardKey.keyR,
  "s": LogicalKeyboardKey.keyS,
  "t": LogicalKeyboardKey.keyT,
  "u": LogicalKeyboardKey.keyU,
  "v": LogicalKeyboardKey.keyV,
  "w": LogicalKeyboardKey.keyW,
  "x": LogicalKeyboardKey.keyX,
  "y": LogicalKeyboardKey.keyY,
  "z": LogicalKeyboardKey.keyZ,
  "f1": LogicalKeyboardKey.f1,
  "f2": LogicalKeyboardKey.f2,
  "f3": LogicalKeyboardKey.f3,
  "f4": LogicalKeyboardKey.f4,
  "f5": LogicalKeyboardKey.f5,
  "f6": LogicalKeyboardKey.f6,
  "f7": LogicalKeyboardKey.f7,
  "f8": LogicalKeyboardKey.f8,
  "f9": LogicalKeyboardKey.f9,
  "f10": LogicalKeyboardKey.f10,
  "f11": LogicalKeyboardKey.f11,
  "f12": LogicalKeyboardKey.f12,
  "esc": LogicalKeyboardKey.escape,
  "insert": LogicalKeyboardKey.insert,
  "delete": LogicalKeyboardKey.delete,
  "home": LogicalKeyboardKey.home,
  "end": LogicalKeyboardKey.end,
  "pgUp": LogicalKeyboardKey.pageUp,
  "pgDown": LogicalKeyboardKey.pageDown,
  "down": LogicalKeyboardKey.arrowDown,
  "up": LogicalKeyboardKey.arrowUp,
  "left": LogicalKeyboardKey.arrowLeft,
  "right": LogicalKeyboardKey.arrowRight,
};

Set<LogicalKeyboardKey> convertKeyMap(String value) {
  var hotkey = value
      .split("+")
      .map((e) => keyMappings[e.trim()])
      .where((element) => element != null)
      .map((e) => e!)
      .toSet();

  return hotkey;
}
