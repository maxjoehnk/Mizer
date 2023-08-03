import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

const double CANVAS_SIZE = 20000;

const double MULTIPLIER = 75;

const double NODE_BASE_WIDTH = 300;

const double OUTER_RADIUS = 4;
const double INNER_RADIUS = 2;

const double DOT_SIZE = 16;

MaterialColor getColorForProtocol(ChannelProtocol protocol) {
  switch (protocol) {
    case ChannelProtocol.SINGLE:
      return Colors.amber;
    case ChannelProtocol.MULTI:
      return Colors.green;
    case ChannelProtocol.TEXTURE:
    case ChannelProtocol.COLOR:
      return Colors.red;
    case ChannelProtocol.LASER:
      return Colors.purple;
    case ChannelProtocol.DATA:
      return Colors.blue;
    case ChannelProtocol.CLOCK:
      return Colors.pink;
    case ChannelProtocol.POSITION:
      return Colors.cyan;
    default:
      log("no color for protocol ${protocol.name}");
      return Colors.blueGrey;
  }
}
