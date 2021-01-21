import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

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
