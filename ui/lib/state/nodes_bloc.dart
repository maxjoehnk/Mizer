import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/protos/nodes.pbgrpc.dart';

abstract class NodesEvent {}

class FetchNodes extends NodesEvent {}

class AddNode extends NodesEvent {
  final Node_NodeType nodeType;
  final Offset position;

  AddNode({this.nodeType, this.position});
}

class LinkNodes extends NodesEvent {
  final Node sourceNode;
  final Port sourcePort;
  final PortOption target;

  LinkNodes(this.sourceNode, this.sourcePort, this.target);

  ChannelProtocol get protocol => this.sourcePort.protocol;
}

class NodesBloc extends Bloc<NodesEvent, Nodes> {
  final NodesApiClient client;

  NodesBloc(this.client) : super(Nodes.create()) {
    this.add(FetchNodes());
  }

  @override
  Stream<Nodes> mapEventToState(NodesEvent event) async* {
    if (event is FetchNodes) {
      var nodes = await client.getNodes(NodesRequest());
      log("$nodes", name: "NodesBloc");
      yield nodes;
    }
    if (event is AddNode) {
      var node = await client.addNode(AddNodeRequest(
          type: event.nodeType,
          position: NodePosition(x: event.position.dx, y: event.position.dy)));
      var nextNodes = state.nodes.sublist(0);
      nextNodes.add(node);
      yield Nodes(channels: state.channels, nodes: nextNodes);
    }
    if (event is LinkNodes) {
      LinkNodes request = event;
      var connection = NodeConnection(protocol: request.protocol,
          sourceNode: request.sourceNode.path,
          sourcePort: request.sourcePort,
          targetNode: request.target.node.path,
          targetPort: request.target.port);
      await client.addLink(connection);
      var nextChannels = state.channels.sublist(0);
      nextChannels.add(connection);
      yield Nodes(channels: nextChannels, nodes: state.nodes);
    }
  }

  Node getNodeByPath(String path) {
    return this.state.nodes.firstWhere((node) => node.path == path);
  }

  List<PortOption> getAvailablePorts(Node node, Port port) {
    return this
        .state
        .nodes
        .where((n) => n.path != node.path)
        .expand((n) =>
        n.inputs
            .where((p) => p.protocol == port.protocol)
            .map((p) => PortOption(node: n, port: p)))
        .toList();
  }
}

class PortOption {
  final Node node;
  final Port port;

  PortOption({this.node, this.port});
}
