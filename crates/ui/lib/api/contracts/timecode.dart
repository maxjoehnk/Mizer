import 'package:mizer/api/plugin/ffi/timecode.dart';
import 'package:mizer/protos/timecode.pb.dart';

abstract class TimecodeApi {
  Stream<AllTimecodes> watchTimecodes();

  Future<AllTimecodes> getTimecodes();

  Future<void> addTimecode(AddTimecodeRequest request);

  Future<void> renameTimecode(RenameTimecodeRequest request);

  Future<void> deleteTimecode(DeleteTimecodeRequest request);

  Future<void> addTimecodeControl(AddTimecodeControlRequest request);

  Future<void> renameTimecodeControl(RenameTimecodeControlRequest request);

  Future<void> deleteTimecodeControl(DeleteTimecodeControlRequest request);

  Future<TimecodePointer?> getTimecodePointer();
}
