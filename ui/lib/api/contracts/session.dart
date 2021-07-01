import 'package:mizer/protos/session.pb.dart';

abstract class SessionApi {
  Stream<Session> watchSession();
  Future<void> newProject();
  Future<void> loadProject(String path);
  Future<void> saveProject();
}
