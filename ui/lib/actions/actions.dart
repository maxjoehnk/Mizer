import 'package:flutter/widgets.dart';

class OpenViewIntent extends Intent {
  final View view;

  const OpenViewIntent(this.view);
}

enum View {
  Layout,
  Plan2D,
  PreViz,
  Nodes,
  Fixtures,
  Media,
  Devices,
  Session,
  Settings,
}

class OpenProjectIntent extends Intent {

}

class NewProjectIntent extends Intent {

}
