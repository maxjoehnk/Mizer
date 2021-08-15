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
