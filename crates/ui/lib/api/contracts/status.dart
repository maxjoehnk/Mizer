import '../plugin/ffi/status.dart';

abstract class StatusApi {
  Future<StatusPointer?> getStatusPointer();
}
