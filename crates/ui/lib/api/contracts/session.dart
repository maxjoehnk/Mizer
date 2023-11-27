import 'package:mizer/protos/session.pb.dart';

abstract class SessionApi {
  Stream<SessionState> watchSession();
  Future<void> newProject();
  Future<void> loadProject(String path);
  Future<void> saveProject();
  Future<void> saveProjectAs(String path);
  Future<void> undo();
  Future<void> redo();
  Stream<History> getHistory();
}
