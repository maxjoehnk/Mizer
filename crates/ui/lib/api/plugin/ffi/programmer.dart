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
  FFIFixtureFaderControl.PointAt: FixtureControl.POINT_AT,
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
    var selection = _readGroupedFixtureSelection(state.selection);
    var channels = _readProgrammerChannel(state.channels);
    var activeGroups = _readGroupSelection(state.active_groups);
    var effects = _readEffects(state.effects);

    return ProgrammerState(
      activeFixtures: activeFixtures,
      activeGroups: activeGroups,
      fixtures: fixtures,
      selection: selection,
      controls: channels,
      highlight: state.highlight == 1,
      blockSize: state.block_size,
      groups: state.groups,
      wings: state.wings,
      effects: effects,
    );
  }

  List<FixtureId> _readFixtureSelection(Array_FFIFixtureId result) {
    var fixtures = new List.generate(result.len, (index) => result.array.elementAt(index).ref);

    return fixtures.map((id) {
      if (id.sub_fixture_id != 0) {
        return FixtureId(
            subFixture: SubFixtureId(fixtureId: id.fixture_id, childId: id.sub_fixture_id));
      }
      return FixtureId(fixture: id.fixture_id);
    }).toList();
  }

  List<int> _readGroupSelection(Array_u32 result) {
    var groups = new List.generate(result.len, (index) => result.array.elementAt(index).value);

    return groups;
  }

  FixtureSelection _readGroupedFixtureSelection(Array_Array_FFIFixtureId result) {
    var groups = new List.generate(result.len, (index) => result.array.elementAt(index).ref);

    var fixtures = groups.map((fixtures) => _readFixtureSelection(fixtures)).toList();

    return FixtureSelection(
        fixtures: fixtures.map((f) => FixtureSelection_GroupedFixtureList(fixtures: f)).toList());
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
      } else if (channel.control == FFIFixtureFaderControl.Generic) {
        result.generic = ProgrammerChannel_GenericValue(
          name: channel.value.generic.channel.cast<Utf8>().toDartString(),
          value: channel.value.generic.value,
        );
      } else if (channel.control == FFIFixtureFaderControl.PointAt) {
        result.world = WorldPosition(
          x: channel.value.world.x,
          y: channel.value.world.y,
          z: channel.value.world.z,
        );
      } else {
        result.fader = channel.value.fader;
      }
      return result;
    }).toList();
  }

  List<EffectProgrammerState> _readEffects(Array_FFIEffectProgrammerState result) {
    var effects = new List.generate(result.len, (index) => result.array.elementAt(index).ref);

    return effects.map((effect) {
      return EffectProgrammerState(
        effectId: effect.effect_id,
        effectRate: effect.rate,
        effectOffset: effect.has_offset == 1 ? effect.effect_offset : null,
      );
    }).toList();
  }

  void dispose() {
    this._bindings.drop_programmer_pointer(_ptr);
  }
}
