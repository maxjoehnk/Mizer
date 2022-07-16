import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

abstract class NodesEvent {}

class FetchNodes extends NodesEvent {}

class AddNode extends NodesEvent {
  final Node_NodeType nodeType;
  final Offset position;
  final String? parent;

  AddNode({required this.nodeType, required this.position, this.parent});
}

class LinkNodes extends NodesEvent {
  final Node sourceNode;
  final Port sourcePort;
  final PortOption target;

  LinkNodes(this.sourceNode, this.sourcePort, this.target);

  ChannelProtocol get protocol => this.sourcePort.protocol;
}

class MoveNode extends NodesEvent {
  final String node;
  final Offset position;

  MoveNode(this.node, this.position);

  MoveNodeRequest into() {
    return MoveNodeRequest(
      path: node,
      position: NodePosition(
        x: position.dx,
        y: position.dy,
      ),
    );
  }
}

class DeleteNode extends NodesEvent {
  final String node;

  DeleteNode(this.node);
}

class HideNode extends NodesEvent {
  final String node;

  HideNode(this.node);
}

class DisconnectPorts extends NodesEvent {
  final String node;

  DisconnectPorts(this.node);
}

class DuplicateNode extends NodesEvent {
  final String node;

  DuplicateNode(this.node);
}

class ShowNode extends NodesEvent {
  final String node;
  final Offset position;
  final String? parent;

  ShowNode(this.node, this.position, this.parent);

  ShowNodeRequest into() {
    return ShowNodeRequest(
      path: node,
      position: NodePosition(
        x: position.dx,
        y: position.dy,
      ),
      parent: parent,
    );
  }
}

class NodesBloc extends Bloc<NodesEvent, Nodes> {
  final NodesApi api;

  NodesBloc(this.api) : super(Nodes.create()) {
    this.add(FetchNodes());
  }

  @override
  Stream<Nodes> mapEventToState(NodesEvent event) async* {
    if (event is FetchNodes) {
      var nodes = await api.getNodes();
      // log("$nodes", name: "NodesBloc");
      yield nodes;
    }
    if (event is AddNode) {
      await api.addNode(AddNodeRequest(
          type: event.nodeType,
          position: NodePosition(x: event.position.dx, y: event.position.dy),
          parent: event.parent));
      var nodes = await api.getNodes();
      yield nodes;
    }
    if (event is LinkNodes) {
      LinkNodes request = event;
      var connection = NodeConnection(
          protocol: request.protocol,
          sourceNode: request.sourceNode.path,
          sourcePort: request.sourcePort,
          targetNode: request.target.node.path,
          targetPort: request.target.port);
      await api.linkNodes(connection);
      var nodes = await api.getNodes();
      yield nodes;
    }
    if (event is MoveNode) {
      var request = event.into();
      await api.moveNode(request);
      var nodes = await api.getNodes();
      yield nodes;
    }
    if (event is DeleteNode) {
      await api.deleteNode(event.node);
      var nodes = await api.getNodes();
      yield nodes;
    }
    if (event is HideNode) {
      await api.hideNode(event.node);
      var nodes = await api.getNodes();
      yield nodes;
    }
    if (event is ShowNode) {
      var request = event.into();
      await api.showNode(request);
      var nodes = await api.getNodes();
      yield nodes;
    }
    if (event is DisconnectPorts) {
      await api.disconnectPorts(event.node);
      var nodes = await api.getNodes();
      yield nodes;
    }
    if (event is DuplicateNode) {
      await api.duplicateNode(event.node);
      var nodes = await api.getNodes();
      yield nodes;
    }
  }

  Node? getNodeByPath(String path) {
    return this.state.allNodes.firstWhereOrNull((node) => node.path == path);
  }

  List<PortOption> getAvailablePorts(Node node, Port port) {
    return this
        .state
        .nodes
        .where((n) => n.path != node.path)
        .expand((n) => n.inputs
            .where((p) => p.protocol == port.protocol)
            .map((p) => PortOption(node: n, port: p)))
        .toList();
  }
}

class PortOption {
  final Node node;
  final Port port;

  PortOption({required this.node, required this.port});
}
