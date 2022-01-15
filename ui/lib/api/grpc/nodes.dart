import 'dart:developer';

import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pbgrpc.dart';

class NodesGrpcApi implements NodesApi {
  final NodesApiClient client;

  NodesGrpcApi(ClientChannel channel) : client = NodesApiClient(channel);

  @override
  Future<Node> addNode(AddNodeRequest request) {
    return this.client.addNode(request);
  }

  @override
  Future<Nodes> getNodes() {
    return this.client.getNodes(NodesRequest());
  }

  @override
  Future<void> linkNodes(NodeConnection connection) {
    return this.client.addLink(connection);
  }

  @override
  Future<void> writeControlValue({ required String path, required String port, required double value }) {
    return this.client.writeControlValue(WriteControl(path: path, port: port, value: value));
  }

  @override
  Future<void> updateNodeConfig(UpdateNodeConfigRequest request) {
    log("updateNodeConfig $request", name: "NodesGrpcApi");
    return this.client.updateNodeProperty(request);
  }

  @override
  Future<void> moveNode(MoveNodeRequest request) {
    return this.client.moveNode(request);
  }

  @override
  Future<void> deleteNode(String path) {
    return this.client.deleteNode(DeleteNodeRequest(path: path));
  }

  @override
  Future<void> showNode(ShowNodeRequest request) {
    return this.client.showNode(request);
  }
}
