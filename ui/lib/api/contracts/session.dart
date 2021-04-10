import 'package:mizer/protos/session.pb.dart';

abstract class SessionApi {
  Stream<Session> watchSession();
}
