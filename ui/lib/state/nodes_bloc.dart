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

class NodesBloc extends Bloc<NodesEvent, Nodes> {
  final NodesApiClient client;

  NodesBloc(this.client) : super(Nodes.create());

  @override
  Stream<Nodes> mapEventToState(NodesEvent event) async* {
    if (event is FetchNodes) {
      yield await client.getNodes(NodesRequest());
    }
    if (event is AddNode) {
      var node = await client.addNode(AddNodeRequest(
          type: event.nodeType,
          position: NodePosition(x: event.position.dx, y: event.position.dy)));
      var nextNodes = state.nodes.sublist(0);
      nextNodes.add(node);
      yield Nodes(channels: state.channels, nodes: nextNodes);
    }
  }
}
