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

const _TYPE_COLORS = [
  Colors.green,  // Standard
  Colors.yellow, // Connections
  Colors.blue,   // Controls
  Colors.red,    // Video
  Colors.brown,  // Laser
  Colors.purple, // Pixel
];

MaterialColor getColorForProtocol(ChannelProtocol protocol) {
  switch (protocol) {
    case ChannelProtocol.SINGLE:
      return Colors.yellow;
    case ChannelProtocol.MULTI:
      return Colors.green;
    case ChannelProtocol.GST:
    case ChannelProtocol.TEXTURE:
    case ChannelProtocol.COLOR:
      return Colors.red;
    default:
      log("no color for protocol ${protocol.name}");
      return Colors.blueGrey;
  }
}

MaterialColor getColorForType(Node_NodeType type) {
  // Special case as this one is not creatable
  if (type == Node_NodeType.Programmer) {
    return Colors.blueGrey;
  }
  var category = NODES.firstWhereOrNull((category) =>
      category.items.any((item) => item.value == type));
  if (category == null) {
    log("no color for node type ${type.name}");
    return Colors.green;
  }
  var index = NODES.indexOf(category);

  return _TYPE_COLORS[index];
}
