///
//  Generated code. Do not modify.
//  source: mappings.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'mappings.pb.dart' as $3;
export 'mappings.pb.dart';

class MappingsApiClient extends $grpc.Client {
  static final _$addMapping =
      $grpc.ClientMethod<$3.MappingRequest, $3.MappingResult>(
          '/mizer.mappings.MappingsApi/AddMapping',
          ($3.MappingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.MappingResult.fromBuffer(value));

  MappingsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.MappingResult> addMapping($3.MappingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addMapping, request, options: options);
  }
}

abstract class MappingsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.mappings.MappingsApi';

  MappingsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.MappingRequest, $3.MappingResult>(
        'AddMapping',
        addMapping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.MappingRequest.fromBuffer(value),
        ($3.MappingResult value) => value.writeToBuffer()));
  }

  $async.Future<$3.MappingResult> addMapping_Pre(
      $grpc.ServiceCall call, $async.Future<$3.MappingRequest> request) async {
    return addMapping(call, await request);
  }

  $async.Future<$3.MappingResult> addMapping(
      $grpc.ServiceCall call, $3.MappingRequest request);
}
