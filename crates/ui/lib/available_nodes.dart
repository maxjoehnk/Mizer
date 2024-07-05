import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

final Map<NodeCategory, Color> CATEGORY_COLORS = {
  NodeCategory.NODE_CATEGORY_NONE: Colors.blueGrey.shade700,
  NodeCategory.NODE_CATEGORY_STANDARD: Colors.green.shade700,
  NodeCategory.NODE_CATEGORY_CONNECTIONS: Colors.orange.shade700,
  NodeCategory.NODE_CATEGORY_CONVERSIONS: Colors.grey.shade700,
  NodeCategory.NODE_CATEGORY_CONTROLS: Colors.blue.shade700,
  NodeCategory.NODE_CATEGORY_DATA: Colors.green.shade700,
  NodeCategory.NODE_CATEGORY_COLOR: Colors.green.shade700,
  NodeCategory.NODE_CATEGORY_AUDIO: Colors.green.shade700,
  NodeCategory.NODE_CATEGORY_VIDEO: Colors.red.shade700,
  NodeCategory.NODE_CATEGORY_LASER: Colors.purpleAccent.shade700,
  NodeCategory.NODE_CATEGORY_PIXEL: Colors.red.shade700,
  NodeCategory.NODE_CATEGORY_VECTOR: Colors.purple.shade700,
  NodeCategory.NODE_CATEGORY_FIXTURES: Colors.blueGrey.shade700,
  NodeCategory.NODE_CATEGORY_UI: Colors.blue.shade700,
};

final Map<NodeCategory, String> CATEGORY_NAMES = {
  NodeCategory.NODE_CATEGORY_STANDARD: "Standard",
  NodeCategory.NODE_CATEGORY_CONNECTIONS: "Connections",
  NodeCategory.NODE_CATEGORY_CONVERSIONS: "Conversions",
  NodeCategory.NODE_CATEGORY_CONTROLS: "Controls",
  NodeCategory.NODE_CATEGORY_DATA: "Data",
  NodeCategory.NODE_CATEGORY_COLOR: "Color",
  NodeCategory.NODE_CATEGORY_AUDIO: "Audio",
  NodeCategory.NODE_CATEGORY_VIDEO: "Video",
  NodeCategory.NODE_CATEGORY_LASER: "Laser",
  NodeCategory.NODE_CATEGORY_PIXEL: "Pixel",
  NodeCategory.NODE_CATEGORY_VECTOR: "Vector",
  NodeCategory.NODE_CATEGORY_FIXTURES: "Fixtures",
  NodeCategory.NODE_CATEGORY_UI: "UI",
};
