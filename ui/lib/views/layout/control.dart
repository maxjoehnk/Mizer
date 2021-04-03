import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/widgets/inputs/button.dart';
import 'package:mizer/widgets/inputs/fader.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/protos/nodes.pbgrpc.dart';
import 'package:mizer/state/nodes_bloc.dart';

class LayoutControlView extends StatelessWidget {
  final LayoutControl control;

  LayoutControlView(this.control);

  @override
  Widget build(BuildContext context) {
    NodesBloc nodes = context.watch();
    NodesApiClient apiClient = context.read();
    Node node = nodes.getNodeByPath(control.node);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: getControl(node, apiClient),
    );
  }

  Widget getControl(Node node, NodesApiClient apiClient) {
    if (node.type == Node_NodeType.Fader) {
      return FaderInput(
        onValue: (value) => apiClient
            .writeControlValue(WriteControl(path: control.node, port: "value", value: value)),
      );
    } else if (node.type == Node_NodeType.Button) {
      return ButtonInput(
          onValue: (value) => apiClient
              .writeControlValue(WriteControl(path: control.node, port: "value", value: value)));
    }
    return Container();
  }
}
