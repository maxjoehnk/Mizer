///
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'plans.pb.dart' as $1;
export 'plans.pb.dart';

class PlansApiClient extends $grpc.Client {
  static final _$getPlans = $grpc.ClientMethod<$1.PlansRequest, $1.Plans>(
      '/mizer.plan.PlansApi/GetPlans',
      ($1.PlansRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Plans.fromBuffer(value));
  static final _$addPlan = $grpc.ClientMethod<$1.AddPlanRequest, $1.Plans>(
      '/mizer.plan.PlansApi/AddPlan',
      ($1.AddPlanRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Plans.fromBuffer(value));
  static final _$removePlan =
      $grpc.ClientMethod<$1.RemovePlanRequest, $1.Plans>(
          '/mizer.plan.PlansApi/RemovePlan',
          ($1.RemovePlanRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Plans.fromBuffer(value));
  static final _$renamePlan =
      $grpc.ClientMethod<$1.RenamePlanRequest, $1.Plans>(
          '/mizer.plan.PlansApi/RenamePlan',
          ($1.RenamePlanRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Plans.fromBuffer(value));
  static final _$moveFixtures =
      $grpc.ClientMethod<$1.MoveFixturesRequest, $1.Plans>(
          '/mizer.plan.PlansApi/MoveFixtures',
          ($1.MoveFixturesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Plans.fromBuffer(value));
  static final _$moveFixture =
      $grpc.ClientMethod<$1.MoveFixtureRequest, $1.Plans>(
          '/mizer.plan.PlansApi/MoveFixture',
          ($1.MoveFixtureRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Plans.fromBuffer(value));
  static final _$alignFixtures =
      $grpc.ClientMethod<$1.AlignFixturesRequest, $1.Plans>(
          '/mizer.plan.PlansApi/AlignFixtures',
          ($1.AlignFixturesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Plans.fromBuffer(value));

  PlansApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Plans> getPlans($1.PlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlans, request, options: options);
  }

  $grpc.ResponseFuture<$1.Plans> addPlan($1.AddPlanRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addPlan, request, options: options);
  }

  $grpc.ResponseFuture<$1.Plans> removePlan($1.RemovePlanRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removePlan, request, options: options);
  }

  $grpc.ResponseFuture<$1.Plans> renamePlan($1.RenamePlanRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renamePlan, request, options: options);
  }

  $grpc.ResponseFuture<$1.Plans> moveFixtures($1.MoveFixturesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$moveFixtures, request, options: options);
  }

  $grpc.ResponseFuture<$1.Plans> moveFixture($1.MoveFixtureRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$moveFixture, request, options: options);
  }

  $grpc.ResponseFuture<$1.Plans> alignFixtures($1.AlignFixturesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$alignFixtures, request, options: options);
  }
}

abstract class PlansApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.plan.PlansApi';

  PlansApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.PlansRequest, $1.Plans>(
        'GetPlans',
        getPlans_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PlansRequest.fromBuffer(value),
        ($1.Plans value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddPlanRequest, $1.Plans>(
        'AddPlan',
        addPlan_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AddPlanRequest.fromBuffer(value),
        ($1.Plans value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RemovePlanRequest, $1.Plans>(
        'RemovePlan',
        removePlan_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RemovePlanRequest.fromBuffer(value),
        ($1.Plans value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RenamePlanRequest, $1.Plans>(
        'RenamePlan',
        renamePlan_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RenamePlanRequest.fromBuffer(value),
        ($1.Plans value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MoveFixturesRequest, $1.Plans>(
        'MoveFixtures',
        moveFixtures_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MoveFixturesRequest.fromBuffer(value),
        ($1.Plans value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MoveFixtureRequest, $1.Plans>(
        'MoveFixture',
        moveFixture_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MoveFixtureRequest.fromBuffer(value),
        ($1.Plans value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AlignFixturesRequest, $1.Plans>(
        'AlignFixtures',
        alignFixtures_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AlignFixturesRequest.fromBuffer(value),
        ($1.Plans value) => value.writeToBuffer()));
  }

  $async.Future<$1.Plans> getPlans_Pre(
      $grpc.ServiceCall call, $async.Future<$1.PlansRequest> request) async {
    return getPlans(call, await request);
  }

  $async.Future<$1.Plans> addPlan_Pre(
      $grpc.ServiceCall call, $async.Future<$1.AddPlanRequest> request) async {
    return addPlan(call, await request);
  }

  $async.Future<$1.Plans> removePlan_Pre($grpc.ServiceCall call,
      $async.Future<$1.RemovePlanRequest> request) async {
    return removePlan(call, await request);
  }

  $async.Future<$1.Plans> renamePlan_Pre($grpc.ServiceCall call,
      $async.Future<$1.RenamePlanRequest> request) async {
    return renamePlan(call, await request);
  }

  $async.Future<$1.Plans> moveFixtures_Pre($grpc.ServiceCall call,
      $async.Future<$1.MoveFixturesRequest> request) async {
    return moveFixtures(call, await request);
  }

  $async.Future<$1.Plans> moveFixture_Pre($grpc.ServiceCall call,
      $async.Future<$1.MoveFixtureRequest> request) async {
    return moveFixture(call, await request);
  }

  $async.Future<$1.Plans> alignFixtures_Pre($grpc.ServiceCall call,
      $async.Future<$1.AlignFixturesRequest> request) async {
    return alignFixtures(call, await request);
  }

  $async.Future<$1.Plans> getPlans(
      $grpc.ServiceCall call, $1.PlansRequest request);
  $async.Future<$1.Plans> addPlan(
      $grpc.ServiceCall call, $1.AddPlanRequest request);
  $async.Future<$1.Plans> removePlan(
      $grpc.ServiceCall call, $1.RemovePlanRequest request);
  $async.Future<$1.Plans> renamePlan(
      $grpc.ServiceCall call, $1.RenamePlanRequest request);
  $async.Future<$1.Plans> moveFixtures(
      $grpc.ServiceCall call, $1.MoveFixturesRequest request);
  $async.Future<$1.Plans> moveFixture(
      $grpc.ServiceCall call, $1.MoveFixtureRequest request);
  $async.Future<$1.Plans> alignFixtures(
      $grpc.ServiceCall call, $1.AlignFixturesRequest request);
}
