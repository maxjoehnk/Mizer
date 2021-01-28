///
//  Generated code. Do not modify.
//  source: media.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'media.pb.dart' as $0;
export 'media.pb.dart';

class MediaApiClient extends $grpc.Client {
  static final _$createTag = $grpc.ClientMethod<$0.CreateMediaTag, $0.MediaTag>(
      '/mizer.MediaApi/CreateTag',
      ($0.CreateMediaTag value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MediaTag.fromBuffer(value));
  static final _$getTagsWithMedia =
      $grpc.ClientMethod<$0.GetMediaTags, $0.GroupedMediaFiles>(
          '/mizer.MediaApi/GetTagsWithMedia',
          ($0.GetMediaTags value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GroupedMediaFiles.fromBuffer(value));

  MediaApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.MediaTag> createTag($0.CreateMediaTag request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$createTag, request, options: options);
  }

  $grpc.ResponseFuture<$0.GroupedMediaFiles> getTagsWithMedia(
      $0.GetMediaTags request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getTagsWithMedia, request, options: options);
  }
}

abstract class MediaApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.MediaApi';

  MediaApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateMediaTag, $0.MediaTag>(
        'CreateTag',
        createTag_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateMediaTag.fromBuffer(value),
        ($0.MediaTag value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMediaTags, $0.GroupedMediaFiles>(
        'GetTagsWithMedia',
        getTagsWithMedia_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMediaTags.fromBuffer(value),
        ($0.GroupedMediaFiles value) => value.writeToBuffer()));
  }

  $async.Future<$0.MediaTag> createTag_Pre(
      $grpc.ServiceCall call, $async.Future<$0.CreateMediaTag> request) async {
    return createTag(call, await request);
  }

  $async.Future<$0.GroupedMediaFiles> getTagsWithMedia_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetMediaTags> request) async {
    return getTagsWithMedia(call, await request);
  }

  $async.Future<$0.MediaTag> createTag(
      $grpc.ServiceCall call, $0.CreateMediaTag request);
  $async.Future<$0.GroupedMediaFiles> getTagsWithMedia(
      $grpc.ServiceCall call, $0.GetMediaTags request);
}
