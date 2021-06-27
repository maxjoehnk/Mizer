import 'package:mizer/protos/session.pb.dart';

abstract class SessionApi {
  Stream<Session> watchSession();
  Future<void> closeProject();
  Future<void> newProject();
  Future<void> openProject(String path);
  Future<void> saveProject();
}
