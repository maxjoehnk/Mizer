import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/node/ports.dart';

import '../consts.dart';
import 'container.dart';
import 'header.dart';

class BaseNode extends StatelessWidget {
  final Node node;
  final Widget child;
  final bool selected;
  final Function onSelect;

  BaseNode(this.node, {this.child, this.selected, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: NODE_BASE_WIDTH,
      child: GestureDetector(
        onSecondaryTap: () {
          log("node context menu");
        },
        onTap: this.onSelect,
        child: NodeContainer(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NodeHeader(this.node.path),
                NodePortList(this.node, inputs: false),
                NodePortList(this.node, inputs: true),
                this.child,
              ]),
          selected: selected,
        ),
      ),
    );
  }

  factory BaseNode.fromNode(Node node, {Function onSelect, bool selected}) {
    return BaseNode(
      node,
      child: Container(),
      onSelect: onSelect,
      selected: selected,
    );
  }
}

