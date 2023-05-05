import 'package:flutter/widgets.dart';
import 'package:mizer/views/nodes/models/node_model.dart';

class CustomNodeTab {
  final NodeTab tab;
  final IconData icon;
  final Widget Function(NodeModel) builder;

  CustomNodeTab({ required this.tab, required this.icon, required this.builder });
}
