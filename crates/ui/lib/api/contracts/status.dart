import 'package:mizer/api/plugin/ffi/status.dart';

abstract class StatusApi {
  Future<StatusPointer?> getStatusPointer();

  Stream<String?> getStatusMessages();
}
