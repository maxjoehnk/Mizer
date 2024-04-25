import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/field.dart';
import 'package:mizer/views/nodes/widgets/properties/groups/property_group.dart';

class NodeInputsPane extends StatelessWidget {
  final Node node;

  NodeInputsPane({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodesBloc, PipelineState>(builder: (context, state) {
      List<NodeConnection> inputs = state.getInputs(node.path);
      return PropertyGroup(title: "Inputs".i18n, children: node.inputs.map((port) {
        List<String> connections = inputs
            .where((c) => c.targetPort.name == port.name)
            .map((c) => c.sourceNode)
            .toList();

          return PortField(port: port.name, connections: connections);
      }).toList());
    });
  }
}

class NodeOutputsPane extends StatelessWidget {
  final Node node;

  NodeOutputsPane({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodesBloc, PipelineState>(builder: (context, state) {
      List<NodeConnection> outputs = state.getOutputs(node.path);
      return PropertyGroup(title: "Outputs".i18n, children: node.outputs.map((port) {
        List<String> connections = outputs
            .where((c) => c.sourcePort.name == port.name)
            .map((c) => c.targetNode)
            .toList();

        return PortField(port: port.name, connections: connections);
      }).toList());
    });
  }
}


class PortField extends StatelessWidget {
  final String port;
  final List<String> connections;

  const PortField({super.key, required this.port, required this.connections});

  @override
  Widget build(BuildContext context) {
    if (connections.length == 1) {
      return Field(label: port, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(connections.first, style: TextStyle(color: Colors.grey.shade300))));
    }

    if (connections.isNotEmpty) {
      return Field(label: port, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text("${connections.length} connections".i18n, style: TextStyle(color: Colors.grey.shade300))));
    }

    return Field(label: port, child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text("None".i18n, style: TextStyle(color: Colors.grey.shade500))));
  }
}
