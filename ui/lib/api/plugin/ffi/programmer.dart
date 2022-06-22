import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/programmer.pb.dart';

import 'bindings.dart';

Map<int, FixtureControl> controlMappings = {
  FFIFixtureFaderControl.Intensity: FixtureControl.INTENSITY,
  FFIFixtureFaderControl.Shutter: FixtureControl.SHUTTER,
  FFIFixtureFaderControl.ColorMixer: FixtureControl.COLOR_MIXER,
  FFIFixtureFaderControl.ColorWheel: FixtureControl.COLOR_WHEEL,
  FFIFixtureFaderControl.Pan: FixtureControl.PAN,
  FFIFixtureFaderControl.Tilt: FixtureControl.TILT,
  FFIFixtureFaderControl.Focus: FixtureControl.FOCUS,
  FFIFixtureFaderControl.Zoom: FixtureControl.ZOOM,
  FFIFixtureFaderControl.Prism: FixtureControl.PRISM,
  FFIFixtureFaderControl.Iris: FixtureControl.IRIS,
  FFIFixtureFaderControl.Frost: FixtureControl.FROST,
  FFIFixtureFaderControl.Gobo: FixtureControl.GOBO,
};

class ProgrammerStatePointer {
  final FFIBindings _bindings;
  final ffi.Pointer<Programmer> _ptr;

  ProgrammerStatePointer(this._bindings, this._ptr);

  ProgrammerState readState() {
    var state = this._bindings.read_programmer_state(_ptr);
    var activeFixtures = _readFixtureSelection(state.active_fixtures);
    var fixtures = _readFixtureSelection(state.fixtures);
    var channels = _readProgrammerChannel(state.channels);

    return ProgrammerState(
      activeFixtures: activeFixtures,
      fixtures: fixtures,
      controls: channels,
      highlight: state.highlight == 1,
    );
  }

  List<FixtureId> _readFixtureSelection(Array_FFIFixtureId result) {
    var fixtures = new List.generate(result.len, (index) => result.array.elementAt(index).ref);

    return fixtures.map((id) {
      if (id.sub_fixture_id != 0) {
        return FixtureId(
            subFixture: SubFixtureId(fixtureId: id.fixture_id, childId: id.sub_fixture_id)
        );
      }
      return FixtureId(fixture: id.fixture_id);
    }).toList();
  }

  List<ProgrammerChannel> _readProgrammerChannel(Array_FFIProgrammerChannel result) {
    var channels = new List.generate(result.len, (index) => result.array.elementAt(index).ref);

    return channels.map((channel) {
      var fixtures = _readFixtureSelection(channel.fixtures);
      var control = controlMappings[channel.control];
      var result = ProgrammerChannel(
          control: control,
          fixtures: fixtures,
      );
      if (channel.control == FFIFixtureFaderControl.ColorMixer) {
        result.color = ColorMixerChannel(
          red: channel.value.color.red,
          green: channel.value.color.green,
          blue: channel.value.color.blue,
        );
      }else if (channel.control == FFIFixtureFaderControl.Generic){
        result.generic = ProgrammerChannel_GenericValue(
          name: channel.value.generic.channel.cast<Utf8>().toDartString(),
          value: channel.value.generic.value,
        );
      }else {
        result.fader = channel.value.fader;
      }
      return result;
    }).toList();
  }

  void dispose() {
    this._bindings.drop_programmer_pointer(_ptr);
  }
}
