import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/programmer.pb.dart';

class ProgrammerDemoApi implements ProgrammerApi {
  @override
  Future<void> writeControl(WriteControlRequest request) {
    // TODO: implement writeControl
    throw UnimplementedError();
  }

  @override
  Stream<ProgrammerState> observe() {
    // TODO: implement observe
    throw UnimplementedError();
  }

  @override
  Future<void> selectFixtures(List<int> fixtureIds) {
    // TODO: implement selectFixtures
    throw UnimplementedError();
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<void> highlight(bool highlight) {
    // TODO: implement highlight
    throw UnimplementedError();
  }

  @override
  Future<void> store(int sequenceId, StoreRequest_Mode storeMode) {
    // TODO: implement store
    throw UnimplementedError();
  }
}
