import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionPluginApi implements SessionApi {
  final MethodChannel channel = const MethodChannel("mizer.live/session");

  @override
  Stream<Session> watchSession() {
    return Stream.empty();
  }

  @override
  Future<void> closeProject() async {
    await channel.invokeMethod("closeProject");
  }

  @override
  Future<void> newProject() async {
    await channel.invokeMethod("newProject");
  }

  @override
  Future<void> openProject(String path) async {
    await channel.invokeMethod("openProject", path);
  }

  @override
  Future<void> saveProject() async {
    log("saving project");
    await channel.invokeMethod("saveProject");
    log("saved project");
  }
}
