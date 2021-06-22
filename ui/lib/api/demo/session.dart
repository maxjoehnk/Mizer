import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionDemoApi implements SessionApi {
  @override
  Stream<Session> watchSession() {
    return Stream.empty();
  }

}
