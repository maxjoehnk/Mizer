///
//  Generated code. Do not modify.
//  source: mappings.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'mappings.pb.dart' as $1;
export 'mappings.pb.dart';

class MappingsApiClient extends $grpc.Client {
  static final _$addMapping =
      $grpc.ClientMethod<$1.MappingRequest, $1.MappingResult>(
          '/mizer.mappings.MappingsApi/AddMapping',
          ($1.MappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.MappingResult.fromBuffer(value));

  MappingsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.MappingResult> addMapping($1.MappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMapping, request, options: options);
  }
}

abstract class MappingsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.mappings.MappingsApi';

  MappingsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.MappingRequest, $1.MappingResult>(
        'AddMapping',
        addMapping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.MappingRequest.fromBuffer(value),
        ($1.MappingResult value) => value.writeToBuffer()));
  }

  $async.Future<$1.MappingResult> addMapping_Pre(
      $grpc.ServiceCall call, $async.Future<$1.MappingRequest> request) async {
    return addMapping(call, await request);
  }

  $async.Future<$1.MappingResult> addMapping(
      $grpc.ServiceCall call, $1.MappingRequest request);
}
