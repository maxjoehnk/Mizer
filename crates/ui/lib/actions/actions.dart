import 'package:flutter/widgets.dart';

class OpenViewIntent extends Intent {
  final int viewIndex;

  const OpenViewIntent(this.viewIndex);
}

enum View {
  Layout,
  Plan,
  Nodes,
  Sequencer,
  Effects,
  Programmer,
  Presets,
  Media,
  Connections,
  Surfaces,
  FixturePatch,
  Session,
  History,
  DmxOutput,
  Timecode,
  Preferences,
  MidiProfiles,
  FixtureDefinitions,
}

const ViewHotkeyLabels = {
  View.Layout: "layout_view",
  View.Plan: "plan_view",
  View.Nodes: "nodes_view",
  View.Sequencer: "sequencer_view",
  View.Effects: "effects_view",
  View.Programmer: "programmer_view",
  View.Presets: "presets_view",
  View.Media: "media_view",
  View.Connections: "connections_view",
  View.Surfaces: "surfaces_view",
  View.FixturePatch: "fixture_patch_view",
  View.Session: "session_view",
  View.History: "history_view",
  View.DmxOutput: "dmx_output_view",
  View.Timecode: "timecode_view",
  View.Preferences: "preferences_view",
  View.MidiProfiles: "midi_profiles_view",
  View.FixtureDefinitions: "fixture_definitions_view",
};

extension ViewToHotkey on View {
  String toHotkeyString() {
    return ViewHotkeyLabels[this]!;
  }
}

class OpenProjectIntent extends Intent {}
