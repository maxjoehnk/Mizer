import 'package:flutter/widgets.dart';

class OpenViewIntent extends Intent {
  final View view;

  const OpenViewIntent(this.view);
}

enum View {
  Layout,
  Plan,
  PreViz,
  Nodes,
  Sequences,
  Fixtures,
  Media,
  Connections,
  Session,
}

const ViewHotkeyLabels = {
  View.Layout: "layout_view",
  View.Plan: "plan_view",
  View.PreViz: "previz_view",
  View.Nodes: "nodes_view",
  View.Sequences: "sequencer_view",
  View.Fixtures: "fixtures_view",
  View.Media: "media_view",
  View.Connections: "connections_view",
  View.Session: "session_view",
};

extension ViewToHotkey on View {
  String toHotkeyString() {
    return ViewHotkeyLabels[this]!;
  }
}

class OpenProjectIntent extends Intent {
}
