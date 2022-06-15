import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/programmer.pbgrpc.dart';

class ProgrammerGrpcApi implements ProgrammerApi {
  final ProgrammerApiClient client;

  ProgrammerGrpcApi(ClientChannel channel) : client = ProgrammerApiClient(channel);

  @override
  Future<void> writeControl(WriteControlRequest request) async {
    await this.client.writeControl(request);
  }

  @override
  Stream<ProgrammerState> observe() {
    return this.client.subscribeToProgrammer(SubscribeProgrammerRequest());
  }

  @override
  Future<void> selectFixtures(List<FixtureId> fixtureIds) async {
    await this.client.selectFixtures(SelectFixturesRequest(fixtures: fixtureIds));
  }

  @override
  Future<void> clear() async {
    await this.client.clear(ClearRequest());
  }

  @override
  Future<void> highlight(bool highlight) async {
    await this.client.highlight(HighlightRequest(highlight: highlight));
  }

  @override
  Future<void> store(int sequenceId, StoreRequest_Mode storeMode) async {
    await this.client.store(StoreRequest(sequenceId: sequenceId, storeMode: storeMode));
  }

  @override
  Future<Presets> getPresets() {
    return this.client.getPresets(PresetsRequest());
  }

  @override
  Future<void> callPreset(PresetId id) async {
    await this.client.callPreset(id);
  }

  @override
  Future<Groups> getGroups() {
    return this.client.getGroups(GroupsRequest());
  }

  @override
  Future<void> selectGroup(int id) async {
    await this.client.selectGroup(SelectGroupRequest(id: id));
  }

  @override
  Future<ProgrammerStatePointer?> getProgrammerPointer() async {
    return null;
  }

  @override
  Future<Group> addGroup(String name) {
    return this.client.addGroup(AddGroupRequest(name: name));
  }

  @override
  Future<void> assignFixturesToGroup(List<int> fixtures, Group group) async {
    await this.client.assignFixturesToGroup(AssignFixturesToGroupRequest(
        id: group.id, fixtures: fixtures.map((id) => FixtureId(fixture: id)).toList()));
  }

  @override
  Future<void> assignFixtureSelectionToGroup(Group group) async {
    await this.client.assignFixtureSelectionToGroup(AssignFixtureSelectionToGroupRequest(id: group.id));
  }

  @override
  Future<void> callEffect(int id) {
    // TODO: implement callEffect
    throw UnimplementedError();
  }
}
