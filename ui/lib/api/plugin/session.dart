import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionPluginApi implements SessionApi {
  final MethodChannel channel = const MethodChannel("mizer.live/session");
  final EventChannel sessionEvents = const EventChannel("mizer.live/session/watch");

  @override
  Stream<Session> watchSession() {
    return sessionEvents.receiveBroadcastStream().map((buffer) {
      return Session.fromBuffer(_convertBuffer(buffer));
    });
  }

  @override
  Future<void> newProject() async {
    await channel.invokeMethod("newProject");
  }

  @override
  Future<void> loadProject(String path) async {
    await channel.invokeMethod("loadProject", path);
  }

  @override
  Future<void> saveProject() async {
    log("saving project");
    await channel.invokeMethod("saveProject");
    log("saved project");
  }

  @override
  Future<void> saveProjectAs(String path) async {
    await channel.invokeMethod("saveProjectAs", path);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
