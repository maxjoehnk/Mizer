import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
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

final Map<NodeCategory, String Function()> CATEGORY_NAMES = {
  NodeCategory.NODE_CATEGORY_STANDARD: () => "Standard".i18n,
  NodeCategory.NODE_CATEGORY_CONNECTIONS: () => "Connections".i18n,
  NodeCategory.NODE_CATEGORY_CONVERSIONS: () => "Conversions".i18n,
  NodeCategory.NODE_CATEGORY_CONTROLS: () => "Controls".i18n,
  NodeCategory.NODE_CATEGORY_DATA: () => "Data".i18n,
  NodeCategory.NODE_CATEGORY_COLOR: () => "Color".i18n,
  NodeCategory.NODE_CATEGORY_AUDIO: () => "Audio".i18n,
  NodeCategory.NODE_CATEGORY_VIDEO: () => "Video".i18n,
  NodeCategory.NODE_CATEGORY_LASER: () => "Laser".i18n,
  NodeCategory.NODE_CATEGORY_PIXEL: () => "Pixel".i18n,
  NodeCategory.NODE_CATEGORY_VECTOR: () => "Vector".i18n,
  NodeCategory.NODE_CATEGORY_FIXTURES: () => "Fixtures".i18n,
  NodeCategory.NODE_CATEGORY_UI: () => "UI".i18n,
};
