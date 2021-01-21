import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

class ClockNode extends StatelessWidget {
  final Node node;

  ClockNode(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Speed"
          ),
        )
      ],
    );
  }
}
