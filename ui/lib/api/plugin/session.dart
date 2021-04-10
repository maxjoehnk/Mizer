import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionPluginApi implements SessionApi {
  @override
  Stream<Session> watchSession() {
    return Stream.empty();
  }
}
