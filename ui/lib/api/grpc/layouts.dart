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
}
