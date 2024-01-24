import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

const Map<NodeCategory, Color> CATEGORY_COLORS = {
  NodeCategory.NODE_CATEGORY_NONE: Colors.blueGrey,
  NodeCategory.NODE_CATEGORY_STANDARD: Colors.green,
  NodeCategory.NODE_CATEGORY_CONNECTIONS: Colors.orange,
  NodeCategory.NODE_CATEGORY_CONVERSIONS: Colors.grey,
  NodeCategory.NODE_CATEGORY_CONTROLS: Colors.blue,
  NodeCategory.NODE_CATEGORY_DATA: Colors.green,
  NodeCategory.NODE_CATEGORY_COLOR: Colors.green,
  NodeCategory.NODE_CATEGORY_AUDIO: Colors.green,
  NodeCategory.NODE_CATEGORY_VIDEO: Colors.red,
  NodeCategory.NODE_CATEGORY_LASER: Colors.purpleAccent,
  NodeCategory.NODE_CATEGORY_PIXEL: Colors.red,
  NodeCategory.NODE_CATEGORY_VECTOR: Colors.purple,
};

const Map<NodeCategory, String> CATEGORY_NAMES = {
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
};
