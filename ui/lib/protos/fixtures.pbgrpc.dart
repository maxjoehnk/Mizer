///
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'fixtures.pb.dart' as $0;
export 'fixtures.pb.dart';

class FixturesApiClient extends $grpc.Client {
  static final _$getFixtures =
      $grpc.ClientMethod<$0.GetFixturesRequest, $0.Fixtures>(
          '/mizer.FixturesApi/GetFixtures',
          ($0.GetFixturesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Fixtures.fromBuffer(value));

  FixturesApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Fixtures> getFixtures($0.GetFixturesRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getFixtures, request, options: options);
  }
}

abstract class FixturesApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.FixturesApi';

  FixturesApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetFixturesRequest, $0.Fixtures>(
        'GetFixtures',
        getFixtures_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFixturesRequest.fromBuffer(value),
        ($0.Fixtures value) => value.writeToBuffer()));
  }

  $async.Future<$0.Fixtures> getFixtures_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetFixturesRequest> request) async {
    return getFixtures(call, await request);
  }

  $async.Future<$0.Fixtures> getFixtures(
      $grpc.ServiceCall call, $0.GetFixturesRequest request);
}
