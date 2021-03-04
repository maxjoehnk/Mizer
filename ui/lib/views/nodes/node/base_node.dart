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
    return Stack(children: [
      BaseNodeView(node,
          child: child, selected: this.selected, onSelect: this.onSelect),
      NodeConnectors(node)
    ]);
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

class BaseNodeView extends StatelessWidget {
  const BaseNodeView(
    this.node, {
    Key key,
    @required this.child,
    this.selected = false,
    this.onSelect,
  }) : super(key: key);

  final Node node;
  final Widget child;
  final bool selected;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      width: BASE_WIDTH,
      height: BASE_HEIGHT,
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
                this.child,
              ]),
        ),
      ),
    );
  }
}

class NodeConnectors extends StatelessWidget {
  const NodeConnectors(
    this.node, {
    Key key,
  }) : super(key: key);

  final Node node;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: BASE_WIDTH,
      height: BASE_HEIGHT,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 4, right: 4),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NodeInputs(this.node),
              NodeOutputs(this.node),
            ]),
      ),
    );
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
      child: Tooltip(
        message: port.protocol.toString(),
        child: DecoratedBox(
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
      ),
    );
  }

  MaterialColor getColorForProtocol(ChannelProtocol protocol) {
    switch (protocol) {
      case ChannelProtocol.Single:
        return Colors.red;
      case ChannelProtocol.Multi:
        return Colors.green;
      case ChannelProtocol.Gst:
        return Colors.deepOrange;
      default:
        log("no color for protocol ${protocol.name}");
        return Colors.blueGrey;
    }
  }
}

Widget getChildForNode(Node node) {
  switch (node.type) {
    default:
      log("no child for node type ${node.type.name}");
      return Container();
  }
}
