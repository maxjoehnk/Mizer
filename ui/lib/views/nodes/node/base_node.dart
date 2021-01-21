import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/node/artnet_output.dart';
import 'package:mizer/views/nodes/node/clock.dart';
import 'package:mizer/views/nodes/node/convert_to_dmx.dart';
import 'package:mizer/views/nodes/node/fixture.dart';
import 'package:mizer/views/nodes/node/osc_input.dart';
import 'package:mizer/views/nodes/node/oscillator.dart';
import 'package:mizer/views/nodes/node/sacn_output.dart';
import 'package:mizer/views/nodes/node/script.dart';

class BaseNode extends StatelessWidget {
  final Node node;
  final Widget child;

  BaseNode(this.node, {this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.node.title, style: textTheme.headline6),
                Text(this.node.type.name,
                    style:
                        textTheme.subtitle2.copyWith(color: theme.hintColor)),
                this.child,
              ]),
        )),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 4, right: 4),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NodeInputs(this.node),
              NodeOutputs(this.node),
            ]),
      )
    ]);
  }

  factory BaseNode.fromNode(Node node) {
    return BaseNode(node, child: getChildForNode(node));
  }
}

class NodeInputs extends StatelessWidget {
  final Node node;

  NodeInputs(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: this.node.inputs.map((port) => NodePort(port)).toList());
  }
}

class NodeOutputs extends StatelessWidget {
  final Node node;

  NodeOutputs(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: this.node.outputs.map((port) => NodePort(port)).toList());
  }
}

class NodePort extends StatelessWidget {
  final Port port;

  NodePort(this.port);

  @override
  Widget build(BuildContext context) {
    var color = getColorForProtocol(port.protocol);
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: DecoratedBox(
        decoration: ShapeDecoration(
            gradient: RadialGradient(colors: [color.shade600, color.shade500]),
            shadows: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: Offset(2, 2))
            ],
            shape: CircleBorder(
                side: BorderSide(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 2,
            ))),
        child: Container(
          width: 16,
          height: 16,
        ),
      ),
    );
  }

  MaterialColor getColorForProtocol(ChannelProtocol protocol) {
    switch (protocol) {
      case ChannelProtocol.Dmx:
        return Colors.red;
      case ChannelProtocol.Clock:
        return Colors.green;
      case ChannelProtocol.Numeric:
        return Colors.deepOrange;
      default:
        log("no color for protocol ${protocol.name}");
        return Colors.blueGrey;
    }
  }
}

Widget getChildForNode(Node node) {
  switch (node.type) {
    case Node_NodeType.ArtnetOutput:
      return ArtnetOutputNode(node);
    case Node_NodeType.SacnOutput:
      return SacnOutputNode(node);
    case Node_NodeType.ConvertToDmx:
      return ConvertToDmxNode(node);
    case Node_NodeType.Oscillator:
      return OscillatorNode(node);
    case Node_NodeType.Clock:
      return ClockNode(node);
    case Node_NodeType.OscInput:
      return OscInputNode(node);
    case Node_NodeType.Script:
      return ScriptNode(node);
    case Node_NodeType.Fixture:
      return FixtureNode(node);
    default:
      log("no child for node type ${node.type.name}");
      return Container();
  }
}
