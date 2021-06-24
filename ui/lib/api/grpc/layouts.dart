import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pbgrpc.dart';

class LayoutsGrpcApi implements LayoutsApi {
  final LayoutsApiClient client;

  LayoutsGrpcApi(ClientChannel channel) : this.client = LayoutsApiClient(channel);

  @override
  Future<Layouts> getLayouts() {
    return this.client.getLayouts(GetLayoutsRequest());
  }

  @override
  Future<Layouts> addLayout(String name) {
    return this.client.addLayout(AddLayoutRequest(name: name));
  }

  @override
  Future<Layouts> removeLayout(String id) {
    return this.client.removeLayout(RemoveLayoutRequest(id: id));
  }

  @override
  Future<Layouts> renameLayout(String id, String name) {
    return this.client.renameLayout(RenameLayoutRequest(id: id, name: name));
  }
}
