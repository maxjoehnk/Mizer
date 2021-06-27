import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionDemoApi implements SessionApi {
  @override
  Stream<Session> watchSession() {
    return Stream.empty();
  }

  @override
  Future<void> closeProject() {
    // TODO: implement closeProject
    throw UnimplementedError();
  }

  @override
  Future<void> newProject() {
    // TODO: implement newProject
    throw UnimplementedError();
  }

  @override
  Future<void> openProject(String path) {
    // TODO: implement openProject
    throw UnimplementedError();
  }

  @override
  Future<void> saveProject() {
    // TODO: implement saveProject
    throw UnimplementedError();
  }

}
