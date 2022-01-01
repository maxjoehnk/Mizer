import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/api/plugin/ffi/transport.dart';
import 'package:mizer/protos/transport.pbgrpc.dart';

class TransportGrpcApi implements TransportApi {
  final TransportApiClient client;

  TransportGrpcApi(ClientChannel channel) : client = TransportApiClient(channel);

  @override
  Future<void> setBPM(double bpm) async {
    await client.setBpm(SetBpmRequest(bpm: bpm));
  }

  @override
  Future<void> setState(TransportState state) async  {
    await client.setState(SetTransportRequest(state: state));
  }

  @override
  Stream<Transport> watchTransport() {
    return client.subscribeTransport(SubscribeTransportRequest());
  }

  @override
  Future<TransportPointer?> getTransportPointer() async {
    return null;
  }
}
