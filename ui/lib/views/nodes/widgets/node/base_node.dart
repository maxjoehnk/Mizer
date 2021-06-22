import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../../consts.dart';
import 'container.dart';
import 'header.dart';
import 'ports.dart';
import 'preview.dart';

class BaseNode extends StatelessWidget {
  final Node node;
  final Widget child;
  final bool selected;
  final Function onSelect;

  BaseNode(this.node, {this.child, this.selected, this.onSelect, Key key}) : super(key: key);

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
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NodeHeader(this.node.path),
                  NodePortList(this.node, inputs: false),
                  NodePortList(this.node, inputs: true),
                  this.child,
                  NodePreview(this.node),
                ]),
          ),
          selected: selected,
        ),
      ),
    );
  }

  factory BaseNode.fromNode(Node node, {Function onSelect, bool selected, Key key}) {
    return BaseNode(
      node,
      child: Container(),
      onSelect: onSelect,
      selected: selected,
      key: key,
    );
  }
}
