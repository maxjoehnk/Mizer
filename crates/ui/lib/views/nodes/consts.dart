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

const _GENERATED_TYPES = [
  Node_NodeType.PROGRAMMER,
  Node_NodeType.TRANSPORT,
  Node_NodeType.SEQUENCER,
  Node_NodeType.FIXTURE,
  Node_NodeType.GROUP,
  Node_NodeType.PRESET,
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
  var category = NODES.firstWhereOrNull((category) => category.nodes.contains(type));
  if (category == null) {
    log("no color for node type ${type.name}");
    return Colors.green;
  }

  return category.color;
}
