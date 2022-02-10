import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pb.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart';
import 'ffi/plans.dart';

class PlansPluginApi implements PlansApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/plans");

  PlansPluginApi(this.bindings);

  @override
  Future<void> addFixture(String planId, FixtureId fixtureId) {
    // TODO: implement addFixture
    throw UnimplementedError();
  }

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
}
