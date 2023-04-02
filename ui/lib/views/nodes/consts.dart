import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

const double CANVAS_SIZE = 20000;

const double MULTIPLIER = 75;

const double NODE_BASE_WIDTH = 300;

const double OUTER_RADIUS = 4;
const double INNER_RADIUS = 2;

const double DOT_SIZE = 16;

List<Color> _TYPE_COLORS = [
  Colors.green, // Standard
  Colors.orange, // Connections
  Colors.grey.shade700, // Conversions
  Colors.blue, // Controls
  Colors.green, // Audio
  Colors.red, // Video
  Colors.purple, // Laser
  Colors.red, // Pixel
];

const _GENERATED_TYPES = [
  Node_NodeType.Programmer,
  Node_NodeType.Transport,
  Node_NodeType.Sequencer,
  Node_NodeType.Fixture,
  Node_NodeType.Group,
];

MaterialColor getColorForProtocol(ChannelProtocol protocol) {
  switch (protocol) {
    case ChannelProtocol.SINGLE:
      return Colors.amber;
    case ChannelProtocol.MULTI:
      return Colors.green;
    case ChannelProtocol.GST:
    case ChannelProtocol.TEXTURE:
    case ChannelProtocol.COLOR:
      return Colors.red;
    case ChannelProtocol.LASER:
      return Colors.purple;
    case ChannelProtocol.DATA:
      return Colors.blue;
    case ChannelProtocol.CLOCK:
      return Colors.pink;
    default:
      log("no color for protocol ${protocol.name}");
      return Colors.blueGrey;
  }
}

Color getColorForType(Node_NodeType type) {
  // Special case as these are not creatable
  if (_GENERATED_TYPES.contains(type)) {
    return Colors.blueGrey;
  }
  var category =
      NODES.firstWhereOrNull((category) => category.items.any((item) => item.value == type));
  if (category == null) {
    log("no color for node type ${type.name}");
    return Colors.green;
  }
  var index = NODES.indexOf(category);

  return _TYPE_COLORS[index];
}
