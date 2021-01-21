import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

class SacnOutputNode extends StatelessWidget {
  final Node node;

  SacnOutputNode(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Host"
          ),
        )
      ],
    );
  }
}
