import 'package:mizer/protos/session.pb.dart';

abstract class SessionApi {
  Stream<Session> watchSession();
  Future<void> newProject();
  Future<LoadProjectResult> loadProject(String path);
  Future<void> saveProject();
  Future<void> saveProjectAs(String path);
  Future<void> undo();
  Future<void> redo();
  Stream<History> getHistory();
}
