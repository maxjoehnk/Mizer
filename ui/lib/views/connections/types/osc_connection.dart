import 'package:flutter/material.dart';
import 'package:mizer/protos/connections.pb.dart';

class OscConnectionView extends StatelessWidget {
  final OscConnection device;

  OscConnectionView({required this.device});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [], crossAxisAlignment: CrossAxisAlignment.start),
    );
  }
}
