import 'package:flutter/material.dart';
import 'package:ui/protos/nodes.pb.dart';

class FixtureNode extends StatelessWidget {
  final Node node;

  FixtureNode(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      ],
    );
  }
}
