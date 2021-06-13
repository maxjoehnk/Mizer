import 'package:mizer/protos/transport.pb.dart';

abstract class TransportApi {
  Stream<Transport> watchTransport();

  Future<void> setState(TransportState state);

  Future<void> setBPM(double bpm);
}
