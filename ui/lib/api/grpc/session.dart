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

  @override
  Future<void> closeProject() async {
    await this.client.closeProject(ProjectRequest());
  }

  @override
  Future<void> newProject() async {
    await client.newProject(ProjectRequest());
  }

  @override
  Future<void> openProject(String path) async {
    await client.openProject(OpenProjectRequest(path: path));
  }

  @override
  Future<void> saveProject() async {
    await client.saveProject(ProjectRequest());
  }
}
