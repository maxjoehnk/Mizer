import 'package:mizer/protos/settings.pb.dart';

export 'package:mizer/protos/settings.pb.dart';

abstract class SettingsApi {
  Future<Settings> loadSettings();
  Future<void> updateSetting(UpdateSetting update);
  Stream<Settings> watchSettings();

  Future<List<MidiDeviceProfile>> loadMidiDeviceProfiles();
  Future<void> reloadMidiDeviceProfiles();
  Future<void> reloadFixtureDefinitions();
}
