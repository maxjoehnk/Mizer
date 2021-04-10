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
  Future<void> writeControlValue({ String path, String port, double value }) {
    return this.client.writeControlValue(WriteControl(path: path, port: port, value: value ));
  }
}
