import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionPluginApi implements SessionApi {
  final MethodChannel channel = const MethodChannel("mizer.live/session");
  final EventChannel sessionEvents = const EventChannel("mizer.live/session/watch");
  final EventChannel historyEvents = const EventChannel("mizer.live/history/watch");

  @override
  Stream<SessionState> watchSession() {
    return sessionEvents.receiveBroadcastStream().map((buffer) {
      return SessionState.fromBuffer(_convertBuffer(buffer));
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

  @override
  Future<void> redo() async {
    await channel.invokeMethod("redo");
  }

  @override
  Future<void> undo() async {
    await channel.invokeMethod("undo");
  }

  @override
  Stream<History> getHistory() {
    return historyEvents.receiveBroadcastStream().map((buffer) {
      return History.fromBuffer(_convertBuffer(buffer));
    });
  }
}
