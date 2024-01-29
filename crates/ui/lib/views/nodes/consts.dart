import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

const double CANVAS_SIZE = 20000;

const double MULTIPLIER = 75;

const double NODE_BASE_WIDTH = 300;

const double OUTER_RADIUS = 4;
const double INNER_RADIUS = 2;

const double DOT_SIZE = 16;

const double MIN_ZOOM = 0.1;
const double MAX_ZOOM = 1;

const _GENERATED_TYPES = ["programmer", "transport", "sequencer", "fixture", "group", "preset"];

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
    case ChannelProtocol.VECTOR:
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
