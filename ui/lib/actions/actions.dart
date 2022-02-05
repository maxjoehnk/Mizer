import 'package:flutter/widgets.dart';

class OpenViewIntent extends Intent {
  final int viewIndex;

  const OpenViewIntent(this.viewIndex);
}

enum View {
  Layout,
  Plan,
  PreViz,
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
}

const ViewHotkeyLabels = {
  View.Layout: "layout_view",
  View.Plan: "plan_view",
  View.PreViz: "previz_view",
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
};

extension ViewToHotkey on View {
  String toHotkeyString() {
    return ViewHotkeyLabels[this]!;
  }
}

class OpenProjectIntent extends Intent {
}
