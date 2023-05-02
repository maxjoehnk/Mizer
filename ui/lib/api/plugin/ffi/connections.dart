import 'dart:ffi' as ffi;

import 'bindings.dart';

class GamepadStatePointer {
  final FFIBindings _bindings;
  final ffi.Pointer<GamepadConnectionRef> _ptr;

  GamepadStatePointer(this._bindings, this._ptr);

  GamepadState readState() {
    var state = this._bindings.read_gamepad_state(_ptr);

    return GamepadState(
      leftStick: GamepadStickState(
          x: state.left_stick_x, y: state.left_stick_y, pressed: state.left_stick > 0),
      rightStick: GamepadStickState(
          x: state.right_stick_x, y: state.right_stick_y, pressed: state.right_stick > 0),
      leftTrigger: state.left_trigger,
      leftShoulder: state.left_shoulder == 1,
      rightTrigger: state.right_trigger,
      rightShoulder: state.right_shoulder == 1,
      south: state.south == 1,
      north: state.north == 1,
      east: state.east == 1,
      west: state.west == 1,
      select: state.select == 1,
      start: state.start == 1,
      mode: state.mode == 1,
      dpad: GamepadDpadState.fromBits(state.dpad),
    );
  }

  void dispose() {
    // this._bindings.drop_gamepad_pointer(_ptr);
  }
}

class GamepadState {
  final GamepadStickState leftStick;
  final GamepadStickState rightStick;
  final double leftTrigger;
  final bool leftShoulder;
  final double rightTrigger;
  final bool rightShoulder;
  final bool south;
  final bool north;
  final bool east;
  final bool west;
  final bool select;
  final bool start;
  final bool mode;
  final GamepadDpadState dpad;

  GamepadState(
      {required this.leftStick,
      required this.rightStick,
      required this.leftTrigger,
      required this.leftShoulder,
      required this.rightTrigger,
      required this.rightShoulder,
      required this.south,
      required this.north,
      required this.east,
      required this.west,
      required this.select,
      required this.start,
      required this.mode,
      required this.dpad});
}

class GamepadStickState {
  final double x;
  final double y;
  final bool pressed;

  GamepadStickState({required this.x, required this.y, this.pressed = false});
}

class GamepadDpadState {
  static const int _UP = 1;
  static const int _RIGHT = 2;
  static const int _DOWN = 4;
  static const int _LEFT = 8;

  final bool up;
  final bool down;
  final bool left;
  final bool right;

  GamepadDpadState(this.up, this.down, this.left, this.right);

  factory GamepadDpadState.fromBits(int bits) {
    return GamepadDpadState(
        isFlag(bits, _UP), isFlag(bits, _DOWN), isFlag(bits, _LEFT), isFlag(bits, _RIGHT));
  }
}

bool isFlag(int bits, int flag) {
  return bits & flag == flag;
}
