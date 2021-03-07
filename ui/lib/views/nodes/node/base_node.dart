import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

const double BASE_WIDTH = 300;
const double BASE_HEIGHT = 225;

class BaseNode extends StatelessWidget {
  final Node node;
  final Widget child;
  final bool selected;
  final Function onSelect;

  BaseNode(this.node, {this.child, this.selected, this.onSelect});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      width: BASE_WIDTH,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onSecondaryTap: () {
          log("node context menu");
        },
        onTap: this.onSelect,
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.grey.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            shadows: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: Offset(4, 4))
            ],
          ),
          foregroundDecoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                side: selected
                    ? BorderSide(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2,
                )
                    : BorderSide(style: BorderStyle.none, width: 2),
              )),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(4))),
                    color: Colors.green,
                  ),
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.all(4),
                  child: Text(this.node.path, style: textTheme.bodyText2),
                ),
                NodeOutputs(this.node),
                NodeInputs(this.node),
                this.child,
              ]),
        ),
      ),
    );
  }

  factory BaseNode.fromNode(Node node, {Function onSelect, bool selected}) {
    return BaseNode(
      node,
      child: getChildForNode(node),
      onSelect: onSelect,
      selected: selected,
    );
  }
}

class NodeInputs extends StatelessWidget {
  final Node node;

  NodeInputs(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: this.node.inputs.map((port) => NodePort(port)).toList());
  }
}

class NodeOutputs extends StatelessWidget {
  final Node node;

  NodeOutputs(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: this.node.outputs.map((port) => NodePort(port, input: false)).toList());
  }
}

class NodePort extends StatelessWidget {
  final Port port;
  final bool input;

  NodePort(this.port, { this.input = true });

  @override
  Widget build(BuildContext context) {
    var color = getColorForProtocol(port.protocol);
    return Transform(
      transform: Matrix4.translationValues(input ? -4 : 4, 0, 0),
      child: Row(
        mainAxisAlignment: input ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: input
            ? [getDot(context, color), Container(width: 8), Text(port.name)]
            : [Text(port.name), Container(width: 8), getDot(context, color)],
      ),
    );
  }

  MaterialColor getColorForProtocol(ChannelProtocol protocol) {
    switch (protocol) {
      case ChannelProtocol.Single:
        return Colors.yellow;
      case ChannelProtocol.Multi:
        return Colors.green;
      case ChannelProtocol.Gst:
      case ChannelProtocol.Texture:
        return Colors.red;
      default:
        log("no color for protocol ${protocol.name}");
        return Colors.blueGrey;
    }
  }

  Widget getDot(BuildContext context, MaterialColor color) {
    const double DOT_SIZE = 8;
    return DecoratedBox(
      decoration: ShapeDecoration(
          gradient:
          RadialGradient(colors: [color.shade600, color.shade500]),
          shadows: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: Offset(2, 2))
          ],
          shape: CircleBorder(
              side: BorderSide.none)),
      child: Container(
        width: DOT_SIZE,
        height: DOT_SIZE,
      ),
    );
  }
}

Widget getChildForNode(Node node) {
  switch (node.type) {
    default:
      log("no child for node type ${node.type.name}");
      return Container();
  }
}
