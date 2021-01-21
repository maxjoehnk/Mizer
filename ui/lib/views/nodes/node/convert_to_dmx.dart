import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

class ConvertToDmxNode extends StatelessWidget {
  final Node node;

  ConvertToDmxNode(this.node);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Channel"
          ),
          keyboardType: TextInputType.number,
        )
      ],
    );
  }
}
