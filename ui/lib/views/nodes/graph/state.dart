import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';

class GraphState {
  HashMap<String, GraphPortKey> inputs;
  HashMap<String, GraphPortKey> outputs;
  List<NodeConnection> channels;

  GraphState(Nodes nodes) {
    this.inputs = HashMap();
    this.outputs = HashMap();
    this.channels = nodes.channels;
    for (var node in nodes.nodes) {
      for (var port in node.inputs) {
        var identifier = getNodePortIdentifier(node.path, port.name, true);
        inputs[identifier] = GraphPortKey(identifier);
      }
      for (var port in node.outputs) {
        var identifier = getNodePortIdentifier(node.path, port.name, false);
        outputs[identifier] = GraphPortKey(identifier);
      }
    }
  }

  GraphPortKey getKey(Node node, Port port, bool input) {
    var identifier = getNodePortIdentifier(node.path, port.name, input);
    if (input) {
      return this.inputs[identifier];
    }else {
      return this.outputs[identifier];
    }
  }

  @override
  String toString() {
    return "inputs: $inputs, outputs: $outputs";
  }
}

class GraphPortKey extends LabeledGlobalKey {
  final String identifier;

  GraphPortKey(this.identifier): super(identifier);
}

String getIdentifierForChannelFrom(NodeConnection connection) {
  return getNodePortIdentifier(connection.sourceNode, connection.sourcePort.name, false);
}

String getIdentifierForChannelTo(NodeConnection connection) {
  return getNodePortIdentifier(connection.targetNode, connection.targetPort.name, true);
}

String getNodePortIdentifier(String path, String port, bool input) {
  return "$port${input ? '>' : '<'}$path";
}

class GraphBloc extends Cubit<GraphState> {
  Nodes nodes;

  GraphBloc(this.nodes): super(GraphState(nodes));

  void update(Nodes nodes) {
    this.nodes = nodes;
    this.emit(GraphState(nodes));
  }
}
