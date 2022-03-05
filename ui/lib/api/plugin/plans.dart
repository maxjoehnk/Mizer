import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/protos/plans.pb.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart';
import 'ffi/plans.dart';

class PlansPluginApi implements PlansApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/plans");

  PlansPluginApi(this.bindings);

  @override
  Future<Plans> getPlans() async {
    var response = await channel.invokeMethod("getPlans");

    return Plans.fromBuffer(_convertBuffer(response));
  }


  @override
  Future<Plans> addPlan(String name) async {
    var response = await channel.invokeMethod("addPlan", name);

    return Plans.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Plans> removePlan(String id) async {
    var response = await channel.invokeMethod("removePlan", id);

    return Plans.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Plans> renamePlan(String id, String name) async {
    var request = RenamePlanRequest(id: id, name: name);
    var response = await channel.invokeMethod("renamePlan", request.writeToBuffer());

    return Plans.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<FixturesRefPointer?> getFixturesPointer() async {
    int pointer = await channel.invokeMethod("getFixturesPointer");

    return this.bindings.openFixturesRef(pointer);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<void> addFixtureSelection(String planId) async {
    await channel.invokeMethod("addFixtureSelection", planId);
  }

  @override
  Future<void> moveSelection(String planId, double dx, double dy) async {
    var request = MoveFixturesRequest(planId: planId, x: dx.round(), y: dy.round());
    await channel.invokeMethod("moveSelection", request.writeToBuffer());
  }

  @override
  Future<void> moveFixture(MoveFixtureRequest request) async {
    await channel.invokeMethod("moveFixture", request.writeToBuffer());
  }
}
