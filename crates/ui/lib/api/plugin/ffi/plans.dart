import 'dart:ffi' as ffi;

import 'package:flutter/widgets.dart' as widgets;
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/layouts.pb.dart';

import 'bindings.dart';
import 'ffi_pointer.dart';

class FixtureState {
  final double? brightness;
  final Color? color;

  FixtureState({this.brightness, this.color});

  widgets.Color getColor() {
    if (this.brightness == null && this.color == null) {
      return widgets.Color(0x000000);
    }

    var color = this.color ?? Color(red: 1, green: 1, blue: 1);
    var brightness = this.brightness ?? 1;
    color.red *= brightness;
    color.green *= brightness;
    color.blue *= brightness;

    return widgets.Color.fromRGBO(
        (color.red * 255).toInt(), (color.green * 255).toInt(), (color.blue * 255).toInt(), 1);
  }
}

class FixturesRefPointer extends FFIPointer<FixturesRef> {
  final FFIBindings _bindings;

  FixturesRefPointer(this._bindings, ffi.Pointer<FixturesRef> ptr) : super(ptr);

  FixtureState readState(FixtureId fixtureId) {
    FFIFixtureState state;
    if (fixtureId.hasSubFixture()) {
      state = this
          ._bindings
          .read_fixture_state(ptr, fixtureId.subFixture.fixtureId, fixtureId.subFixture.childId);
    } else {
      state = this._bindings.read_fixture_state(ptr, fixtureId.fixture, 0);
    }

    return FixtureState(
      brightness: state.has_brightness == 1 ? state.brightness : null,
      color: state.has_color == 1
          ? Color(red: state.color_red, green: state.color_green, blue: state.color_blue)
          : null,
    );
  }

  @override
  void disposePointer(ffi.Pointer<FixturesRef> _ptr) {
    this._bindings.drop_fixture_pointer(_ptr);
  }
}
