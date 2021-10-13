import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/settings.dart';

class SettingsPluginApi implements SettingsApi {
  final MethodChannel channel = const MethodChannel("mizer.live/settings");

  @override
  Future<Settings> loadSettings() async {
    var settings = await channel.invokeMethod("loadSettings");

    return Settings.fromBuffer(_convertBuffer(settings));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
