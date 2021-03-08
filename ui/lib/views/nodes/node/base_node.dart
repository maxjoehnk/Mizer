import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/node/ports.dart';

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
                NodePortList(this.node, inputs: false),
                NodePortList(this.node, inputs: true),
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


Widget getChildForNode(Node node) {
  switch (node.type) {
    default:
      log("no child for node type ${node.type.name}");
      return Container();
  }
}
