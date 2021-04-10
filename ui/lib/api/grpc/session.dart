import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pbgrpc.dart';

class SessionGrpcApi implements SessionApi {
  final SessionApiClient client;

  SessionGrpcApi(ClientChannel channel) : client = SessionApiClient(channel);

  @override
  Stream<Session> watchSession() {
    return this.client.getSession(SessionRequest());
  }
}
