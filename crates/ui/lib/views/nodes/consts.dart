import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/nodes.pb.dart';

const double CANVAS_SIZE = 20000;

const double MULTIPLIER = GRID_4_SIZE;

const double NODE_BASE_WIDTH = GRID_4_SIZE * 4;

const double OUTER_RADIUS = 4;
const double INNER_RADIUS = 2;

const double DOT_SIZE = 16;

const double MIN_ZOOM = 0.1;
const double MAX_ZOOM = 1;

final Map<NodeColor, Color> DESIGNER_COLORS = {
  NodeColor.NODE_COLOR_RED: Colors.red.shade900,
  NodeColor.NODE_COLOR_GREEN: Colors.green.shade900,
  NodeColor.NODE_COLOR_BLUE: Colors.blue.shade900,
  NodeColor.NODE_COLOR_YELLOW: Colors.yellow.shade900,
  NodeColor.NODE_COLOR_ORANGE: Colors.orange.shade900,
  NodeColor.NODE_COLOR_CYAN: Colors.cyan.shade900,
  NodeColor.NODE_COLOR_LIME: Colors.lime.shade900,
  NodeColor.NODE_COLOR_BROWN: Colors.brown.shade900,
  NodeColor.NODE_COLOR_GREY: Colors.grey.shade900,
  NodeColor.NODE_COLOR_AMBER: Colors.amber.shade900,
  NodeColor.NODE_COLOR_TEAL: Colors.teal.shade900,
  NodeColor.NODE_COLOR_PINK: Colors.pink.shade900,
  NodeColor.NODE_COLOR_INDIGO: Colors.indigo.shade900,
  NodeColor.NODE_COLOR_LIGHT_BLUE: Colors.lightBlue.shade900,
  NodeColor.NODE_COLOR_LIGHT_GREEN: Colors.lightGreen.shade900,
  NodeColor.NODE_COLOR_DEEP_ORANGE: Colors.deepOrange.shade900,
  NodeColor.NODE_COLOR_PURPLE: Colors.purple.shade900,
  NodeColor.NODE_COLOR_DEEP_PURPLE: Colors.deepPurple.shade900,
  NodeColor.NODE_COLOR_BLUE_GREY: Colors.blueGrey.shade900,
};

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
    case ChannelProtocol.TEXT:
      return Colors.blue;
    case ChannelProtocol.CLOCK:
      return Colors.pink;
    default:
      print("no color for protocol ${protocol.name}");
      return Colors.blueGrey;
  }
}
