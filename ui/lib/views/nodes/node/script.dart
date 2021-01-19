import 'package:flutter/material.dart';
import 'package:ui/protos/nodes.pb.dart';

class ScriptNode extends StatelessWidget {
  final Node node;

  ScriptNode(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
              labelText: "Script"
          ),
          maxLines: 5,
        )
      ],
    );
  }
}
