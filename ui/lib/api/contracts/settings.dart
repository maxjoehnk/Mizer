import 'package:mizer/protos/settings.pb.dart';

export 'package:mizer/protos/settings.pb.dart';

abstract class SettingsApi {
  Future<Settings> loadSettings();
  Future<void> saveSettings(Settings settings);
}
