import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

class PipelineState {
  final List<Node> nodes;
  final List<Node> allNodes;
  final List<NodeConnection> channels;
  final List<AvailableNode> availableNodes;

  PipelineState(this.nodes, this.allNodes, this.channels, this.availableNodes);

  factory PipelineState.empty() {
    return PipelineState([], [], [], []);
  }

  PipelineState copyWith({
    List<Node>? nodes,
    List<Node>? allNodes,
    List<NodeConnection>? channels,
    List<AvailableNode>? availableNodes,
  }) {
    return PipelineState(
      nodes ?? this.nodes,
      allNodes ?? this.allNodes,
      channels ?? this.channels,
      availableNodes ?? this.availableNodes,
    );
  }
}

abstract class NodesEvent {}

class FetchNodes extends NodesEvent {}

class FetchAvailableNodes extends NodesEvent {}

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
  final String? parent;

  DuplicateNode(this.node, {this.parent});
}

class GroupNodes extends NodesEvent {
  final List<String> nodes;
  final String? parent;

  GroupNodes(this.nodes, {this.parent});
}

class RenameNode extends NodesEvent {
  final String node;
  final String newName;

  RenameNode(this.node, this.newName);

  RenameNodeRequest into() {
    return RenameNodeRequest(path: node, newName: newName);
  }
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

class NodesBloc extends Bloc<NodesEvent, PipelineState> {
  final NodesApi api;

  NodesBloc(this.api) : super(PipelineState.empty()) {
    on<FetchNodes>((event, emit) async {
      emit(await _fetchNodes());
    });
    on<FetchAvailableNodes>((event, emit) async {
      var availableNodes = await this.api.getAvailableNodes();
      emit(state.copyWith(availableNodes: availableNodes));
    });
    on<AddNode>((event, emit) async {
      await api.addNode(AddNodeRequest(
          type: event.nodeType,
          position: NodePosition(x: event.position.dx, y: event.position.dy),
          parent: event.parent));
      emit(await _fetchNodes());
    });
    on<LinkNodes>((event, emit) async {
      LinkNodes request = event;
      var connection = NodeConnection(
          protocol: request.protocol,
          sourceNode: request.sourceNode.path,
          sourcePort: request.sourcePort,
          targetNode: request.target.node.path,
          targetPort: request.target.port);
      if (state.channels.any((c) =>
          c.sourcePort.name == connection.sourcePort.name &&
          c.sourceNode == connection.sourceNode &&
          c.targetPort.name == connection.targetPort.name &&
          c.targetNode == connection.targetNode)) {
        await api.unlinkNodes(connection);
      } else {
        await api.linkNodes(connection);
      }
      emit(await _fetchNodes());
    });
    on<MoveNode>((event, emit) async {
      var request = event.into();
      await api.moveNode(request);
      emit(await _fetchNodes());
    });
    on<DeleteNode>((event, emit) async {
      await api.deleteNode(event.node);
      emit(await _fetchNodes());
    });
    on<HideNode>((event, emit) async {
      await api.hideNode(event.node);
      emit(await _fetchNodes());
    });
    on<ShowNode>((event, emit) async {
      var request = event.into();
      await api.showNode(request);
      emit(await _fetchNodes());
    });
    on<RenameNode>((event, emit) async {
      var request = event.into();
      await api.renameNode(request);
      emit(await _fetchNodes());
    });
    on<DisconnectPorts>((event, emit) async {
      await api.disconnectPorts(event.node);
      emit(await _fetchNodes());
    });
    on<DuplicateNode>((event, emit) async {
      await api.duplicateNode(DuplicateNodeRequest(path: event.node, parent: event.parent));
      emit(await _fetchNodes());
    });
    on<GroupNodes>((event, emit) async {
      await api.groupNodes(event.nodes, parent: event.parent);
      emit(await _fetchNodes());
    });
    this.add(FetchNodes());
    this.add(FetchAvailableNodes());
  }

  Future<PipelineState> _fetchNodes() async {
    var nodes = await api.getNodes();

    return state.copyWith(
      nodes: nodes.nodes,
      channels: nodes.channels,
      allNodes: nodes.allNodes,
    );
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
