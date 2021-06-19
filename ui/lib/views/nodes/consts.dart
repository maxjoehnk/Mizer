import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

const double CANVAS_SIZE = 20000;

const double MULTIPLIER = 75;

const double NODE_BASE_WIDTH = 300;

const double OUTER_RADIUS = 4;
const double INNER_RADIUS = 2;

const double DOT_SIZE = 12;

MaterialColor getColorForProtocol(ChannelProtocol protocol) {
  switch (protocol) {
    case ChannelProtocol.Single:
      return Colors.yellow;
    case ChannelProtocol.Multi:
      return Colors.green;
    case ChannelProtocol.Gst:
    case ChannelProtocol.Texture:
    case ChannelProtocol.Color:
      return Colors.red;
    default:
      log("no color for protocol ${protocol.name}");
      return Colors.blueGrey;
  }
}
