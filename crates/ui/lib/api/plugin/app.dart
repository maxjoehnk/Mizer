import 'package:flutter/services.dart';

import 'package:mizer/api/contracts/settings.dart';

class ApplicationPluginApi implements SettingsApi {
  final MethodChannel channel = const MethodChannel("mizer.live/application");
  final EventChannel settingsEvents = const EventChannel("mizer.live/settings/watch");

  Future<void> shutdown() async {
    await channel.invokeMethod("shutdown");
  }

  Future<void> reboot() async {
    await channel.invokeMethod("reboot");
  }

  Future<void> exit() async {
    await channel.invokeMethod("exit");
  }

  @override
  Future<Settings> loadSettings() async {
    var settings = await channel.invokeMethod("loadSettings");

    return Settings.fromBuffer(_convertBuffer(settings));
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    await channel.invokeMethod("saveSettings", settings.writeToBuffer());
  }

  @override
  Stream<Settings> watchSettings() {
    return settingsEvents.receiveBroadcastStream()
        .map((buffer) => Settings.fromBuffer(_convertBuffer(buffer)));
  }

  @override
  Future<List<MidiDeviceProfile>> loadMidiDeviceProfiles() async {
    var response = await channel.invokeMethod("loadMidiDeviceProfiles");
    var profiles = MidiDeviceProfiles.fromBuffer(_convertBuffer(response));

    return profiles.profiles;
  }

  @override
  Future<void> reloadMidiDeviceProfiles() async {
    await channel.invokeMethod("reloadMidiDeviceProfiles");
  }

  @override
  Future<void> reloadFixtureDefinitions() async {
    await channel.invokeMethod("reloadFixtureDefinitions");
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
