///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'programmer.pb.dart' as $1;

import 'nodes.pbenum.dart';

export 'nodes.pbenum.dart';

class AddNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..e<Node_NodeType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Node_NodeType.Fader, valueOf: Node_NodeType.valueOf, enumValues: Node_NodeType.values)
    ..aOM<NodePosition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: NodePosition.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  AddNodeRequest._() : super();
  factory AddNodeRequest({
    Node_NodeType? type,
    NodePosition? position,
    $core.String? parent,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (position != null) {
      _result.position = position;
    }
    if (parent != null) {
      _result.parent = parent;
    }
    return _result;
  }
  factory AddNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddNodeRequest clone() => AddNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddNodeRequest copyWith(void Function(AddNodeRequest) updates) => super.copyWith((message) => updates(message as AddNodeRequest)) as AddNodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddNodeRequest create() => AddNodeRequest._();
  AddNodeRequest createEmptyInstance() => create();
  static $pb.PbList<AddNodeRequest> createRepeated() => $pb.PbList<AddNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static AddNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddNodeRequest>(create);
  static AddNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Node_NodeType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Node_NodeType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  NodePosition get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(NodePosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  NodePosition ensurePosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get parent => $_getSZ(2);
  @$pb.TagNumber(3)
  set parent($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParent() => $_has(2);
  @$pb.TagNumber(3)
  void clearParent() => clearField(3);
}

class DuplicateNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DuplicateNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  DuplicateNodeRequest._() : super();
  factory DuplicateNodeRequest({
    $core.String? path,
    $core.String? parent,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (parent != null) {
      _result.parent = parent;
    }
    return _result;
  }
  factory DuplicateNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DuplicateNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DuplicateNodeRequest clone() => DuplicateNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DuplicateNodeRequest copyWith(void Function(DuplicateNodeRequest) updates) => super.copyWith((message) => updates(message as DuplicateNodeRequest)) as DuplicateNodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DuplicateNodeRequest create() => DuplicateNodeRequest._();
  DuplicateNodeRequest createEmptyInstance() => create();
  static $pb.PbList<DuplicateNodeRequest> createRepeated() => $pb.PbList<DuplicateNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static DuplicateNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DuplicateNodeRequest>(create);
  static DuplicateNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get parent => $_getSZ(1);
  @$pb.TagNumber(2)
  set parent($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasParent() => $_has(1);
  @$pb.TagNumber(2)
  void clearParent() => clearField(2);
}

class NodesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  NodesRequest._() : super();
  factory NodesRequest() => create();
  factory NodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodesRequest clone() => NodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodesRequest copyWith(void Function(NodesRequest) updates) => super.copyWith((message) => updates(message as NodesRequest)) as NodesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodesRequest create() => NodesRequest._();
  NodesRequest createEmptyInstance() => create();
  static $pb.PbList<NodesRequest> createRepeated() => $pb.PbList<NodesRequest>();
  @$core.pragma('dart2js:noInline')
  static NodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodesRequest>(create);
  static NodesRequest? _defaultInstance;
}

class WriteControl extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteControl', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  WriteControl._() : super();
  factory WriteControl({
    $core.String? path,
    $core.String? port,
    $core.double? value,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (port != null) {
      _result.port = port;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory WriteControl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteControl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteControl clone() => WriteControl()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteControl copyWith(void Function(WriteControl) updates) => super.copyWith((message) => updates(message as WriteControl)) as WriteControl; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteControl create() => WriteControl._();
  WriteControl createEmptyInstance() => create();
  static $pb.PbList<WriteControl> createRepeated() => $pb.PbList<WriteControl>();
  @$core.pragma('dart2js:noInline')
  static WriteControl getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteControl>(create);
  static WriteControl? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get port => $_getSZ(1);
  @$pb.TagNumber(2)
  set port($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get value => $_getN(2);
  @$pb.TagNumber(3)
  set value($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
}

class WriteResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  WriteResponse._() : super();
  factory WriteResponse() => create();
  factory WriteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteResponse clone() => WriteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteResponse copyWith(void Function(WriteResponse) updates) => super.copyWith((message) => updates(message as WriteResponse)) as WriteResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteResponse create() => WriteResponse._();
  WriteResponse createEmptyInstance() => create();
  static $pb.PbList<WriteResponse> createRepeated() => $pb.PbList<WriteResponse>();
  @$core.pragma('dart2js:noInline')
  static WriteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteResponse>(create);
  static WriteResponse? _defaultInstance;
}

class UpdateNodeConfigRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateNodeConfigRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOM<NodeConfig>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'config', subBuilder: NodeConfig.create)
    ..hasRequiredFields = false
  ;

  UpdateNodeConfigRequest._() : super();
  factory UpdateNodeConfigRequest({
    $core.String? path,
    NodeConfig? config,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (config != null) {
      _result.config = config;
    }
    return _result;
  }
  factory UpdateNodeConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNodeConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNodeConfigRequest clone() => UpdateNodeConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNodeConfigRequest copyWith(void Function(UpdateNodeConfigRequest) updates) => super.copyWith((message) => updates(message as UpdateNodeConfigRequest)) as UpdateNodeConfigRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateNodeConfigRequest create() => UpdateNodeConfigRequest._();
  UpdateNodeConfigRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateNodeConfigRequest> createRepeated() => $pb.PbList<UpdateNodeConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateNodeConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateNodeConfigRequest>(create);
  static UpdateNodeConfigRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  NodeConfig get config => $_getN(1);
  @$pb.TagNumber(2)
  set config(NodeConfig v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasConfig() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfig() => clearField(2);
  @$pb.TagNumber(2)
  NodeConfig ensureConfig() => $_ensure(1);
}

class UpdateNodeConfigResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateNodeConfigResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  UpdateNodeConfigResponse._() : super();
  factory UpdateNodeConfigResponse() => create();
  factory UpdateNodeConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNodeConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNodeConfigResponse clone() => UpdateNodeConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNodeConfigResponse copyWith(void Function(UpdateNodeConfigResponse) updates) => super.copyWith((message) => updates(message as UpdateNodeConfigResponse)) as UpdateNodeConfigResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateNodeConfigResponse create() => UpdateNodeConfigResponse._();
  UpdateNodeConfigResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateNodeConfigResponse> createRepeated() => $pb.PbList<UpdateNodeConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateNodeConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateNodeConfigResponse>(create);
  static UpdateNodeConfigResponse? _defaultInstance;
}

class MoveNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MoveNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOM<NodePosition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: NodePosition.create)
    ..hasRequiredFields = false
  ;

  MoveNodeRequest._() : super();
  factory MoveNodeRequest({
    $core.String? path,
    NodePosition? position,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory MoveNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveNodeRequest clone() => MoveNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveNodeRequest copyWith(void Function(MoveNodeRequest) updates) => super.copyWith((message) => updates(message as MoveNodeRequest)) as MoveNodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MoveNodeRequest create() => MoveNodeRequest._();
  MoveNodeRequest createEmptyInstance() => create();
  static $pb.PbList<MoveNodeRequest> createRepeated() => $pb.PbList<MoveNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static MoveNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveNodeRequest>(create);
  static MoveNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  NodePosition get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(NodePosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  NodePosition ensurePosition() => $_ensure(1);
}

class MoveNodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MoveNodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  MoveNodeResponse._() : super();
  factory MoveNodeResponse() => create();
  factory MoveNodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveNodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveNodeResponse clone() => MoveNodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveNodeResponse copyWith(void Function(MoveNodeResponse) updates) => super.copyWith((message) => updates(message as MoveNodeResponse)) as MoveNodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MoveNodeResponse create() => MoveNodeResponse._();
  MoveNodeResponse createEmptyInstance() => create();
  static $pb.PbList<MoveNodeResponse> createRepeated() => $pb.PbList<MoveNodeResponse>();
  @$core.pragma('dart2js:noInline')
  static MoveNodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveNodeResponse>(create);
  static MoveNodeResponse? _defaultInstance;
}

class ShowNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ShowNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOM<NodePosition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: NodePosition.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  ShowNodeRequest._() : super();
  factory ShowNodeRequest({
    $core.String? path,
    NodePosition? position,
    $core.String? parent,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (position != null) {
      _result.position = position;
    }
    if (parent != null) {
      _result.parent = parent;
    }
    return _result;
  }
  factory ShowNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ShowNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ShowNodeRequest clone() => ShowNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ShowNodeRequest copyWith(void Function(ShowNodeRequest) updates) => super.copyWith((message) => updates(message as ShowNodeRequest)) as ShowNodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ShowNodeRequest create() => ShowNodeRequest._();
  ShowNodeRequest createEmptyInstance() => create();
  static $pb.PbList<ShowNodeRequest> createRepeated() => $pb.PbList<ShowNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static ShowNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShowNodeRequest>(create);
  static ShowNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  NodePosition get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(NodePosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  NodePosition ensurePosition() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get parent => $_getSZ(2);
  @$pb.TagNumber(3)
  set parent($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParent() => $_has(2);
  @$pb.TagNumber(3)
  void clearParent() => clearField(3);
}

class ShowNodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ShowNodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ShowNodeResponse._() : super();
  factory ShowNodeResponse() => create();
  factory ShowNodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ShowNodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ShowNodeResponse clone() => ShowNodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ShowNodeResponse copyWith(void Function(ShowNodeResponse) updates) => super.copyWith((message) => updates(message as ShowNodeResponse)) as ShowNodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ShowNodeResponse create() => ShowNodeResponse._();
  ShowNodeResponse createEmptyInstance() => create();
  static $pb.PbList<ShowNodeResponse> createRepeated() => $pb.PbList<ShowNodeResponse>();
  @$core.pragma('dart2js:noInline')
  static ShowNodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShowNodeResponse>(create);
  static ShowNodeResponse? _defaultInstance;
}

class RenameNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenameNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newName')
    ..hasRequiredFields = false
  ;

  RenameNodeRequest._() : super();
  factory RenameNodeRequest({
    $core.String? path,
    $core.String? newName,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (newName != null) {
      _result.newName = newName;
    }
    return _result;
  }
  factory RenameNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameNodeRequest clone() => RenameNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameNodeRequest copyWith(void Function(RenameNodeRequest) updates) => super.copyWith((message) => updates(message as RenameNodeRequest)) as RenameNodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenameNodeRequest create() => RenameNodeRequest._();
  RenameNodeRequest createEmptyInstance() => create();
  static $pb.PbList<RenameNodeRequest> createRepeated() => $pb.PbList<RenameNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static RenameNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameNodeRequest>(create);
  static RenameNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get newName => $_getSZ(1);
  @$pb.TagNumber(2)
  set newName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewName() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewName() => clearField(2);
}

class RenameNodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenameNodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  RenameNodeResponse._() : super();
  factory RenameNodeResponse() => create();
  factory RenameNodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameNodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameNodeResponse clone() => RenameNodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameNodeResponse copyWith(void Function(RenameNodeResponse) updates) => super.copyWith((message) => updates(message as RenameNodeResponse)) as RenameNodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenameNodeResponse create() => RenameNodeResponse._();
  RenameNodeResponse createEmptyInstance() => create();
  static $pb.PbList<RenameNodeResponse> createRepeated() => $pb.PbList<RenameNodeResponse>();
  @$core.pragma('dart2js:noInline')
  static RenameNodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameNodeResponse>(create);
  static RenameNodeResponse? _defaultInstance;
}

class GroupNodesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupNodesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodes')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  GroupNodesRequest._() : super();
  factory GroupNodesRequest({
    $core.Iterable<$core.String>? nodes,
    $core.String? parent,
  }) {
    final _result = create();
    if (nodes != null) {
      _result.nodes.addAll(nodes);
    }
    if (parent != null) {
      _result.parent = parent;
    }
    return _result;
  }
  factory GroupNodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupNodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupNodesRequest clone() => GroupNodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupNodesRequest copyWith(void Function(GroupNodesRequest) updates) => super.copyWith((message) => updates(message as GroupNodesRequest)) as GroupNodesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupNodesRequest create() => GroupNodesRequest._();
  GroupNodesRequest createEmptyInstance() => create();
  static $pb.PbList<GroupNodesRequest> createRepeated() => $pb.PbList<GroupNodesRequest>();
  @$core.pragma('dart2js:noInline')
  static GroupNodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupNodesRequest>(create);
  static GroupNodesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get nodes => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get parent => $_getSZ(1);
  @$pb.TagNumber(2)
  set parent($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasParent() => $_has(1);
  @$pb.TagNumber(2)
  void clearParent() => clearField(2);
}

class GroupNodesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupNodesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GroupNodesResponse._() : super();
  factory GroupNodesResponse() => create();
  factory GroupNodesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupNodesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupNodesResponse clone() => GroupNodesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupNodesResponse copyWith(void Function(GroupNodesResponse) updates) => super.copyWith((message) => updates(message as GroupNodesResponse)) as GroupNodesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupNodesResponse create() => GroupNodesResponse._();
  GroupNodesResponse createEmptyInstance() => create();
  static $pb.PbList<GroupNodesResponse> createRepeated() => $pb.PbList<GroupNodesResponse>();
  @$core.pragma('dart2js:noInline')
  static GroupNodesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupNodesResponse>(create);
  static GroupNodesResponse? _defaultInstance;
}

class DeleteNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  DeleteNodeRequest._() : super();
  factory DeleteNodeRequest({
    $core.String? path,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory DeleteNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteNodeRequest clone() => DeleteNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteNodeRequest copyWith(void Function(DeleteNodeRequest) updates) => super.copyWith((message) => updates(message as DeleteNodeRequest)) as DeleteNodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteNodeRequest create() => DeleteNodeRequest._();
  DeleteNodeRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteNodeRequest> createRepeated() => $pb.PbList<DeleteNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteNodeRequest>(create);
  static DeleteNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class DeleteNodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteNodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  DeleteNodeResponse._() : super();
  factory DeleteNodeResponse() => create();
  factory DeleteNodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteNodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteNodeResponse clone() => DeleteNodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteNodeResponse copyWith(void Function(DeleteNodeResponse) updates) => super.copyWith((message) => updates(message as DeleteNodeResponse)) as DeleteNodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteNodeResponse create() => DeleteNodeResponse._();
  DeleteNodeResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteNodeResponse> createRepeated() => $pb.PbList<DeleteNodeResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteNodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteNodeResponse>(create);
  static DeleteNodeResponse? _defaultInstance;
}

class HideNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HideNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  HideNodeRequest._() : super();
  factory HideNodeRequest({
    $core.String? path,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory HideNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HideNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HideNodeRequest clone() => HideNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HideNodeRequest copyWith(void Function(HideNodeRequest) updates) => super.copyWith((message) => updates(message as HideNodeRequest)) as HideNodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HideNodeRequest create() => HideNodeRequest._();
  HideNodeRequest createEmptyInstance() => create();
  static $pb.PbList<HideNodeRequest> createRepeated() => $pb.PbList<HideNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static HideNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HideNodeRequest>(create);
  static HideNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class HideNodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HideNodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  HideNodeResponse._() : super();
  factory HideNodeResponse() => create();
  factory HideNodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HideNodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HideNodeResponse clone() => HideNodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HideNodeResponse copyWith(void Function(HideNodeResponse) updates) => super.copyWith((message) => updates(message as HideNodeResponse)) as HideNodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HideNodeResponse create() => HideNodeResponse._();
  HideNodeResponse createEmptyInstance() => create();
  static $pb.PbList<HideNodeResponse> createRepeated() => $pb.PbList<HideNodeResponse>();
  @$core.pragma('dart2js:noInline')
  static HideNodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HideNodeResponse>(create);
  static HideNodeResponse? _defaultInstance;
}

class Nodes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Nodes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<Node>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..pc<NodeConnection>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: NodeConnection.create)
    ..pc<Node>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allNodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..hasRequiredFields = false
  ;

  Nodes._() : super();
  factory Nodes({
    $core.Iterable<Node>? nodes,
    $core.Iterable<NodeConnection>? channels,
    $core.Iterable<Node>? allNodes,
  }) {
    final _result = create();
    if (nodes != null) {
      _result.nodes.addAll(nodes);
    }
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    if (allNodes != null) {
      _result.allNodes.addAll(allNodes);
    }
    return _result;
  }
  factory Nodes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Nodes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Nodes clone() => Nodes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Nodes copyWith(void Function(Nodes) updates) => super.copyWith((message) => updates(message as Nodes)) as Nodes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Nodes create() => Nodes._();
  Nodes createEmptyInstance() => create();
  static $pb.PbList<Nodes> createRepeated() => $pb.PbList<Nodes>();
  @$core.pragma('dart2js:noInline')
  static Nodes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Nodes>(create);
  static Nodes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Node> get nodes => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<NodeConnection> get channels => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<Node> get allNodes => $_getList(2);
}

class NodeConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetNode', protoName: 'targetNode')
    ..aOM<Port>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetPort', protoName: 'targetPort', subBuilder: Port.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceNode', protoName: 'sourceNode')
    ..aOM<Port>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourcePort', protoName: 'sourcePort', subBuilder: Port.create)
    ..e<ChannelProtocol>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: ChannelProtocol.SINGLE, valueOf: ChannelProtocol.valueOf, enumValues: ChannelProtocol.values)
    ..hasRequiredFields = false
  ;

  NodeConnection._() : super();
  factory NodeConnection({
    $core.String? targetNode,
    Port? targetPort,
    $core.String? sourceNode,
    Port? sourcePort,
    ChannelProtocol? protocol,
  }) {
    final _result = create();
    if (targetNode != null) {
      _result.targetNode = targetNode;
    }
    if (targetPort != null) {
      _result.targetPort = targetPort;
    }
    if (sourceNode != null) {
      _result.sourceNode = sourceNode;
    }
    if (sourcePort != null) {
      _result.sourcePort = sourcePort;
    }
    if (protocol != null) {
      _result.protocol = protocol;
    }
    return _result;
  }
  factory NodeConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeConnection clone() => NodeConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeConnection copyWith(void Function(NodeConnection) updates) => super.copyWith((message) => updates(message as NodeConnection)) as NodeConnection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodeConnection create() => NodeConnection._();
  NodeConnection createEmptyInstance() => create();
  static $pb.PbList<NodeConnection> createRepeated() => $pb.PbList<NodeConnection>();
  @$core.pragma('dart2js:noInline')
  static NodeConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeConnection>(create);
  static NodeConnection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get targetNode => $_getSZ(0);
  @$pb.TagNumber(1)
  set targetNode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetNode() => clearField(1);

  @$pb.TagNumber(2)
  Port get targetPort => $_getN(1);
  @$pb.TagNumber(2)
  set targetPort(Port v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetPort() => clearField(2);
  @$pb.TagNumber(2)
  Port ensureTargetPort() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get sourceNode => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceNode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSourceNode() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceNode() => clearField(3);

  @$pb.TagNumber(4)
  Port get sourcePort => $_getN(3);
  @$pb.TagNumber(4)
  set sourcePort(Port v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourcePort() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourcePort() => clearField(4);
  @$pb.TagNumber(4)
  Port ensureSourcePort() => $_ensure(3);

  @$pb.TagNumber(5)
  ChannelProtocol get protocol => $_getN(4);
  @$pb.TagNumber(5)
  set protocol(ChannelProtocol v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasProtocol() => $_has(4);
  @$pb.TagNumber(5)
  void clearProtocol() => clearField(5);
}

class Node extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Node', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..e<Node_NodeType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Node_NodeType.Fader, valueOf: Node_NodeType.valueOf, enumValues: Node_NodeType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..pc<Port>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..pc<Port>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..aOM<NodeDesigner>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'designer', subBuilder: NodeDesigner.create)
    ..e<Node_NodePreviewType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preview', $pb.PbFieldType.OE, defaultOrMaker: Node_NodePreviewType.History, valueOf: Node_NodePreviewType.valueOf, enumValues: Node_NodePreviewType.values)
    ..aOM<NodeConfig>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'config', subBuilder: NodeConfig.create)
    ..hasRequiredFields = false
  ;

  Node._() : super();
  factory Node({
    Node_NodeType? type,
    $core.String? path,
    $core.Iterable<Port>? inputs,
    $core.Iterable<Port>? outputs,
    NodeDesigner? designer,
    Node_NodePreviewType? preview,
    NodeConfig? config,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (path != null) {
      _result.path = path;
    }
    if (inputs != null) {
      _result.inputs.addAll(inputs);
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    if (designer != null) {
      _result.designer = designer;
    }
    if (preview != null) {
      _result.preview = preview;
    }
    if (config != null) {
      _result.config = config;
    }
    return _result;
  }
  factory Node.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Node.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Node clone() => Node()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Node copyWith(void Function(Node) updates) => super.copyWith((message) => updates(message as Node)) as Node; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Node create() => Node._();
  Node createEmptyInstance() => create();
  static $pb.PbList<Node> createRepeated() => $pb.PbList<Node>();
  @$core.pragma('dart2js:noInline')
  static Node getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Node>(create);
  static Node? _defaultInstance;

  @$pb.TagNumber(1)
  Node_NodeType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Node_NodeType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Port> get inputs => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Port> get outputs => $_getList(3);

  @$pb.TagNumber(5)
  NodeDesigner get designer => $_getN(4);
  @$pb.TagNumber(5)
  set designer(NodeDesigner v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDesigner() => $_has(4);
  @$pb.TagNumber(5)
  void clearDesigner() => clearField(5);
  @$pb.TagNumber(5)
  NodeDesigner ensureDesigner() => $_ensure(4);

  @$pb.TagNumber(6)
  Node_NodePreviewType get preview => $_getN(5);
  @$pb.TagNumber(6)
  set preview(Node_NodePreviewType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPreview() => $_has(5);
  @$pb.TagNumber(6)
  void clearPreview() => clearField(6);

  @$pb.TagNumber(7)
  NodeConfig get config => $_getN(6);
  @$pb.TagNumber(7)
  set config(NodeConfig v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasConfig() => $_has(6);
  @$pb.TagNumber(7)
  void clearConfig() => clearField(7);
  @$pb.TagNumber(7)
  NodeConfig ensureConfig() => $_ensure(6);
}

enum NodeConfig_Type {
  oscillatorConfig, 
  scriptingConfig, 
  sequenceConfig, 
  clockConfig, 
  fixtureConfig, 
  buttonConfig, 
  faderConfig, 
  ildaFileConfig, 
  laserConfig, 
  pixelPatternConfig, 
  pixelDmxConfig, 
  dmxOutputConfig, 
  midiInputConfig, 
  midiOutputConfig, 
  opcOutputConfig, 
  oscInputConfig, 
  oscOutputConfig, 
  videoColorBalanceConfig, 
  videoEffectConfig, 
  videoFileConfig, 
  videoOutputConfig, 
  videoTransformConfig, 
  selectConfig, 
  mergeConfig, 
  envelopeConfig, 
  sequencerConfig, 
  programmerConfig, 
  groupConfig, 
  presetConfig, 
  colorRgbConfig, 
  colorHsvConfig, 
  gamepadNodeConfig, 
  thresholdConfig, 
  encoderConfig, 
  containerConfig, 
  mathConfig, 
  mqttInputConfig, 
  mqttOutputConfig, 
  numberToDataConfig, 
  dataToNumberConfig, 
  valueConfig, 
  extractConfig, 
  planScreenConfig, 
  delayConfig, 
  rampConfig, 
  noiseConfig, 
  labelConfig, 
  transportConfig, 
  g13InputConfig, 
  g13OutputConfig, 
  constantNumberConfig, 
  conditionalConfig, 
  timecodeControlConfig, 
  timecodeOutputConfig, 
  audioFileConfig, 
  audioOutputConfig, 
  audioVolumeConfig, 
  audioInputConfig, 
  audioMixConfig, 
  audioMeterConfig, 
  templateConfig, 
  notSet
}

class NodeConfig extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, NodeConfig_Type> _NodeConfig_TypeByTag = {
    10 : NodeConfig_Type.oscillatorConfig,
    11 : NodeConfig_Type.scriptingConfig,
    12 : NodeConfig_Type.sequenceConfig,
    13 : NodeConfig_Type.clockConfig,
    14 : NodeConfig_Type.fixtureConfig,
    15 : NodeConfig_Type.buttonConfig,
    16 : NodeConfig_Type.faderConfig,
    17 : NodeConfig_Type.ildaFileConfig,
    18 : NodeConfig_Type.laserConfig,
    19 : NodeConfig_Type.pixelPatternConfig,
    20 : NodeConfig_Type.pixelDmxConfig,
    21 : NodeConfig_Type.dmxOutputConfig,
    22 : NodeConfig_Type.midiInputConfig,
    23 : NodeConfig_Type.midiOutputConfig,
    24 : NodeConfig_Type.opcOutputConfig,
    25 : NodeConfig_Type.oscInputConfig,
    26 : NodeConfig_Type.oscOutputConfig,
    27 : NodeConfig_Type.videoColorBalanceConfig,
    28 : NodeConfig_Type.videoEffectConfig,
    29 : NodeConfig_Type.videoFileConfig,
    30 : NodeConfig_Type.videoOutputConfig,
    31 : NodeConfig_Type.videoTransformConfig,
    32 : NodeConfig_Type.selectConfig,
    33 : NodeConfig_Type.mergeConfig,
    34 : NodeConfig_Type.envelopeConfig,
    35 : NodeConfig_Type.sequencerConfig,
    36 : NodeConfig_Type.programmerConfig,
    37 : NodeConfig_Type.groupConfig,
    38 : NodeConfig_Type.presetConfig,
    40 : NodeConfig_Type.colorRgbConfig,
    41 : NodeConfig_Type.colorHsvConfig,
    42 : NodeConfig_Type.gamepadNodeConfig,
    43 : NodeConfig_Type.thresholdConfig,
    44 : NodeConfig_Type.encoderConfig,
    45 : NodeConfig_Type.containerConfig,
    46 : NodeConfig_Type.mathConfig,
    47 : NodeConfig_Type.mqttInputConfig,
    48 : NodeConfig_Type.mqttOutputConfig,
    49 : NodeConfig_Type.numberToDataConfig,
    50 : NodeConfig_Type.dataToNumberConfig,
    51 : NodeConfig_Type.valueConfig,
    52 : NodeConfig_Type.extractConfig,
    53 : NodeConfig_Type.planScreenConfig,
    54 : NodeConfig_Type.delayConfig,
    55 : NodeConfig_Type.rampConfig,
    56 : NodeConfig_Type.noiseConfig,
    57 : NodeConfig_Type.labelConfig,
    58 : NodeConfig_Type.transportConfig,
    59 : NodeConfig_Type.g13InputConfig,
    60 : NodeConfig_Type.g13OutputConfig,
    61 : NodeConfig_Type.constantNumberConfig,
    62 : NodeConfig_Type.conditionalConfig,
    63 : NodeConfig_Type.timecodeControlConfig,
    64 : NodeConfig_Type.timecodeOutputConfig,
    65 : NodeConfig_Type.audioFileConfig,
    66 : NodeConfig_Type.audioOutputConfig,
    67 : NodeConfig_Type.audioVolumeConfig,
    68 : NodeConfig_Type.audioInputConfig,
    69 : NodeConfig_Type.audioMixConfig,
    70 : NodeConfig_Type.audioMeterConfig,
    71 : NodeConfig_Type.templateConfig,
    0 : NodeConfig_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..oo(0, [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71])
    ..aOM<OscillatorNodeConfig>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oscillatorConfig', protoName: 'oscillatorConfig', subBuilder: OscillatorNodeConfig.create)
    ..aOM<ScriptingNodeConfig>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scriptingConfig', protoName: 'scriptingConfig', subBuilder: ScriptingNodeConfig.create)
    ..aOM<SequenceNodeConfig>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceConfig', protoName: 'sequenceConfig', subBuilder: SequenceNodeConfig.create)
    ..aOM<ClockNodeConfig>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clockConfig', protoName: 'clockConfig', subBuilder: ClockNodeConfig.create)
    ..aOM<FixtureNodeConfig>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtureConfig', protoName: 'fixtureConfig', subBuilder: FixtureNodeConfig.create)
    ..aOM<ButtonNodeConfig>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buttonConfig', protoName: 'buttonConfig', subBuilder: ButtonNodeConfig.create)
    ..aOM<FaderNodeConfig>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'faderConfig', protoName: 'faderConfig', subBuilder: FaderNodeConfig.create)
    ..aOM<IldaFileNodeConfig>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ildaFileConfig', protoName: 'ildaFileConfig', subBuilder: IldaFileNodeConfig.create)
    ..aOM<LaserNodeConfig>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'laserConfig', protoName: 'laserConfig', subBuilder: LaserNodeConfig.create)
    ..aOM<PixelPatternNodeConfig>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pixelPatternConfig', protoName: 'pixelPatternConfig', subBuilder: PixelPatternNodeConfig.create)
    ..aOM<PixelDmxNodeConfig>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pixelDmxConfig', protoName: 'pixelDmxConfig', subBuilder: PixelDmxNodeConfig.create)
    ..aOM<DmxOutputNodeConfig>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dmxOutputConfig', protoName: 'dmxOutputConfig', subBuilder: DmxOutputNodeConfig.create)
    ..aOM<MidiNodeConfig>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiInputConfig', protoName: 'midiInputConfig', subBuilder: MidiNodeConfig.create)
    ..aOM<MidiNodeConfig>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiOutputConfig', protoName: 'midiOutputConfig', subBuilder: MidiNodeConfig.create)
    ..aOM<OpcOutputNodeConfig>(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'opcOutputConfig', protoName: 'opcOutputConfig', subBuilder: OpcOutputNodeConfig.create)
    ..aOM<OscNodeConfig>(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oscInputConfig', protoName: 'oscInputConfig', subBuilder: OscNodeConfig.create)
    ..aOM<OscNodeConfig>(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oscOutputConfig', protoName: 'oscOutputConfig', subBuilder: OscNodeConfig.create)
    ..aOM<VideoColorBalanceNodeConfig>(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoColorBalanceConfig', protoName: 'videoColorBalanceConfig', subBuilder: VideoColorBalanceNodeConfig.create)
    ..aOM<VideoEffectNodeConfig>(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoEffectConfig', protoName: 'videoEffectConfig', subBuilder: VideoEffectNodeConfig.create)
    ..aOM<VideoFileNodeConfig>(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoFileConfig', protoName: 'videoFileConfig', subBuilder: VideoFileNodeConfig.create)
    ..aOM<VideoOutputNodeConfig>(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoOutputConfig', protoName: 'videoOutputConfig', subBuilder: VideoOutputNodeConfig.create)
    ..aOM<VideoTransformNodeConfig>(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoTransformConfig', protoName: 'videoTransformConfig', subBuilder: VideoTransformNodeConfig.create)
    ..aOM<SelectNodeConfig>(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectConfig', protoName: 'selectConfig', subBuilder: SelectNodeConfig.create)
    ..aOM<MergeNodeConfig>(33, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mergeConfig', protoName: 'mergeConfig', subBuilder: MergeNodeConfig.create)
    ..aOM<EnvelopeNodeConfig>(34, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'envelopeConfig', protoName: 'envelopeConfig', subBuilder: EnvelopeNodeConfig.create)
    ..aOM<SequencerNodeConfig>(35, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequencerConfig', protoName: 'sequencerConfig', subBuilder: SequencerNodeConfig.create)
    ..aOM<ProgrammerNodeConfig>(36, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'programmerConfig', protoName: 'programmerConfig', subBuilder: ProgrammerNodeConfig.create)
    ..aOM<GroupNodeConfig>(37, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupConfig', protoName: 'groupConfig', subBuilder: GroupNodeConfig.create)
    ..aOM<PresetNodeConfig>(38, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'presetConfig', protoName: 'presetConfig', subBuilder: PresetNodeConfig.create)
    ..aOM<ColorRgbNodeConfig>(40, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorRgbConfig', protoName: 'colorRgbConfig', subBuilder: ColorRgbNodeConfig.create)
    ..aOM<ColorHsvNodeConfig>(41, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorHsvConfig', protoName: 'colorHsvConfig', subBuilder: ColorHsvNodeConfig.create)
    ..aOM<GamepadNodeConfig>(42, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gamepadNodeConfig', protoName: 'gamepadNodeConfig', subBuilder: GamepadNodeConfig.create)
    ..aOM<ThresholdNodeConfig>(43, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'thresholdConfig', protoName: 'thresholdConfig', subBuilder: ThresholdNodeConfig.create)
    ..aOM<EncoderNodeConfig>(44, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'encoderConfig', protoName: 'encoderConfig', subBuilder: EncoderNodeConfig.create)
    ..aOM<ContainerNodeConfig>(45, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'containerConfig', protoName: 'containerConfig', subBuilder: ContainerNodeConfig.create)
    ..aOM<MathNodeConfig>(46, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mathConfig', protoName: 'mathConfig', subBuilder: MathNodeConfig.create)
    ..aOM<MqttInputNodeConfig>(47, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mqttInputConfig', protoName: 'mqttInputConfig', subBuilder: MqttInputNodeConfig.create)
    ..aOM<MqttOutputNodeConfig>(48, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mqttOutputConfig', protoName: 'mqttOutputConfig', subBuilder: MqttOutputNodeConfig.create)
    ..aOM<NumberToDataNodeConfig>(49, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'numberToDataConfig', protoName: 'numberToDataConfig', subBuilder: NumberToDataNodeConfig.create)
    ..aOM<DataToNumberNodeConfig>(50, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataToNumberConfig', protoName: 'dataToNumberConfig', subBuilder: DataToNumberNodeConfig.create)
    ..aOM<ValueNodeConfig>(51, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'valueConfig', protoName: 'valueConfig', subBuilder: ValueNodeConfig.create)
    ..aOM<ExtractNodeConfig>(52, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extractConfig', protoName: 'extractConfig', subBuilder: ExtractNodeConfig.create)
    ..aOM<PlanScreenNodeConfig>(53, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planScreenConfig', protoName: 'planScreenConfig', subBuilder: PlanScreenNodeConfig.create)
    ..aOM<DelayNodeConfig>(54, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'delayConfig', protoName: 'delayConfig', subBuilder: DelayNodeConfig.create)
    ..aOM<RampNodeConfig>(55, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rampConfig', protoName: 'rampConfig', subBuilder: RampNodeConfig.create)
    ..aOM<NoiseNodeConfig>(56, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'noiseConfig', protoName: 'noiseConfig', subBuilder: NoiseNodeConfig.create)
    ..aOM<LabelNodeConfig>(57, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'labelConfig', protoName: 'labelConfig', subBuilder: LabelNodeConfig.create)
    ..aOM<TransportNodeConfig>(58, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transportConfig', protoName: 'transportConfig', subBuilder: TransportNodeConfig.create)
    ..aOM<G13InputNodeConfig>(59, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'g13InputConfig', protoName: 'g13InputConfig', subBuilder: G13InputNodeConfig.create)
    ..aOM<G13OutputNodeConfig>(60, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'g13OutputConfig', protoName: 'g13OutputConfig', subBuilder: G13OutputNodeConfig.create)
    ..aOM<ConstantNumberNodeConfig>(61, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'constantNumberConfig', protoName: 'constantNumberConfig', subBuilder: ConstantNumberNodeConfig.create)
    ..aOM<ConditionalNodeConfig>(62, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'conditionalConfig', protoName: 'conditionalConfig', subBuilder: ConditionalNodeConfig.create)
    ..aOM<TimecodeControlNodeConfig>(63, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timecodeControlConfig', protoName: 'timecodeControlConfig', subBuilder: TimecodeControlNodeConfig.create)
    ..aOM<TimecodeOutputNodeConfig>(64, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timecodeOutputConfig', protoName: 'timecodeOutputConfig', subBuilder: TimecodeOutputNodeConfig.create)
    ..aOM<AudioFileNodeConfig>(65, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioFileConfig', protoName: 'audioFileConfig', subBuilder: AudioFileNodeConfig.create)
    ..aOM<AudioOutputNodeConfig>(66, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioOutputConfig', protoName: 'audioOutputConfig', subBuilder: AudioOutputNodeConfig.create)
    ..aOM<AudioVolumeNodeConfig>(67, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioVolumeConfig', protoName: 'audioVolumeConfig', subBuilder: AudioVolumeNodeConfig.create)
    ..aOM<AudioInputNodeConfig>(68, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioInputConfig', protoName: 'audioInputConfig', subBuilder: AudioInputNodeConfig.create)
    ..aOM<AudioMixNodeConfig>(69, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioMixConfig', protoName: 'audioMixConfig', subBuilder: AudioMixNodeConfig.create)
    ..aOM<AudioMeterNodeConfig>(70, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'audioMeterConfig', protoName: 'audioMeterConfig', subBuilder: AudioMeterNodeConfig.create)
    ..aOM<TemplateNodeConfig>(71, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'templateConfig', protoName: 'templateConfig', subBuilder: TemplateNodeConfig.create)
    ..hasRequiredFields = false
  ;

  NodeConfig._() : super();
  factory NodeConfig({
    OscillatorNodeConfig? oscillatorConfig,
    ScriptingNodeConfig? scriptingConfig,
    SequenceNodeConfig? sequenceConfig,
    ClockNodeConfig? clockConfig,
    FixtureNodeConfig? fixtureConfig,
    ButtonNodeConfig? buttonConfig,
    FaderNodeConfig? faderConfig,
    IldaFileNodeConfig? ildaFileConfig,
    LaserNodeConfig? laserConfig,
    PixelPatternNodeConfig? pixelPatternConfig,
    PixelDmxNodeConfig? pixelDmxConfig,
    DmxOutputNodeConfig? dmxOutputConfig,
    MidiNodeConfig? midiInputConfig,
    MidiNodeConfig? midiOutputConfig,
    OpcOutputNodeConfig? opcOutputConfig,
    OscNodeConfig? oscInputConfig,
    OscNodeConfig? oscOutputConfig,
    VideoColorBalanceNodeConfig? videoColorBalanceConfig,
    VideoEffectNodeConfig? videoEffectConfig,
    VideoFileNodeConfig? videoFileConfig,
    VideoOutputNodeConfig? videoOutputConfig,
    VideoTransformNodeConfig? videoTransformConfig,
    SelectNodeConfig? selectConfig,
    MergeNodeConfig? mergeConfig,
    EnvelopeNodeConfig? envelopeConfig,
    SequencerNodeConfig? sequencerConfig,
    ProgrammerNodeConfig? programmerConfig,
    GroupNodeConfig? groupConfig,
    PresetNodeConfig? presetConfig,
    ColorRgbNodeConfig? colorRgbConfig,
    ColorHsvNodeConfig? colorHsvConfig,
    GamepadNodeConfig? gamepadNodeConfig,
    ThresholdNodeConfig? thresholdConfig,
    EncoderNodeConfig? encoderConfig,
    ContainerNodeConfig? containerConfig,
    MathNodeConfig? mathConfig,
    MqttInputNodeConfig? mqttInputConfig,
    MqttOutputNodeConfig? mqttOutputConfig,
    NumberToDataNodeConfig? numberToDataConfig,
    DataToNumberNodeConfig? dataToNumberConfig,
    ValueNodeConfig? valueConfig,
    ExtractNodeConfig? extractConfig,
    PlanScreenNodeConfig? planScreenConfig,
    DelayNodeConfig? delayConfig,
    RampNodeConfig? rampConfig,
    NoiseNodeConfig? noiseConfig,
    LabelNodeConfig? labelConfig,
    TransportNodeConfig? transportConfig,
    G13InputNodeConfig? g13InputConfig,
    G13OutputNodeConfig? g13OutputConfig,
    ConstantNumberNodeConfig? constantNumberConfig,
    ConditionalNodeConfig? conditionalConfig,
    TimecodeControlNodeConfig? timecodeControlConfig,
    TimecodeOutputNodeConfig? timecodeOutputConfig,
    AudioFileNodeConfig? audioFileConfig,
    AudioOutputNodeConfig? audioOutputConfig,
    AudioVolumeNodeConfig? audioVolumeConfig,
    AudioInputNodeConfig? audioInputConfig,
    AudioMixNodeConfig? audioMixConfig,
    AudioMeterNodeConfig? audioMeterConfig,
    TemplateNodeConfig? templateConfig,
  }) {
    final _result = create();
    if (oscillatorConfig != null) {
      _result.oscillatorConfig = oscillatorConfig;
    }
    if (scriptingConfig != null) {
      _result.scriptingConfig = scriptingConfig;
    }
    if (sequenceConfig != null) {
      _result.sequenceConfig = sequenceConfig;
    }
    if (clockConfig != null) {
      _result.clockConfig = clockConfig;
    }
    if (fixtureConfig != null) {
      _result.fixtureConfig = fixtureConfig;
    }
    if (buttonConfig != null) {
      _result.buttonConfig = buttonConfig;
    }
    if (faderConfig != null) {
      _result.faderConfig = faderConfig;
    }
    if (ildaFileConfig != null) {
      _result.ildaFileConfig = ildaFileConfig;
    }
    if (laserConfig != null) {
      _result.laserConfig = laserConfig;
    }
    if (pixelPatternConfig != null) {
      _result.pixelPatternConfig = pixelPatternConfig;
    }
    if (pixelDmxConfig != null) {
      _result.pixelDmxConfig = pixelDmxConfig;
    }
    if (dmxOutputConfig != null) {
      _result.dmxOutputConfig = dmxOutputConfig;
    }
    if (midiInputConfig != null) {
      _result.midiInputConfig = midiInputConfig;
    }
    if (midiOutputConfig != null) {
      _result.midiOutputConfig = midiOutputConfig;
    }
    if (opcOutputConfig != null) {
      _result.opcOutputConfig = opcOutputConfig;
    }
    if (oscInputConfig != null) {
      _result.oscInputConfig = oscInputConfig;
    }
    if (oscOutputConfig != null) {
      _result.oscOutputConfig = oscOutputConfig;
    }
    if (videoColorBalanceConfig != null) {
      _result.videoColorBalanceConfig = videoColorBalanceConfig;
    }
    if (videoEffectConfig != null) {
      _result.videoEffectConfig = videoEffectConfig;
    }
    if (videoFileConfig != null) {
      _result.videoFileConfig = videoFileConfig;
    }
    if (videoOutputConfig != null) {
      _result.videoOutputConfig = videoOutputConfig;
    }
    if (videoTransformConfig != null) {
      _result.videoTransformConfig = videoTransformConfig;
    }
    if (selectConfig != null) {
      _result.selectConfig = selectConfig;
    }
    if (mergeConfig != null) {
      _result.mergeConfig = mergeConfig;
    }
    if (envelopeConfig != null) {
      _result.envelopeConfig = envelopeConfig;
    }
    if (sequencerConfig != null) {
      _result.sequencerConfig = sequencerConfig;
    }
    if (programmerConfig != null) {
      _result.programmerConfig = programmerConfig;
    }
    if (groupConfig != null) {
      _result.groupConfig = groupConfig;
    }
    if (presetConfig != null) {
      _result.presetConfig = presetConfig;
    }
    if (colorRgbConfig != null) {
      _result.colorRgbConfig = colorRgbConfig;
    }
    if (colorHsvConfig != null) {
      _result.colorHsvConfig = colorHsvConfig;
    }
    if (gamepadNodeConfig != null) {
      _result.gamepadNodeConfig = gamepadNodeConfig;
    }
    if (thresholdConfig != null) {
      _result.thresholdConfig = thresholdConfig;
    }
    if (encoderConfig != null) {
      _result.encoderConfig = encoderConfig;
    }
    if (containerConfig != null) {
      _result.containerConfig = containerConfig;
    }
    if (mathConfig != null) {
      _result.mathConfig = mathConfig;
    }
    if (mqttInputConfig != null) {
      _result.mqttInputConfig = mqttInputConfig;
    }
    if (mqttOutputConfig != null) {
      _result.mqttOutputConfig = mqttOutputConfig;
    }
    if (numberToDataConfig != null) {
      _result.numberToDataConfig = numberToDataConfig;
    }
    if (dataToNumberConfig != null) {
      _result.dataToNumberConfig = dataToNumberConfig;
    }
    if (valueConfig != null) {
      _result.valueConfig = valueConfig;
    }
    if (extractConfig != null) {
      _result.extractConfig = extractConfig;
    }
    if (planScreenConfig != null) {
      _result.planScreenConfig = planScreenConfig;
    }
    if (delayConfig != null) {
      _result.delayConfig = delayConfig;
    }
    if (rampConfig != null) {
      _result.rampConfig = rampConfig;
    }
    if (noiseConfig != null) {
      _result.noiseConfig = noiseConfig;
    }
    if (labelConfig != null) {
      _result.labelConfig = labelConfig;
    }
    if (transportConfig != null) {
      _result.transportConfig = transportConfig;
    }
    if (g13InputConfig != null) {
      _result.g13InputConfig = g13InputConfig;
    }
    if (g13OutputConfig != null) {
      _result.g13OutputConfig = g13OutputConfig;
    }
    if (constantNumberConfig != null) {
      _result.constantNumberConfig = constantNumberConfig;
    }
    if (conditionalConfig != null) {
      _result.conditionalConfig = conditionalConfig;
    }
    if (timecodeControlConfig != null) {
      _result.timecodeControlConfig = timecodeControlConfig;
    }
    if (timecodeOutputConfig != null) {
      _result.timecodeOutputConfig = timecodeOutputConfig;
    }
    if (audioFileConfig != null) {
      _result.audioFileConfig = audioFileConfig;
    }
    if (audioOutputConfig != null) {
      _result.audioOutputConfig = audioOutputConfig;
    }
    if (audioVolumeConfig != null) {
      _result.audioVolumeConfig = audioVolumeConfig;
    }
    if (audioInputConfig != null) {
      _result.audioInputConfig = audioInputConfig;
    }
    if (audioMixConfig != null) {
      _result.audioMixConfig = audioMixConfig;
    }
    if (audioMeterConfig != null) {
      _result.audioMeterConfig = audioMeterConfig;
    }
    if (templateConfig != null) {
      _result.templateConfig = templateConfig;
    }
    return _result;
  }
  factory NodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeConfig clone() => NodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeConfig copyWith(void Function(NodeConfig) updates) => super.copyWith((message) => updates(message as NodeConfig)) as NodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodeConfig create() => NodeConfig._();
  NodeConfig createEmptyInstance() => create();
  static $pb.PbList<NodeConfig> createRepeated() => $pb.PbList<NodeConfig>();
  @$core.pragma('dart2js:noInline')
  static NodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeConfig>(create);
  static NodeConfig? _defaultInstance;

  NodeConfig_Type whichType() => _NodeConfig_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(10)
  OscillatorNodeConfig get oscillatorConfig => $_getN(0);
  @$pb.TagNumber(10)
  set oscillatorConfig(OscillatorNodeConfig v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasOscillatorConfig() => $_has(0);
  @$pb.TagNumber(10)
  void clearOscillatorConfig() => clearField(10);
  @$pb.TagNumber(10)
  OscillatorNodeConfig ensureOscillatorConfig() => $_ensure(0);

  @$pb.TagNumber(11)
  ScriptingNodeConfig get scriptingConfig => $_getN(1);
  @$pb.TagNumber(11)
  set scriptingConfig(ScriptingNodeConfig v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasScriptingConfig() => $_has(1);
  @$pb.TagNumber(11)
  void clearScriptingConfig() => clearField(11);
  @$pb.TagNumber(11)
  ScriptingNodeConfig ensureScriptingConfig() => $_ensure(1);

  @$pb.TagNumber(12)
  SequenceNodeConfig get sequenceConfig => $_getN(2);
  @$pb.TagNumber(12)
  set sequenceConfig(SequenceNodeConfig v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasSequenceConfig() => $_has(2);
  @$pb.TagNumber(12)
  void clearSequenceConfig() => clearField(12);
  @$pb.TagNumber(12)
  SequenceNodeConfig ensureSequenceConfig() => $_ensure(2);

  @$pb.TagNumber(13)
  ClockNodeConfig get clockConfig => $_getN(3);
  @$pb.TagNumber(13)
  set clockConfig(ClockNodeConfig v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasClockConfig() => $_has(3);
  @$pb.TagNumber(13)
  void clearClockConfig() => clearField(13);
  @$pb.TagNumber(13)
  ClockNodeConfig ensureClockConfig() => $_ensure(3);

  @$pb.TagNumber(14)
  FixtureNodeConfig get fixtureConfig => $_getN(4);
  @$pb.TagNumber(14)
  set fixtureConfig(FixtureNodeConfig v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasFixtureConfig() => $_has(4);
  @$pb.TagNumber(14)
  void clearFixtureConfig() => clearField(14);
  @$pb.TagNumber(14)
  FixtureNodeConfig ensureFixtureConfig() => $_ensure(4);

  @$pb.TagNumber(15)
  ButtonNodeConfig get buttonConfig => $_getN(5);
  @$pb.TagNumber(15)
  set buttonConfig(ButtonNodeConfig v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasButtonConfig() => $_has(5);
  @$pb.TagNumber(15)
  void clearButtonConfig() => clearField(15);
  @$pb.TagNumber(15)
  ButtonNodeConfig ensureButtonConfig() => $_ensure(5);

  @$pb.TagNumber(16)
  FaderNodeConfig get faderConfig => $_getN(6);
  @$pb.TagNumber(16)
  set faderConfig(FaderNodeConfig v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasFaderConfig() => $_has(6);
  @$pb.TagNumber(16)
  void clearFaderConfig() => clearField(16);
  @$pb.TagNumber(16)
  FaderNodeConfig ensureFaderConfig() => $_ensure(6);

  @$pb.TagNumber(17)
  IldaFileNodeConfig get ildaFileConfig => $_getN(7);
  @$pb.TagNumber(17)
  set ildaFileConfig(IldaFileNodeConfig v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasIldaFileConfig() => $_has(7);
  @$pb.TagNumber(17)
  void clearIldaFileConfig() => clearField(17);
  @$pb.TagNumber(17)
  IldaFileNodeConfig ensureIldaFileConfig() => $_ensure(7);

  @$pb.TagNumber(18)
  LaserNodeConfig get laserConfig => $_getN(8);
  @$pb.TagNumber(18)
  set laserConfig(LaserNodeConfig v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasLaserConfig() => $_has(8);
  @$pb.TagNumber(18)
  void clearLaserConfig() => clearField(18);
  @$pb.TagNumber(18)
  LaserNodeConfig ensureLaserConfig() => $_ensure(8);

  @$pb.TagNumber(19)
  PixelPatternNodeConfig get pixelPatternConfig => $_getN(9);
  @$pb.TagNumber(19)
  set pixelPatternConfig(PixelPatternNodeConfig v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasPixelPatternConfig() => $_has(9);
  @$pb.TagNumber(19)
  void clearPixelPatternConfig() => clearField(19);
  @$pb.TagNumber(19)
  PixelPatternNodeConfig ensurePixelPatternConfig() => $_ensure(9);

  @$pb.TagNumber(20)
  PixelDmxNodeConfig get pixelDmxConfig => $_getN(10);
  @$pb.TagNumber(20)
  set pixelDmxConfig(PixelDmxNodeConfig v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasPixelDmxConfig() => $_has(10);
  @$pb.TagNumber(20)
  void clearPixelDmxConfig() => clearField(20);
  @$pb.TagNumber(20)
  PixelDmxNodeConfig ensurePixelDmxConfig() => $_ensure(10);

  @$pb.TagNumber(21)
  DmxOutputNodeConfig get dmxOutputConfig => $_getN(11);
  @$pb.TagNumber(21)
  set dmxOutputConfig(DmxOutputNodeConfig v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasDmxOutputConfig() => $_has(11);
  @$pb.TagNumber(21)
  void clearDmxOutputConfig() => clearField(21);
  @$pb.TagNumber(21)
  DmxOutputNodeConfig ensureDmxOutputConfig() => $_ensure(11);

  @$pb.TagNumber(22)
  MidiNodeConfig get midiInputConfig => $_getN(12);
  @$pb.TagNumber(22)
  set midiInputConfig(MidiNodeConfig v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasMidiInputConfig() => $_has(12);
  @$pb.TagNumber(22)
  void clearMidiInputConfig() => clearField(22);
  @$pb.TagNumber(22)
  MidiNodeConfig ensureMidiInputConfig() => $_ensure(12);

  @$pb.TagNumber(23)
  MidiNodeConfig get midiOutputConfig => $_getN(13);
  @$pb.TagNumber(23)
  set midiOutputConfig(MidiNodeConfig v) { setField(23, v); }
  @$pb.TagNumber(23)
  $core.bool hasMidiOutputConfig() => $_has(13);
  @$pb.TagNumber(23)
  void clearMidiOutputConfig() => clearField(23);
  @$pb.TagNumber(23)
  MidiNodeConfig ensureMidiOutputConfig() => $_ensure(13);

  @$pb.TagNumber(24)
  OpcOutputNodeConfig get opcOutputConfig => $_getN(14);
  @$pb.TagNumber(24)
  set opcOutputConfig(OpcOutputNodeConfig v) { setField(24, v); }
  @$pb.TagNumber(24)
  $core.bool hasOpcOutputConfig() => $_has(14);
  @$pb.TagNumber(24)
  void clearOpcOutputConfig() => clearField(24);
  @$pb.TagNumber(24)
  OpcOutputNodeConfig ensureOpcOutputConfig() => $_ensure(14);

  @$pb.TagNumber(25)
  OscNodeConfig get oscInputConfig => $_getN(15);
  @$pb.TagNumber(25)
  set oscInputConfig(OscNodeConfig v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasOscInputConfig() => $_has(15);
  @$pb.TagNumber(25)
  void clearOscInputConfig() => clearField(25);
  @$pb.TagNumber(25)
  OscNodeConfig ensureOscInputConfig() => $_ensure(15);

  @$pb.TagNumber(26)
  OscNodeConfig get oscOutputConfig => $_getN(16);
  @$pb.TagNumber(26)
  set oscOutputConfig(OscNodeConfig v) { setField(26, v); }
  @$pb.TagNumber(26)
  $core.bool hasOscOutputConfig() => $_has(16);
  @$pb.TagNumber(26)
  void clearOscOutputConfig() => clearField(26);
  @$pb.TagNumber(26)
  OscNodeConfig ensureOscOutputConfig() => $_ensure(16);

  @$pb.TagNumber(27)
  VideoColorBalanceNodeConfig get videoColorBalanceConfig => $_getN(17);
  @$pb.TagNumber(27)
  set videoColorBalanceConfig(VideoColorBalanceNodeConfig v) { setField(27, v); }
  @$pb.TagNumber(27)
  $core.bool hasVideoColorBalanceConfig() => $_has(17);
  @$pb.TagNumber(27)
  void clearVideoColorBalanceConfig() => clearField(27);
  @$pb.TagNumber(27)
  VideoColorBalanceNodeConfig ensureVideoColorBalanceConfig() => $_ensure(17);

  @$pb.TagNumber(28)
  VideoEffectNodeConfig get videoEffectConfig => $_getN(18);
  @$pb.TagNumber(28)
  set videoEffectConfig(VideoEffectNodeConfig v) { setField(28, v); }
  @$pb.TagNumber(28)
  $core.bool hasVideoEffectConfig() => $_has(18);
  @$pb.TagNumber(28)
  void clearVideoEffectConfig() => clearField(28);
  @$pb.TagNumber(28)
  VideoEffectNodeConfig ensureVideoEffectConfig() => $_ensure(18);

  @$pb.TagNumber(29)
  VideoFileNodeConfig get videoFileConfig => $_getN(19);
  @$pb.TagNumber(29)
  set videoFileConfig(VideoFileNodeConfig v) { setField(29, v); }
  @$pb.TagNumber(29)
  $core.bool hasVideoFileConfig() => $_has(19);
  @$pb.TagNumber(29)
  void clearVideoFileConfig() => clearField(29);
  @$pb.TagNumber(29)
  VideoFileNodeConfig ensureVideoFileConfig() => $_ensure(19);

  @$pb.TagNumber(30)
  VideoOutputNodeConfig get videoOutputConfig => $_getN(20);
  @$pb.TagNumber(30)
  set videoOutputConfig(VideoOutputNodeConfig v) { setField(30, v); }
  @$pb.TagNumber(30)
  $core.bool hasVideoOutputConfig() => $_has(20);
  @$pb.TagNumber(30)
  void clearVideoOutputConfig() => clearField(30);
  @$pb.TagNumber(30)
  VideoOutputNodeConfig ensureVideoOutputConfig() => $_ensure(20);

  @$pb.TagNumber(31)
  VideoTransformNodeConfig get videoTransformConfig => $_getN(21);
  @$pb.TagNumber(31)
  set videoTransformConfig(VideoTransformNodeConfig v) { setField(31, v); }
  @$pb.TagNumber(31)
  $core.bool hasVideoTransformConfig() => $_has(21);
  @$pb.TagNumber(31)
  void clearVideoTransformConfig() => clearField(31);
  @$pb.TagNumber(31)
  VideoTransformNodeConfig ensureVideoTransformConfig() => $_ensure(21);

  @$pb.TagNumber(32)
  SelectNodeConfig get selectConfig => $_getN(22);
  @$pb.TagNumber(32)
  set selectConfig(SelectNodeConfig v) { setField(32, v); }
  @$pb.TagNumber(32)
  $core.bool hasSelectConfig() => $_has(22);
  @$pb.TagNumber(32)
  void clearSelectConfig() => clearField(32);
  @$pb.TagNumber(32)
  SelectNodeConfig ensureSelectConfig() => $_ensure(22);

  @$pb.TagNumber(33)
  MergeNodeConfig get mergeConfig => $_getN(23);
  @$pb.TagNumber(33)
  set mergeConfig(MergeNodeConfig v) { setField(33, v); }
  @$pb.TagNumber(33)
  $core.bool hasMergeConfig() => $_has(23);
  @$pb.TagNumber(33)
  void clearMergeConfig() => clearField(33);
  @$pb.TagNumber(33)
  MergeNodeConfig ensureMergeConfig() => $_ensure(23);

  @$pb.TagNumber(34)
  EnvelopeNodeConfig get envelopeConfig => $_getN(24);
  @$pb.TagNumber(34)
  set envelopeConfig(EnvelopeNodeConfig v) { setField(34, v); }
  @$pb.TagNumber(34)
  $core.bool hasEnvelopeConfig() => $_has(24);
  @$pb.TagNumber(34)
  void clearEnvelopeConfig() => clearField(34);
  @$pb.TagNumber(34)
  EnvelopeNodeConfig ensureEnvelopeConfig() => $_ensure(24);

  @$pb.TagNumber(35)
  SequencerNodeConfig get sequencerConfig => $_getN(25);
  @$pb.TagNumber(35)
  set sequencerConfig(SequencerNodeConfig v) { setField(35, v); }
  @$pb.TagNumber(35)
  $core.bool hasSequencerConfig() => $_has(25);
  @$pb.TagNumber(35)
  void clearSequencerConfig() => clearField(35);
  @$pb.TagNumber(35)
  SequencerNodeConfig ensureSequencerConfig() => $_ensure(25);

  @$pb.TagNumber(36)
  ProgrammerNodeConfig get programmerConfig => $_getN(26);
  @$pb.TagNumber(36)
  set programmerConfig(ProgrammerNodeConfig v) { setField(36, v); }
  @$pb.TagNumber(36)
  $core.bool hasProgrammerConfig() => $_has(26);
  @$pb.TagNumber(36)
  void clearProgrammerConfig() => clearField(36);
  @$pb.TagNumber(36)
  ProgrammerNodeConfig ensureProgrammerConfig() => $_ensure(26);

  @$pb.TagNumber(37)
  GroupNodeConfig get groupConfig => $_getN(27);
  @$pb.TagNumber(37)
  set groupConfig(GroupNodeConfig v) { setField(37, v); }
  @$pb.TagNumber(37)
  $core.bool hasGroupConfig() => $_has(27);
  @$pb.TagNumber(37)
  void clearGroupConfig() => clearField(37);
  @$pb.TagNumber(37)
  GroupNodeConfig ensureGroupConfig() => $_ensure(27);

  @$pb.TagNumber(38)
  PresetNodeConfig get presetConfig => $_getN(28);
  @$pb.TagNumber(38)
  set presetConfig(PresetNodeConfig v) { setField(38, v); }
  @$pb.TagNumber(38)
  $core.bool hasPresetConfig() => $_has(28);
  @$pb.TagNumber(38)
  void clearPresetConfig() => clearField(38);
  @$pb.TagNumber(38)
  PresetNodeConfig ensurePresetConfig() => $_ensure(28);

  @$pb.TagNumber(40)
  ColorRgbNodeConfig get colorRgbConfig => $_getN(29);
  @$pb.TagNumber(40)
  set colorRgbConfig(ColorRgbNodeConfig v) { setField(40, v); }
  @$pb.TagNumber(40)
  $core.bool hasColorRgbConfig() => $_has(29);
  @$pb.TagNumber(40)
  void clearColorRgbConfig() => clearField(40);
  @$pb.TagNumber(40)
  ColorRgbNodeConfig ensureColorRgbConfig() => $_ensure(29);

  @$pb.TagNumber(41)
  ColorHsvNodeConfig get colorHsvConfig => $_getN(30);
  @$pb.TagNumber(41)
  set colorHsvConfig(ColorHsvNodeConfig v) { setField(41, v); }
  @$pb.TagNumber(41)
  $core.bool hasColorHsvConfig() => $_has(30);
  @$pb.TagNumber(41)
  void clearColorHsvConfig() => clearField(41);
  @$pb.TagNumber(41)
  ColorHsvNodeConfig ensureColorHsvConfig() => $_ensure(30);

  @$pb.TagNumber(42)
  GamepadNodeConfig get gamepadNodeConfig => $_getN(31);
  @$pb.TagNumber(42)
  set gamepadNodeConfig(GamepadNodeConfig v) { setField(42, v); }
  @$pb.TagNumber(42)
  $core.bool hasGamepadNodeConfig() => $_has(31);
  @$pb.TagNumber(42)
  void clearGamepadNodeConfig() => clearField(42);
  @$pb.TagNumber(42)
  GamepadNodeConfig ensureGamepadNodeConfig() => $_ensure(31);

  @$pb.TagNumber(43)
  ThresholdNodeConfig get thresholdConfig => $_getN(32);
  @$pb.TagNumber(43)
  set thresholdConfig(ThresholdNodeConfig v) { setField(43, v); }
  @$pb.TagNumber(43)
  $core.bool hasThresholdConfig() => $_has(32);
  @$pb.TagNumber(43)
  void clearThresholdConfig() => clearField(43);
  @$pb.TagNumber(43)
  ThresholdNodeConfig ensureThresholdConfig() => $_ensure(32);

  @$pb.TagNumber(44)
  EncoderNodeConfig get encoderConfig => $_getN(33);
  @$pb.TagNumber(44)
  set encoderConfig(EncoderNodeConfig v) { setField(44, v); }
  @$pb.TagNumber(44)
  $core.bool hasEncoderConfig() => $_has(33);
  @$pb.TagNumber(44)
  void clearEncoderConfig() => clearField(44);
  @$pb.TagNumber(44)
  EncoderNodeConfig ensureEncoderConfig() => $_ensure(33);

  @$pb.TagNumber(45)
  ContainerNodeConfig get containerConfig => $_getN(34);
  @$pb.TagNumber(45)
  set containerConfig(ContainerNodeConfig v) { setField(45, v); }
  @$pb.TagNumber(45)
  $core.bool hasContainerConfig() => $_has(34);
  @$pb.TagNumber(45)
  void clearContainerConfig() => clearField(45);
  @$pb.TagNumber(45)
  ContainerNodeConfig ensureContainerConfig() => $_ensure(34);

  @$pb.TagNumber(46)
  MathNodeConfig get mathConfig => $_getN(35);
  @$pb.TagNumber(46)
  set mathConfig(MathNodeConfig v) { setField(46, v); }
  @$pb.TagNumber(46)
  $core.bool hasMathConfig() => $_has(35);
  @$pb.TagNumber(46)
  void clearMathConfig() => clearField(46);
  @$pb.TagNumber(46)
  MathNodeConfig ensureMathConfig() => $_ensure(35);

  @$pb.TagNumber(47)
  MqttInputNodeConfig get mqttInputConfig => $_getN(36);
  @$pb.TagNumber(47)
  set mqttInputConfig(MqttInputNodeConfig v) { setField(47, v); }
  @$pb.TagNumber(47)
  $core.bool hasMqttInputConfig() => $_has(36);
  @$pb.TagNumber(47)
  void clearMqttInputConfig() => clearField(47);
  @$pb.TagNumber(47)
  MqttInputNodeConfig ensureMqttInputConfig() => $_ensure(36);

  @$pb.TagNumber(48)
  MqttOutputNodeConfig get mqttOutputConfig => $_getN(37);
  @$pb.TagNumber(48)
  set mqttOutputConfig(MqttOutputNodeConfig v) { setField(48, v); }
  @$pb.TagNumber(48)
  $core.bool hasMqttOutputConfig() => $_has(37);
  @$pb.TagNumber(48)
  void clearMqttOutputConfig() => clearField(48);
  @$pb.TagNumber(48)
  MqttOutputNodeConfig ensureMqttOutputConfig() => $_ensure(37);

  @$pb.TagNumber(49)
  NumberToDataNodeConfig get numberToDataConfig => $_getN(38);
  @$pb.TagNumber(49)
  set numberToDataConfig(NumberToDataNodeConfig v) { setField(49, v); }
  @$pb.TagNumber(49)
  $core.bool hasNumberToDataConfig() => $_has(38);
  @$pb.TagNumber(49)
  void clearNumberToDataConfig() => clearField(49);
  @$pb.TagNumber(49)
  NumberToDataNodeConfig ensureNumberToDataConfig() => $_ensure(38);

  @$pb.TagNumber(50)
  DataToNumberNodeConfig get dataToNumberConfig => $_getN(39);
  @$pb.TagNumber(50)
  set dataToNumberConfig(DataToNumberNodeConfig v) { setField(50, v); }
  @$pb.TagNumber(50)
  $core.bool hasDataToNumberConfig() => $_has(39);
  @$pb.TagNumber(50)
  void clearDataToNumberConfig() => clearField(50);
  @$pb.TagNumber(50)
  DataToNumberNodeConfig ensureDataToNumberConfig() => $_ensure(39);

  @$pb.TagNumber(51)
  ValueNodeConfig get valueConfig => $_getN(40);
  @$pb.TagNumber(51)
  set valueConfig(ValueNodeConfig v) { setField(51, v); }
  @$pb.TagNumber(51)
  $core.bool hasValueConfig() => $_has(40);
  @$pb.TagNumber(51)
  void clearValueConfig() => clearField(51);
  @$pb.TagNumber(51)
  ValueNodeConfig ensureValueConfig() => $_ensure(40);

  @$pb.TagNumber(52)
  ExtractNodeConfig get extractConfig => $_getN(41);
  @$pb.TagNumber(52)
  set extractConfig(ExtractNodeConfig v) { setField(52, v); }
  @$pb.TagNumber(52)
  $core.bool hasExtractConfig() => $_has(41);
  @$pb.TagNumber(52)
  void clearExtractConfig() => clearField(52);
  @$pb.TagNumber(52)
  ExtractNodeConfig ensureExtractConfig() => $_ensure(41);

  @$pb.TagNumber(53)
  PlanScreenNodeConfig get planScreenConfig => $_getN(42);
  @$pb.TagNumber(53)
  set planScreenConfig(PlanScreenNodeConfig v) { setField(53, v); }
  @$pb.TagNumber(53)
  $core.bool hasPlanScreenConfig() => $_has(42);
  @$pb.TagNumber(53)
  void clearPlanScreenConfig() => clearField(53);
  @$pb.TagNumber(53)
  PlanScreenNodeConfig ensurePlanScreenConfig() => $_ensure(42);

  @$pb.TagNumber(54)
  DelayNodeConfig get delayConfig => $_getN(43);
  @$pb.TagNumber(54)
  set delayConfig(DelayNodeConfig v) { setField(54, v); }
  @$pb.TagNumber(54)
  $core.bool hasDelayConfig() => $_has(43);
  @$pb.TagNumber(54)
  void clearDelayConfig() => clearField(54);
  @$pb.TagNumber(54)
  DelayNodeConfig ensureDelayConfig() => $_ensure(43);

  @$pb.TagNumber(55)
  RampNodeConfig get rampConfig => $_getN(44);
  @$pb.TagNumber(55)
  set rampConfig(RampNodeConfig v) { setField(55, v); }
  @$pb.TagNumber(55)
  $core.bool hasRampConfig() => $_has(44);
  @$pb.TagNumber(55)
  void clearRampConfig() => clearField(55);
  @$pb.TagNumber(55)
  RampNodeConfig ensureRampConfig() => $_ensure(44);

  @$pb.TagNumber(56)
  NoiseNodeConfig get noiseConfig => $_getN(45);
  @$pb.TagNumber(56)
  set noiseConfig(NoiseNodeConfig v) { setField(56, v); }
  @$pb.TagNumber(56)
  $core.bool hasNoiseConfig() => $_has(45);
  @$pb.TagNumber(56)
  void clearNoiseConfig() => clearField(56);
  @$pb.TagNumber(56)
  NoiseNodeConfig ensureNoiseConfig() => $_ensure(45);

  @$pb.TagNumber(57)
  LabelNodeConfig get labelConfig => $_getN(46);
  @$pb.TagNumber(57)
  set labelConfig(LabelNodeConfig v) { setField(57, v); }
  @$pb.TagNumber(57)
  $core.bool hasLabelConfig() => $_has(46);
  @$pb.TagNumber(57)
  void clearLabelConfig() => clearField(57);
  @$pb.TagNumber(57)
  LabelNodeConfig ensureLabelConfig() => $_ensure(46);

  @$pb.TagNumber(58)
  TransportNodeConfig get transportConfig => $_getN(47);
  @$pb.TagNumber(58)
  set transportConfig(TransportNodeConfig v) { setField(58, v); }
  @$pb.TagNumber(58)
  $core.bool hasTransportConfig() => $_has(47);
  @$pb.TagNumber(58)
  void clearTransportConfig() => clearField(58);
  @$pb.TagNumber(58)
  TransportNodeConfig ensureTransportConfig() => $_ensure(47);

  @$pb.TagNumber(59)
  G13InputNodeConfig get g13InputConfig => $_getN(48);
  @$pb.TagNumber(59)
  set g13InputConfig(G13InputNodeConfig v) { setField(59, v); }
  @$pb.TagNumber(59)
  $core.bool hasG13InputConfig() => $_has(48);
  @$pb.TagNumber(59)
  void clearG13InputConfig() => clearField(59);
  @$pb.TagNumber(59)
  G13InputNodeConfig ensureG13InputConfig() => $_ensure(48);

  @$pb.TagNumber(60)
  G13OutputNodeConfig get g13OutputConfig => $_getN(49);
  @$pb.TagNumber(60)
  set g13OutputConfig(G13OutputNodeConfig v) { setField(60, v); }
  @$pb.TagNumber(60)
  $core.bool hasG13OutputConfig() => $_has(49);
  @$pb.TagNumber(60)
  void clearG13OutputConfig() => clearField(60);
  @$pb.TagNumber(60)
  G13OutputNodeConfig ensureG13OutputConfig() => $_ensure(49);

  @$pb.TagNumber(61)
  ConstantNumberNodeConfig get constantNumberConfig => $_getN(50);
  @$pb.TagNumber(61)
  set constantNumberConfig(ConstantNumberNodeConfig v) { setField(61, v); }
  @$pb.TagNumber(61)
  $core.bool hasConstantNumberConfig() => $_has(50);
  @$pb.TagNumber(61)
  void clearConstantNumberConfig() => clearField(61);
  @$pb.TagNumber(61)
  ConstantNumberNodeConfig ensureConstantNumberConfig() => $_ensure(50);

  @$pb.TagNumber(62)
  ConditionalNodeConfig get conditionalConfig => $_getN(51);
  @$pb.TagNumber(62)
  set conditionalConfig(ConditionalNodeConfig v) { setField(62, v); }
  @$pb.TagNumber(62)
  $core.bool hasConditionalConfig() => $_has(51);
  @$pb.TagNumber(62)
  void clearConditionalConfig() => clearField(62);
  @$pb.TagNumber(62)
  ConditionalNodeConfig ensureConditionalConfig() => $_ensure(51);

  @$pb.TagNumber(63)
  TimecodeControlNodeConfig get timecodeControlConfig => $_getN(52);
  @$pb.TagNumber(63)
  set timecodeControlConfig(TimecodeControlNodeConfig v) { setField(63, v); }
  @$pb.TagNumber(63)
  $core.bool hasTimecodeControlConfig() => $_has(52);
  @$pb.TagNumber(63)
  void clearTimecodeControlConfig() => clearField(63);
  @$pb.TagNumber(63)
  TimecodeControlNodeConfig ensureTimecodeControlConfig() => $_ensure(52);

  @$pb.TagNumber(64)
  TimecodeOutputNodeConfig get timecodeOutputConfig => $_getN(53);
  @$pb.TagNumber(64)
  set timecodeOutputConfig(TimecodeOutputNodeConfig v) { setField(64, v); }
  @$pb.TagNumber(64)
  $core.bool hasTimecodeOutputConfig() => $_has(53);
  @$pb.TagNumber(64)
  void clearTimecodeOutputConfig() => clearField(64);
  @$pb.TagNumber(64)
  TimecodeOutputNodeConfig ensureTimecodeOutputConfig() => $_ensure(53);

  @$pb.TagNumber(65)
  AudioFileNodeConfig get audioFileConfig => $_getN(54);
  @$pb.TagNumber(65)
  set audioFileConfig(AudioFileNodeConfig v) { setField(65, v); }
  @$pb.TagNumber(65)
  $core.bool hasAudioFileConfig() => $_has(54);
  @$pb.TagNumber(65)
  void clearAudioFileConfig() => clearField(65);
  @$pb.TagNumber(65)
  AudioFileNodeConfig ensureAudioFileConfig() => $_ensure(54);

  @$pb.TagNumber(66)
  AudioOutputNodeConfig get audioOutputConfig => $_getN(55);
  @$pb.TagNumber(66)
  set audioOutputConfig(AudioOutputNodeConfig v) { setField(66, v); }
  @$pb.TagNumber(66)
  $core.bool hasAudioOutputConfig() => $_has(55);
  @$pb.TagNumber(66)
  void clearAudioOutputConfig() => clearField(66);
  @$pb.TagNumber(66)
  AudioOutputNodeConfig ensureAudioOutputConfig() => $_ensure(55);

  @$pb.TagNumber(67)
  AudioVolumeNodeConfig get audioVolumeConfig => $_getN(56);
  @$pb.TagNumber(67)
  set audioVolumeConfig(AudioVolumeNodeConfig v) { setField(67, v); }
  @$pb.TagNumber(67)
  $core.bool hasAudioVolumeConfig() => $_has(56);
  @$pb.TagNumber(67)
  void clearAudioVolumeConfig() => clearField(67);
  @$pb.TagNumber(67)
  AudioVolumeNodeConfig ensureAudioVolumeConfig() => $_ensure(56);

  @$pb.TagNumber(68)
  AudioInputNodeConfig get audioInputConfig => $_getN(57);
  @$pb.TagNumber(68)
  set audioInputConfig(AudioInputNodeConfig v) { setField(68, v); }
  @$pb.TagNumber(68)
  $core.bool hasAudioInputConfig() => $_has(57);
  @$pb.TagNumber(68)
  void clearAudioInputConfig() => clearField(68);
  @$pb.TagNumber(68)
  AudioInputNodeConfig ensureAudioInputConfig() => $_ensure(57);

  @$pb.TagNumber(69)
  AudioMixNodeConfig get audioMixConfig => $_getN(58);
  @$pb.TagNumber(69)
  set audioMixConfig(AudioMixNodeConfig v) { setField(69, v); }
  @$pb.TagNumber(69)
  $core.bool hasAudioMixConfig() => $_has(58);
  @$pb.TagNumber(69)
  void clearAudioMixConfig() => clearField(69);
  @$pb.TagNumber(69)
  AudioMixNodeConfig ensureAudioMixConfig() => $_ensure(58);

  @$pb.TagNumber(70)
  AudioMeterNodeConfig get audioMeterConfig => $_getN(59);
  @$pb.TagNumber(70)
  set audioMeterConfig(AudioMeterNodeConfig v) { setField(70, v); }
  @$pb.TagNumber(70)
  $core.bool hasAudioMeterConfig() => $_has(59);
  @$pb.TagNumber(70)
  void clearAudioMeterConfig() => clearField(70);
  @$pb.TagNumber(70)
  AudioMeterNodeConfig ensureAudioMeterConfig() => $_ensure(59);

  @$pb.TagNumber(71)
  TemplateNodeConfig get templateConfig => $_getN(60);
  @$pb.TagNumber(71)
  set templateConfig(TemplateNodeConfig v) { setField(71, v); }
  @$pb.TagNumber(71)
  $core.bool hasTemplateConfig() => $_has(60);
  @$pb.TagNumber(71)
  void clearTemplateConfig() => clearField(71);
  @$pb.TagNumber(71)
  TemplateNodeConfig ensureTemplateConfig() => $_ensure(60);
}

class OscillatorNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OscillatorNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..e<OscillatorNodeConfig_OscillatorType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: OscillatorNodeConfig_OscillatorType.Square, valueOf: OscillatorNodeConfig_OscillatorType.valueOf, enumValues: OscillatorNodeConfig_OscillatorType.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ratio', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'max', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'min', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.OD)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reverse')
    ..hasRequiredFields = false
  ;

  OscillatorNodeConfig._() : super();
  factory OscillatorNodeConfig({
    OscillatorNodeConfig_OscillatorType? type,
    $core.double? ratio,
    $core.double? max,
    $core.double? min,
    $core.double? offset,
    $core.bool? reverse,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (ratio != null) {
      _result.ratio = ratio;
    }
    if (max != null) {
      _result.max = max;
    }
    if (min != null) {
      _result.min = min;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (reverse != null) {
      _result.reverse = reverse;
    }
    return _result;
  }
  factory OscillatorNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OscillatorNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OscillatorNodeConfig clone() => OscillatorNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OscillatorNodeConfig copyWith(void Function(OscillatorNodeConfig) updates) => super.copyWith((message) => updates(message as OscillatorNodeConfig)) as OscillatorNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OscillatorNodeConfig create() => OscillatorNodeConfig._();
  OscillatorNodeConfig createEmptyInstance() => create();
  static $pb.PbList<OscillatorNodeConfig> createRepeated() => $pb.PbList<OscillatorNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static OscillatorNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OscillatorNodeConfig>(create);
  static OscillatorNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  OscillatorNodeConfig_OscillatorType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(OscillatorNodeConfig_OscillatorType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get ratio => $_getN(1);
  @$pb.TagNumber(2)
  set ratio($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRatio() => $_has(1);
  @$pb.TagNumber(2)
  void clearRatio() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get max => $_getN(2);
  @$pb.TagNumber(3)
  set max($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMax() => $_has(2);
  @$pb.TagNumber(3)
  void clearMax() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get min => $_getN(3);
  @$pb.TagNumber(4)
  set min($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMin() => $_has(3);
  @$pb.TagNumber(4)
  void clearMin() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get offset => $_getN(4);
  @$pb.TagNumber(5)
  set offset($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOffset() => $_has(4);
  @$pb.TagNumber(5)
  void clearOffset() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get reverse => $_getBF(5);
  @$pb.TagNumber(6)
  set reverse($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReverse() => $_has(5);
  @$pb.TagNumber(6)
  void clearReverse() => clearField(6);
}

class ScriptingNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScriptingNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'script')
    ..hasRequiredFields = false
  ;

  ScriptingNodeConfig._() : super();
  factory ScriptingNodeConfig({
    $core.String? script,
  }) {
    final _result = create();
    if (script != null) {
      _result.script = script;
    }
    return _result;
  }
  factory ScriptingNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScriptingNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScriptingNodeConfig clone() => ScriptingNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScriptingNodeConfig copyWith(void Function(ScriptingNodeConfig) updates) => super.copyWith((message) => updates(message as ScriptingNodeConfig)) as ScriptingNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScriptingNodeConfig create() => ScriptingNodeConfig._();
  ScriptingNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ScriptingNodeConfig> createRepeated() => $pb.PbList<ScriptingNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ScriptingNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScriptingNodeConfig>(create);
  static ScriptingNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get script => $_getSZ(0);
  @$pb.TagNumber(1)
  set script($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScript() => $_has(0);
  @$pb.TagNumber(1)
  void clearScript() => clearField(1);
}

class SequenceNodeConfig_SequenceStep extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequenceNodeConfig.SequenceStep', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tick', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hold')
    ..hasRequiredFields = false
  ;

  SequenceNodeConfig_SequenceStep._() : super();
  factory SequenceNodeConfig_SequenceStep({
    $core.double? tick,
    $core.double? value,
    $core.bool? hold,
  }) {
    final _result = create();
    if (tick != null) {
      _result.tick = tick;
    }
    if (value != null) {
      _result.value = value;
    }
    if (hold != null) {
      _result.hold = hold;
    }
    return _result;
  }
  factory SequenceNodeConfig_SequenceStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceNodeConfig_SequenceStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceNodeConfig_SequenceStep clone() => SequenceNodeConfig_SequenceStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceNodeConfig_SequenceStep copyWith(void Function(SequenceNodeConfig_SequenceStep) updates) => super.copyWith((message) => updates(message as SequenceNodeConfig_SequenceStep)) as SequenceNodeConfig_SequenceStep; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SequenceNodeConfig_SequenceStep create() => SequenceNodeConfig_SequenceStep._();
  SequenceNodeConfig_SequenceStep createEmptyInstance() => create();
  static $pb.PbList<SequenceNodeConfig_SequenceStep> createRepeated() => $pb.PbList<SequenceNodeConfig_SequenceStep>();
  @$core.pragma('dart2js:noInline')
  static SequenceNodeConfig_SequenceStep getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceNodeConfig_SequenceStep>(create);
  static SequenceNodeConfig_SequenceStep? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get tick => $_getN(0);
  @$pb.TagNumber(1)
  set tick($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTick() => $_has(0);
  @$pb.TagNumber(1)
  void clearTick() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get hold => $_getBF(2);
  @$pb.TagNumber(3)
  set hold($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHold() => $_has(2);
  @$pb.TagNumber(3)
  void clearHold() => clearField(3);
}

class SequenceNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequenceNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<SequenceNodeConfig_SequenceStep>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: SequenceNodeConfig_SequenceStep.create)
    ..hasRequiredFields = false
  ;

  SequenceNodeConfig._() : super();
  factory SequenceNodeConfig({
    $core.Iterable<SequenceNodeConfig_SequenceStep>? steps,
  }) {
    final _result = create();
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    return _result;
  }
  factory SequenceNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceNodeConfig clone() => SequenceNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceNodeConfig copyWith(void Function(SequenceNodeConfig) updates) => super.copyWith((message) => updates(message as SequenceNodeConfig)) as SequenceNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SequenceNodeConfig create() => SequenceNodeConfig._();
  SequenceNodeConfig createEmptyInstance() => create();
  static $pb.PbList<SequenceNodeConfig> createRepeated() => $pb.PbList<SequenceNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static SequenceNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceNodeConfig>(create);
  static SequenceNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SequenceNodeConfig_SequenceStep> get steps => $_getList(0);
}

class ProgrammerNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProgrammerNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ProgrammerNodeConfig._() : super();
  factory ProgrammerNodeConfig() => create();
  factory ProgrammerNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgrammerNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgrammerNodeConfig clone() => ProgrammerNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgrammerNodeConfig copyWith(void Function(ProgrammerNodeConfig) updates) => super.copyWith((message) => updates(message as ProgrammerNodeConfig)) as ProgrammerNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProgrammerNodeConfig create() => ProgrammerNodeConfig._();
  ProgrammerNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ProgrammerNodeConfig> createRepeated() => $pb.PbList<ProgrammerNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ProgrammerNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProgrammerNodeConfig>(create);
  static ProgrammerNodeConfig? _defaultInstance;
}

class GroupNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  GroupNodeConfig._() : super();
  factory GroupNodeConfig({
    $core.int? groupId,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    return _result;
  }
  factory GroupNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupNodeConfig clone() => GroupNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupNodeConfig copyWith(void Function(GroupNodeConfig) updates) => super.copyWith((message) => updates(message as GroupNodeConfig)) as GroupNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupNodeConfig create() => GroupNodeConfig._();
  GroupNodeConfig createEmptyInstance() => create();
  static $pb.PbList<GroupNodeConfig> createRepeated() => $pb.PbList<GroupNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static GroupNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupNodeConfig>(create);
  static GroupNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get groupId => $_getIZ(0);
  @$pb.TagNumber(1)
  set groupId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);
}

class PresetNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PresetNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOM<$1.PresetId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'presetId', subBuilder: $1.PresetId.create)
    ..hasRequiredFields = false
  ;

  PresetNodeConfig._() : super();
  factory PresetNodeConfig({
    $1.PresetId? presetId,
  }) {
    final _result = create();
    if (presetId != null) {
      _result.presetId = presetId;
    }
    return _result;
  }
  factory PresetNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PresetNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PresetNodeConfig clone() => PresetNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PresetNodeConfig copyWith(void Function(PresetNodeConfig) updates) => super.copyWith((message) => updates(message as PresetNodeConfig)) as PresetNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PresetNodeConfig create() => PresetNodeConfig._();
  PresetNodeConfig createEmptyInstance() => create();
  static $pb.PbList<PresetNodeConfig> createRepeated() => $pb.PbList<PresetNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static PresetNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PresetNodeConfig>(create);
  static PresetNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $1.PresetId get presetId => $_getN(0);
  @$pb.TagNumber(1)
  set presetId($1.PresetId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPresetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPresetId() => clearField(1);
  @$pb.TagNumber(1)
  $1.PresetId ensurePresetId() => $_ensure(0);
}

class EnvelopeNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnvelopeNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attack', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'decay', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sustain', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'release', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  EnvelopeNodeConfig._() : super();
  factory EnvelopeNodeConfig({
    $core.double? attack,
    $core.double? decay,
    $core.double? sustain,
    $core.double? release,
  }) {
    final _result = create();
    if (attack != null) {
      _result.attack = attack;
    }
    if (decay != null) {
      _result.decay = decay;
    }
    if (sustain != null) {
      _result.sustain = sustain;
    }
    if (release != null) {
      _result.release = release;
    }
    return _result;
  }
  factory EnvelopeNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnvelopeNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnvelopeNodeConfig clone() => EnvelopeNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnvelopeNodeConfig copyWith(void Function(EnvelopeNodeConfig) updates) => super.copyWith((message) => updates(message as EnvelopeNodeConfig)) as EnvelopeNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EnvelopeNodeConfig create() => EnvelopeNodeConfig._();
  EnvelopeNodeConfig createEmptyInstance() => create();
  static $pb.PbList<EnvelopeNodeConfig> createRepeated() => $pb.PbList<EnvelopeNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static EnvelopeNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnvelopeNodeConfig>(create);
  static EnvelopeNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get attack => $_getN(0);
  @$pb.TagNumber(1)
  set attack($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAttack() => $_has(0);
  @$pb.TagNumber(1)
  void clearAttack() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get decay => $_getN(1);
  @$pb.TagNumber(2)
  set decay($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDecay() => $_has(1);
  @$pb.TagNumber(2)
  void clearDecay() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get sustain => $_getN(2);
  @$pb.TagNumber(3)
  set sustain($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSustain() => $_has(2);
  @$pb.TagNumber(3)
  void clearSustain() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get release => $_getN(3);
  @$pb.TagNumber(4)
  set release($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRelease() => $_has(3);
  @$pb.TagNumber(4)
  void clearRelease() => clearField(4);
}

class ClockNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClockNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speed', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ClockNodeConfig._() : super();
  factory ClockNodeConfig({
    $core.double? speed,
  }) {
    final _result = create();
    if (speed != null) {
      _result.speed = speed;
    }
    return _result;
  }
  factory ClockNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClockNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClockNodeConfig clone() => ClockNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClockNodeConfig copyWith(void Function(ClockNodeConfig) updates) => super.copyWith((message) => updates(message as ClockNodeConfig)) as ClockNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClockNodeConfig create() => ClockNodeConfig._();
  ClockNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ClockNodeConfig> createRepeated() => $pb.PbList<ClockNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ClockNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClockNodeConfig>(create);
  static ClockNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get speed => $_getN(0);
  @$pb.TagNumber(1)
  set speed($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpeed() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpeed() => clearField(1);
}

class FixtureNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtureId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  FixtureNodeConfig._() : super();
  factory FixtureNodeConfig({
    $core.int? fixtureId,
  }) {
    final _result = create();
    if (fixtureId != null) {
      _result.fixtureId = fixtureId;
    }
    return _result;
  }
  factory FixtureNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureNodeConfig clone() => FixtureNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureNodeConfig copyWith(void Function(FixtureNodeConfig) updates) => super.copyWith((message) => updates(message as FixtureNodeConfig)) as FixtureNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureNodeConfig create() => FixtureNodeConfig._();
  FixtureNodeConfig createEmptyInstance() => create();
  static $pb.PbList<FixtureNodeConfig> createRepeated() => $pb.PbList<FixtureNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static FixtureNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureNodeConfig>(create);
  static FixtureNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get fixtureId => $_getIZ(0);
  @$pb.TagNumber(1)
  set fixtureId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFixtureId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFixtureId() => clearField(1);
}

class SequencerNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequencerNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  SequencerNodeConfig._() : super();
  factory SequencerNodeConfig({
    $core.int? sequenceId,
  }) {
    final _result = create();
    if (sequenceId != null) {
      _result.sequenceId = sequenceId;
    }
    return _result;
  }
  factory SequencerNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequencerNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequencerNodeConfig clone() => SequencerNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequencerNodeConfig copyWith(void Function(SequencerNodeConfig) updates) => super.copyWith((message) => updates(message as SequencerNodeConfig)) as SequencerNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SequencerNodeConfig create() => SequencerNodeConfig._();
  SequencerNodeConfig createEmptyInstance() => create();
  static $pb.PbList<SequencerNodeConfig> createRepeated() => $pb.PbList<SequencerNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static SequencerNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequencerNodeConfig>(create);
  static SequencerNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequenceId => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequenceId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequenceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequenceId() => clearField(1);
}

class ButtonNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ButtonNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toggle')
    ..hasRequiredFields = false
  ;

  ButtonNodeConfig._() : super();
  factory ButtonNodeConfig({
    $core.bool? toggle,
  }) {
    final _result = create();
    if (toggle != null) {
      _result.toggle = toggle;
    }
    return _result;
  }
  factory ButtonNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ButtonNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ButtonNodeConfig clone() => ButtonNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ButtonNodeConfig copyWith(void Function(ButtonNodeConfig) updates) => super.copyWith((message) => updates(message as ButtonNodeConfig)) as ButtonNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ButtonNodeConfig create() => ButtonNodeConfig._();
  ButtonNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ButtonNodeConfig> createRepeated() => $pb.PbList<ButtonNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ButtonNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ButtonNodeConfig>(create);
  static ButtonNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get toggle => $_getBF(0);
  @$pb.TagNumber(1)
  set toggle($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToggle() => $_has(0);
  @$pb.TagNumber(1)
  void clearToggle() => clearField(1);
}

class FaderNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FaderNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  FaderNodeConfig._() : super();
  factory FaderNodeConfig() => create();
  factory FaderNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FaderNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FaderNodeConfig clone() => FaderNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FaderNodeConfig copyWith(void Function(FaderNodeConfig) updates) => super.copyWith((message) => updates(message as FaderNodeConfig)) as FaderNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FaderNodeConfig create() => FaderNodeConfig._();
  FaderNodeConfig createEmptyInstance() => create();
  static $pb.PbList<FaderNodeConfig> createRepeated() => $pb.PbList<FaderNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static FaderNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FaderNodeConfig>(create);
  static FaderNodeConfig? _defaultInstance;
}

class IldaFileNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IldaFileNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'file')
    ..hasRequiredFields = false
  ;

  IldaFileNodeConfig._() : super();
  factory IldaFileNodeConfig({
    $core.String? file,
  }) {
    final _result = create();
    if (file != null) {
      _result.file = file;
    }
    return _result;
  }
  factory IldaFileNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IldaFileNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IldaFileNodeConfig clone() => IldaFileNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IldaFileNodeConfig copyWith(void Function(IldaFileNodeConfig) updates) => super.copyWith((message) => updates(message as IldaFileNodeConfig)) as IldaFileNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IldaFileNodeConfig create() => IldaFileNodeConfig._();
  IldaFileNodeConfig createEmptyInstance() => create();
  static $pb.PbList<IldaFileNodeConfig> createRepeated() => $pb.PbList<IldaFileNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static IldaFileNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IldaFileNodeConfig>(create);
  static IldaFileNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get file => $_getSZ(0);
  @$pb.TagNumber(1)
  set file($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => clearField(1);
}

class LaserNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LaserNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..hasRequiredFields = false
  ;

  LaserNodeConfig._() : super();
  factory LaserNodeConfig({
    $core.String? deviceId,
  }) {
    final _result = create();
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    return _result;
  }
  factory LaserNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LaserNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LaserNodeConfig clone() => LaserNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LaserNodeConfig copyWith(void Function(LaserNodeConfig) updates) => super.copyWith((message) => updates(message as LaserNodeConfig)) as LaserNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LaserNodeConfig create() => LaserNodeConfig._();
  LaserNodeConfig createEmptyInstance() => create();
  static $pb.PbList<LaserNodeConfig> createRepeated() => $pb.PbList<LaserNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static LaserNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LaserNodeConfig>(create);
  static LaserNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => clearField(1);
}

class GamepadNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GamepadNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..e<GamepadNodeConfig_Control>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: GamepadNodeConfig_Control.LeftStickX, valueOf: GamepadNodeConfig_Control.valueOf, enumValues: GamepadNodeConfig_Control.values)
    ..hasRequiredFields = false
  ;

  GamepadNodeConfig._() : super();
  factory GamepadNodeConfig({
    $core.String? deviceId,
    GamepadNodeConfig_Control? control,
  }) {
    final _result = create();
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (control != null) {
      _result.control = control;
    }
    return _result;
  }
  factory GamepadNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GamepadNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GamepadNodeConfig clone() => GamepadNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GamepadNodeConfig copyWith(void Function(GamepadNodeConfig) updates) => super.copyWith((message) => updates(message as GamepadNodeConfig)) as GamepadNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GamepadNodeConfig create() => GamepadNodeConfig._();
  GamepadNodeConfig createEmptyInstance() => create();
  static $pb.PbList<GamepadNodeConfig> createRepeated() => $pb.PbList<GamepadNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static GamepadNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GamepadNodeConfig>(create);
  static GamepadNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => clearField(1);

  @$pb.TagNumber(2)
  GamepadNodeConfig_Control get control => $_getN(1);
  @$pb.TagNumber(2)
  set control(GamepadNodeConfig_Control v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasControl() => $_has(1);
  @$pb.TagNumber(2)
  void clearControl() => clearField(2);
}

class PixelPatternNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PixelPatternNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..e<PixelPatternNodeConfig_Pattern>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pattern', $pb.PbFieldType.OE, defaultOrMaker: PixelPatternNodeConfig_Pattern.RgbIterate, valueOf: PixelPatternNodeConfig_Pattern.valueOf, enumValues: PixelPatternNodeConfig_Pattern.values)
    ..hasRequiredFields = false
  ;

  PixelPatternNodeConfig._() : super();
  factory PixelPatternNodeConfig({
    PixelPatternNodeConfig_Pattern? pattern,
  }) {
    final _result = create();
    if (pattern != null) {
      _result.pattern = pattern;
    }
    return _result;
  }
  factory PixelPatternNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PixelPatternNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PixelPatternNodeConfig clone() => PixelPatternNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PixelPatternNodeConfig copyWith(void Function(PixelPatternNodeConfig) updates) => super.copyWith((message) => updates(message as PixelPatternNodeConfig)) as PixelPatternNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PixelPatternNodeConfig create() => PixelPatternNodeConfig._();
  PixelPatternNodeConfig createEmptyInstance() => create();
  static $pb.PbList<PixelPatternNodeConfig> createRepeated() => $pb.PbList<PixelPatternNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static PixelPatternNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PixelPatternNodeConfig>(create);
  static PixelPatternNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  PixelPatternNodeConfig_Pattern get pattern => $_getN(0);
  @$pb.TagNumber(1)
  set pattern(PixelPatternNodeConfig_Pattern v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPattern() => $_has(0);
  @$pb.TagNumber(1)
  void clearPattern() => clearField(1);
}

class PixelDmxNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PixelDmxNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startUniverse', $pb.PbFieldType.OU3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'output')
    ..hasRequiredFields = false
  ;

  PixelDmxNodeConfig._() : super();
  factory PixelDmxNodeConfig({
    $fixnum.Int64? width,
    $fixnum.Int64? height,
    $core.int? startUniverse,
    $core.String? output,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (startUniverse != null) {
      _result.startUniverse = startUniverse;
    }
    if (output != null) {
      _result.output = output;
    }
    return _result;
  }
  factory PixelDmxNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PixelDmxNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PixelDmxNodeConfig clone() => PixelDmxNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PixelDmxNodeConfig copyWith(void Function(PixelDmxNodeConfig) updates) => super.copyWith((message) => updates(message as PixelDmxNodeConfig)) as PixelDmxNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PixelDmxNodeConfig create() => PixelDmxNodeConfig._();
  PixelDmxNodeConfig createEmptyInstance() => create();
  static $pb.PbList<PixelDmxNodeConfig> createRepeated() => $pb.PbList<PixelDmxNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static PixelDmxNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PixelDmxNodeConfig>(create);
  static PixelDmxNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get width => $_getI64(0);
  @$pb.TagNumber(1)
  set width($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get height => $_getI64(1);
  @$pb.TagNumber(2)
  set height($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get startUniverse => $_getIZ(2);
  @$pb.TagNumber(3)
  set startUniverse($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartUniverse() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartUniverse() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get output => $_getSZ(3);
  @$pb.TagNumber(4)
  set output($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutput() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutput() => clearField(4);
}

class DmxOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DmxOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'output')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DmxOutputNodeConfig._() : super();
  factory DmxOutputNodeConfig({
    $core.String? output,
    $core.int? universe,
    $core.int? channel,
  }) {
    final _result = create();
    if (output != null) {
      _result.output = output;
    }
    if (universe != null) {
      _result.universe = universe;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    return _result;
  }
  factory DmxOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DmxOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DmxOutputNodeConfig clone() => DmxOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DmxOutputNodeConfig copyWith(void Function(DmxOutputNodeConfig) updates) => super.copyWith((message) => updates(message as DmxOutputNodeConfig)) as DmxOutputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DmxOutputNodeConfig create() => DmxOutputNodeConfig._();
  DmxOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<DmxOutputNodeConfig> createRepeated() => $pb.PbList<DmxOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static DmxOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DmxOutputNodeConfig>(create);
  static DmxOutputNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get output => $_getSZ(0);
  @$pb.TagNumber(1)
  set output($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutput() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutput() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get universe => $_getIZ(1);
  @$pb.TagNumber(2)
  set universe($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUniverse() => $_has(1);
  @$pb.TagNumber(2)
  void clearUniverse() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get channel => $_getIZ(2);
  @$pb.TagNumber(3)
  set channel($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannel() => clearField(3);
}

class MidiNodeConfig_NoteBinding extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiNodeConfig.NoteBinding', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..e<MidiNodeConfig_NoteBinding_MidiType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MidiNodeConfig_NoteBinding_MidiType.CC, valueOf: MidiNodeConfig_NoteBinding_MidiType.valueOf, enumValues: MidiNodeConfig_NoteBinding_MidiType.values)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rangeFrom', $pb.PbFieldType.OU3, protoName: 'rangeFrom')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rangeTo', $pb.PbFieldType.OU3, protoName: 'rangeTo')
    ..hasRequiredFields = false
  ;

  MidiNodeConfig_NoteBinding._() : super();
  factory MidiNodeConfig_NoteBinding({
    $core.int? channel,
    MidiNodeConfig_NoteBinding_MidiType? type,
    $core.int? port,
    $core.int? rangeFrom,
    $core.int? rangeTo,
  }) {
    final _result = create();
    if (channel != null) {
      _result.channel = channel;
    }
    if (type != null) {
      _result.type = type;
    }
    if (port != null) {
      _result.port = port;
    }
    if (rangeFrom != null) {
      _result.rangeFrom = rangeFrom;
    }
    if (rangeTo != null) {
      _result.rangeTo = rangeTo;
    }
    return _result;
  }
  factory MidiNodeConfig_NoteBinding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiNodeConfig_NoteBinding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiNodeConfig_NoteBinding clone() => MidiNodeConfig_NoteBinding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiNodeConfig_NoteBinding copyWith(void Function(MidiNodeConfig_NoteBinding) updates) => super.copyWith((message) => updates(message as MidiNodeConfig_NoteBinding)) as MidiNodeConfig_NoteBinding; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiNodeConfig_NoteBinding create() => MidiNodeConfig_NoteBinding._();
  MidiNodeConfig_NoteBinding createEmptyInstance() => create();
  static $pb.PbList<MidiNodeConfig_NoteBinding> createRepeated() => $pb.PbList<MidiNodeConfig_NoteBinding>();
  @$core.pragma('dart2js:noInline')
  static MidiNodeConfig_NoteBinding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiNodeConfig_NoteBinding>(create);
  static MidiNodeConfig_NoteBinding? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get channel => $_getIZ(0);
  @$pb.TagNumber(1)
  set channel($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  MidiNodeConfig_NoteBinding_MidiType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(MidiNodeConfig_NoteBinding_MidiType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get port => $_getIZ(2);
  @$pb.TagNumber(3)
  set port($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPort() => $_has(2);
  @$pb.TagNumber(3)
  void clearPort() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get rangeFrom => $_getIZ(3);
  @$pb.TagNumber(4)
  set rangeFrom($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRangeFrom() => $_has(3);
  @$pb.TagNumber(4)
  void clearRangeFrom() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get rangeTo => $_getIZ(4);
  @$pb.TagNumber(5)
  set rangeTo($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRangeTo() => $_has(4);
  @$pb.TagNumber(5)
  void clearRangeTo() => clearField(5);
}

class MidiNodeConfig_ControlBinding extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiNodeConfig.ControlBinding', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control')
    ..hasRequiredFields = false
  ;

  MidiNodeConfig_ControlBinding._() : super();
  factory MidiNodeConfig_ControlBinding({
    $core.String? page,
    $core.String? control,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (control != null) {
      _result.control = control;
    }
    return _result;
  }
  factory MidiNodeConfig_ControlBinding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiNodeConfig_ControlBinding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiNodeConfig_ControlBinding clone() => MidiNodeConfig_ControlBinding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiNodeConfig_ControlBinding copyWith(void Function(MidiNodeConfig_ControlBinding) updates) => super.copyWith((message) => updates(message as MidiNodeConfig_ControlBinding)) as MidiNodeConfig_ControlBinding; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiNodeConfig_ControlBinding create() => MidiNodeConfig_ControlBinding._();
  MidiNodeConfig_ControlBinding createEmptyInstance() => create();
  static $pb.PbList<MidiNodeConfig_ControlBinding> createRepeated() => $pb.PbList<MidiNodeConfig_ControlBinding>();
  @$core.pragma('dart2js:noInline')
  static MidiNodeConfig_ControlBinding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiNodeConfig_ControlBinding>(create);
  static MidiNodeConfig_ControlBinding? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get page => $_getSZ(0);
  @$pb.TagNumber(1)
  set page($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get control => $_getSZ(1);
  @$pb.TagNumber(2)
  set control($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasControl() => $_has(1);
  @$pb.TagNumber(2)
  void clearControl() => clearField(2);
}

enum MidiNodeConfig_Binding {
  noteBinding, 
  controlBinding, 
  notSet
}

class MidiNodeConfig extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, MidiNodeConfig_Binding> _MidiNodeConfig_BindingByTag = {
    2 : MidiNodeConfig_Binding.noteBinding,
    3 : MidiNodeConfig_Binding.controlBinding,
    0 : MidiNodeConfig_Binding.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'device')
    ..aOM<MidiNodeConfig_NoteBinding>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'noteBinding', protoName: 'noteBinding', subBuilder: MidiNodeConfig_NoteBinding.create)
    ..aOM<MidiNodeConfig_ControlBinding>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlBinding', protoName: 'controlBinding', subBuilder: MidiNodeConfig_ControlBinding.create)
    ..hasRequiredFields = false
  ;

  MidiNodeConfig._() : super();
  factory MidiNodeConfig({
    $core.String? device,
    MidiNodeConfig_NoteBinding? noteBinding,
    MidiNodeConfig_ControlBinding? controlBinding,
  }) {
    final _result = create();
    if (device != null) {
      _result.device = device;
    }
    if (noteBinding != null) {
      _result.noteBinding = noteBinding;
    }
    if (controlBinding != null) {
      _result.controlBinding = controlBinding;
    }
    return _result;
  }
  factory MidiNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiNodeConfig clone() => MidiNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiNodeConfig copyWith(void Function(MidiNodeConfig) updates) => super.copyWith((message) => updates(message as MidiNodeConfig)) as MidiNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiNodeConfig create() => MidiNodeConfig._();
  MidiNodeConfig createEmptyInstance() => create();
  static $pb.PbList<MidiNodeConfig> createRepeated() => $pb.PbList<MidiNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static MidiNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiNodeConfig>(create);
  static MidiNodeConfig? _defaultInstance;

  MidiNodeConfig_Binding whichBinding() => _MidiNodeConfig_BindingByTag[$_whichOneof(0)]!;
  void clearBinding() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get device => $_getSZ(0);
  @$pb.TagNumber(1)
  set device($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDevice() => $_has(0);
  @$pb.TagNumber(1)
  void clearDevice() => clearField(1);

  @$pb.TagNumber(2)
  MidiNodeConfig_NoteBinding get noteBinding => $_getN(1);
  @$pb.TagNumber(2)
  set noteBinding(MidiNodeConfig_NoteBinding v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNoteBinding() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoteBinding() => clearField(2);
  @$pb.TagNumber(2)
  MidiNodeConfig_NoteBinding ensureNoteBinding() => $_ensure(1);

  @$pb.TagNumber(3)
  MidiNodeConfig_ControlBinding get controlBinding => $_getN(2);
  @$pb.TagNumber(3)
  set controlBinding(MidiNodeConfig_ControlBinding v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasControlBinding() => $_has(2);
  @$pb.TagNumber(3)
  void clearControlBinding() => clearField(3);
  @$pb.TagNumber(3)
  MidiNodeConfig_ControlBinding ensureControlBinding() => $_ensure(2);
}

class OpcOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OpcOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  OpcOutputNodeConfig._() : super();
  factory OpcOutputNodeConfig({
    $core.String? host,
    $core.int? port,
    $fixnum.Int64? width,
    $fixnum.Int64? height,
  }) {
    final _result = create();
    if (host != null) {
      _result.host = host;
    }
    if (port != null) {
      _result.port = port;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory OpcOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpcOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpcOutputNodeConfig clone() => OpcOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpcOutputNodeConfig copyWith(void Function(OpcOutputNodeConfig) updates) => super.copyWith((message) => updates(message as OpcOutputNodeConfig)) as OpcOutputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OpcOutputNodeConfig create() => OpcOutputNodeConfig._();
  OpcOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<OpcOutputNodeConfig> createRepeated() => $pb.PbList<OpcOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static OpcOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpcOutputNodeConfig>(create);
  static OpcOutputNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get host => $_getSZ(0);
  @$pb.TagNumber(1)
  set host($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get port => $_getIZ(1);
  @$pb.TagNumber(2)
  set port($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get width => $_getI64(2);
  @$pb.TagNumber(3)
  set width($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get height => $_getI64(3);
  @$pb.TagNumber(4)
  set height($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => clearField(4);
}

class OscNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OscNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connection')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..e<OscNodeConfig_ArgumentType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'argumentType', $pb.PbFieldType.OE, protoName: 'argumentType', defaultOrMaker: OscNodeConfig_ArgumentType.Int, valueOf: OscNodeConfig_ArgumentType.valueOf, enumValues: OscNodeConfig_ArgumentType.values)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'onlyEmitChanges', protoName: 'onlyEmitChanges')
    ..hasRequiredFields = false
  ;

  OscNodeConfig._() : super();
  factory OscNodeConfig({
    $core.String? connection,
    $core.String? path,
    OscNodeConfig_ArgumentType? argumentType,
    $core.bool? onlyEmitChanges,
  }) {
    final _result = create();
    if (connection != null) {
      _result.connection = connection;
    }
    if (path != null) {
      _result.path = path;
    }
    if (argumentType != null) {
      _result.argumentType = argumentType;
    }
    if (onlyEmitChanges != null) {
      _result.onlyEmitChanges = onlyEmitChanges;
    }
    return _result;
  }
  factory OscNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OscNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OscNodeConfig clone() => OscNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OscNodeConfig copyWith(void Function(OscNodeConfig) updates) => super.copyWith((message) => updates(message as OscNodeConfig)) as OscNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OscNodeConfig create() => OscNodeConfig._();
  OscNodeConfig createEmptyInstance() => create();
  static $pb.PbList<OscNodeConfig> createRepeated() => $pb.PbList<OscNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static OscNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OscNodeConfig>(create);
  static OscNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get connection => $_getSZ(0);
  @$pb.TagNumber(1)
  set connection($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConnection() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnection() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  @$pb.TagNumber(3)
  OscNodeConfig_ArgumentType get argumentType => $_getN(2);
  @$pb.TagNumber(3)
  set argumentType(OscNodeConfig_ArgumentType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasArgumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearArgumentType() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get onlyEmitChanges => $_getBF(3);
  @$pb.TagNumber(4)
  set onlyEmitChanges($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOnlyEmitChanges() => $_has(3);
  @$pb.TagNumber(4)
  void clearOnlyEmitChanges() => clearField(4);
}

class VideoColorBalanceNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoColorBalanceNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  VideoColorBalanceNodeConfig._() : super();
  factory VideoColorBalanceNodeConfig() => create();
  factory VideoColorBalanceNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoColorBalanceNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoColorBalanceNodeConfig clone() => VideoColorBalanceNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoColorBalanceNodeConfig copyWith(void Function(VideoColorBalanceNodeConfig) updates) => super.copyWith((message) => updates(message as VideoColorBalanceNodeConfig)) as VideoColorBalanceNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoColorBalanceNodeConfig create() => VideoColorBalanceNodeConfig._();
  VideoColorBalanceNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoColorBalanceNodeConfig> createRepeated() => $pb.PbList<VideoColorBalanceNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoColorBalanceNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoColorBalanceNodeConfig>(create);
  static VideoColorBalanceNodeConfig? _defaultInstance;
}

class VideoEffectNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoEffectNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  VideoEffectNodeConfig._() : super();
  factory VideoEffectNodeConfig() => create();
  factory VideoEffectNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoEffectNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoEffectNodeConfig clone() => VideoEffectNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoEffectNodeConfig copyWith(void Function(VideoEffectNodeConfig) updates) => super.copyWith((message) => updates(message as VideoEffectNodeConfig)) as VideoEffectNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoEffectNodeConfig create() => VideoEffectNodeConfig._();
  VideoEffectNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoEffectNodeConfig> createRepeated() => $pb.PbList<VideoEffectNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoEffectNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoEffectNodeConfig>(create);
  static VideoEffectNodeConfig? _defaultInstance;
}

class VideoFileNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoFileNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'file')
    ..hasRequiredFields = false
  ;

  VideoFileNodeConfig._() : super();
  factory VideoFileNodeConfig({
    $core.String? file,
  }) {
    final _result = create();
    if (file != null) {
      _result.file = file;
    }
    return _result;
  }
  factory VideoFileNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoFileNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoFileNodeConfig clone() => VideoFileNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoFileNodeConfig copyWith(void Function(VideoFileNodeConfig) updates) => super.copyWith((message) => updates(message as VideoFileNodeConfig)) as VideoFileNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoFileNodeConfig create() => VideoFileNodeConfig._();
  VideoFileNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoFileNodeConfig> createRepeated() => $pb.PbList<VideoFileNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoFileNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoFileNodeConfig>(create);
  static VideoFileNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get file => $_getSZ(0);
  @$pb.TagNumber(1)
  set file($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => clearField(1);
}

class VideoOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  VideoOutputNodeConfig._() : super();
  factory VideoOutputNodeConfig() => create();
  factory VideoOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoOutputNodeConfig clone() => VideoOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoOutputNodeConfig copyWith(void Function(VideoOutputNodeConfig) updates) => super.copyWith((message) => updates(message as VideoOutputNodeConfig)) as VideoOutputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoOutputNodeConfig create() => VideoOutputNodeConfig._();
  VideoOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoOutputNodeConfig> createRepeated() => $pb.PbList<VideoOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoOutputNodeConfig>(create);
  static VideoOutputNodeConfig? _defaultInstance;
}

class VideoTransformNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoTransformNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  VideoTransformNodeConfig._() : super();
  factory VideoTransformNodeConfig() => create();
  factory VideoTransformNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoTransformNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoTransformNodeConfig clone() => VideoTransformNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoTransformNodeConfig copyWith(void Function(VideoTransformNodeConfig) updates) => super.copyWith((message) => updates(message as VideoTransformNodeConfig)) as VideoTransformNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoTransformNodeConfig create() => VideoTransformNodeConfig._();
  VideoTransformNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoTransformNodeConfig> createRepeated() => $pb.PbList<VideoTransformNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoTransformNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoTransformNodeConfig>(create);
  static VideoTransformNodeConfig? _defaultInstance;
}

class SelectNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SelectNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SelectNodeConfig._() : super();
  factory SelectNodeConfig() => create();
  factory SelectNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SelectNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SelectNodeConfig clone() => SelectNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SelectNodeConfig copyWith(void Function(SelectNodeConfig) updates) => super.copyWith((message) => updates(message as SelectNodeConfig)) as SelectNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SelectNodeConfig create() => SelectNodeConfig._();
  SelectNodeConfig createEmptyInstance() => create();
  static $pb.PbList<SelectNodeConfig> createRepeated() => $pb.PbList<SelectNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static SelectNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SelectNodeConfig>(create);
  static SelectNodeConfig? _defaultInstance;
}

class MergeNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MergeNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..e<MergeNodeConfig_MergeMode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: MergeNodeConfig_MergeMode.Latest, valueOf: MergeNodeConfig_MergeMode.valueOf, enumValues: MergeNodeConfig_MergeMode.values)
    ..hasRequiredFields = false
  ;

  MergeNodeConfig._() : super();
  factory MergeNodeConfig({
    MergeNodeConfig_MergeMode? mode,
  }) {
    final _result = create();
    if (mode != null) {
      _result.mode = mode;
    }
    return _result;
  }
  factory MergeNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MergeNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MergeNodeConfig clone() => MergeNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MergeNodeConfig copyWith(void Function(MergeNodeConfig) updates) => super.copyWith((message) => updates(message as MergeNodeConfig)) as MergeNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MergeNodeConfig create() => MergeNodeConfig._();
  MergeNodeConfig createEmptyInstance() => create();
  static $pb.PbList<MergeNodeConfig> createRepeated() => $pb.PbList<MergeNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static MergeNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MergeNodeConfig>(create);
  static MergeNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  MergeNodeConfig_MergeMode get mode => $_getN(0);
  @$pb.TagNumber(1)
  set mode(MergeNodeConfig_MergeMode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearMode() => clearField(1);
}

class ThresholdNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ThresholdNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lowerThreshold', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'upperThreshold', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeValue', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inactiveValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ThresholdNodeConfig._() : super();
  factory ThresholdNodeConfig({
    $core.double? lowerThreshold,
    $core.double? upperThreshold,
    $core.double? activeValue,
    $core.double? inactiveValue,
  }) {
    final _result = create();
    if (lowerThreshold != null) {
      _result.lowerThreshold = lowerThreshold;
    }
    if (upperThreshold != null) {
      _result.upperThreshold = upperThreshold;
    }
    if (activeValue != null) {
      _result.activeValue = activeValue;
    }
    if (inactiveValue != null) {
      _result.inactiveValue = inactiveValue;
    }
    return _result;
  }
  factory ThresholdNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ThresholdNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ThresholdNodeConfig clone() => ThresholdNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ThresholdNodeConfig copyWith(void Function(ThresholdNodeConfig) updates) => super.copyWith((message) => updates(message as ThresholdNodeConfig)) as ThresholdNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ThresholdNodeConfig create() => ThresholdNodeConfig._();
  ThresholdNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ThresholdNodeConfig> createRepeated() => $pb.PbList<ThresholdNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ThresholdNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ThresholdNodeConfig>(create);
  static ThresholdNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lowerThreshold => $_getN(0);
  @$pb.TagNumber(1)
  set lowerThreshold($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLowerThreshold() => $_has(0);
  @$pb.TagNumber(1)
  void clearLowerThreshold() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get upperThreshold => $_getN(1);
  @$pb.TagNumber(2)
  set upperThreshold($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpperThreshold() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpperThreshold() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get activeValue => $_getN(2);
  @$pb.TagNumber(3)
  set activeValue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasActiveValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearActiveValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get inactiveValue => $_getN(3);
  @$pb.TagNumber(4)
  set inactiveValue($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInactiveValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearInactiveValue() => clearField(4);
}

class EncoderNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EncoderNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'holdRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  EncoderNodeConfig._() : super();
  factory EncoderNodeConfig({
    $core.double? holdRate,
  }) {
    final _result = create();
    if (holdRate != null) {
      _result.holdRate = holdRate;
    }
    return _result;
  }
  factory EncoderNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EncoderNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EncoderNodeConfig clone() => EncoderNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EncoderNodeConfig copyWith(void Function(EncoderNodeConfig) updates) => super.copyWith((message) => updates(message as EncoderNodeConfig)) as EncoderNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EncoderNodeConfig create() => EncoderNodeConfig._();
  EncoderNodeConfig createEmptyInstance() => create();
  static $pb.PbList<EncoderNodeConfig> createRepeated() => $pb.PbList<EncoderNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static EncoderNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EncoderNodeConfig>(create);
  static EncoderNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get holdRate => $_getN(0);
  @$pb.TagNumber(1)
  set holdRate($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHoldRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearHoldRate() => clearField(1);
}

class ColorRgbNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ColorRgbNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ColorRgbNodeConfig._() : super();
  factory ColorRgbNodeConfig() => create();
  factory ColorRgbNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ColorRgbNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ColorRgbNodeConfig clone() => ColorRgbNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ColorRgbNodeConfig copyWith(void Function(ColorRgbNodeConfig) updates) => super.copyWith((message) => updates(message as ColorRgbNodeConfig)) as ColorRgbNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ColorRgbNodeConfig create() => ColorRgbNodeConfig._();
  ColorRgbNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ColorRgbNodeConfig> createRepeated() => $pb.PbList<ColorRgbNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ColorRgbNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ColorRgbNodeConfig>(create);
  static ColorRgbNodeConfig? _defaultInstance;
}

class ColorHsvNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ColorHsvNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ColorHsvNodeConfig._() : super();
  factory ColorHsvNodeConfig() => create();
  factory ColorHsvNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ColorHsvNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ColorHsvNodeConfig clone() => ColorHsvNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ColorHsvNodeConfig copyWith(void Function(ColorHsvNodeConfig) updates) => super.copyWith((message) => updates(message as ColorHsvNodeConfig)) as ColorHsvNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ColorHsvNodeConfig create() => ColorHsvNodeConfig._();
  ColorHsvNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ColorHsvNodeConfig> createRepeated() => $pb.PbList<ColorHsvNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ColorHsvNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ColorHsvNodeConfig>(create);
  static ColorHsvNodeConfig? _defaultInstance;
}

class ContainerNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContainerNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<Node>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..hasRequiredFields = false
  ;

  ContainerNodeConfig._() : super();
  factory ContainerNodeConfig({
    $core.Iterable<Node>? nodes,
  }) {
    final _result = create();
    if (nodes != null) {
      _result.nodes.addAll(nodes);
    }
    return _result;
  }
  factory ContainerNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContainerNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContainerNodeConfig clone() => ContainerNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContainerNodeConfig copyWith(void Function(ContainerNodeConfig) updates) => super.copyWith((message) => updates(message as ContainerNodeConfig)) as ContainerNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContainerNodeConfig create() => ContainerNodeConfig._();
  ContainerNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ContainerNodeConfig> createRepeated() => $pb.PbList<ContainerNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ContainerNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContainerNodeConfig>(create);
  static ContainerNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Node> get nodes => $_getList(0);
}

class MathNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MathNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..e<MathNodeConfig_Mode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: MathNodeConfig_Mode.Addition, valueOf: MathNodeConfig_Mode.valueOf, enumValues: MathNodeConfig_Mode.values)
    ..hasRequiredFields = false
  ;

  MathNodeConfig._() : super();
  factory MathNodeConfig({
    MathNodeConfig_Mode? mode,
  }) {
    final _result = create();
    if (mode != null) {
      _result.mode = mode;
    }
    return _result;
  }
  factory MathNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MathNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MathNodeConfig clone() => MathNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MathNodeConfig copyWith(void Function(MathNodeConfig) updates) => super.copyWith((message) => updates(message as MathNodeConfig)) as MathNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MathNodeConfig create() => MathNodeConfig._();
  MathNodeConfig createEmptyInstance() => create();
  static $pb.PbList<MathNodeConfig> createRepeated() => $pb.PbList<MathNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static MathNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MathNodeConfig>(create);
  static MathNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  MathNodeConfig_Mode get mode => $_getN(0);
  @$pb.TagNumber(1)
  set mode(MathNodeConfig_Mode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearMode() => clearField(1);
}

class MqttInputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MqttInputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connection')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  MqttInputNodeConfig._() : super();
  factory MqttInputNodeConfig({
    $core.String? connection,
    $core.String? path,
  }) {
    final _result = create();
    if (connection != null) {
      _result.connection = connection;
    }
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory MqttInputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MqttInputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MqttInputNodeConfig clone() => MqttInputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MqttInputNodeConfig copyWith(void Function(MqttInputNodeConfig) updates) => super.copyWith((message) => updates(message as MqttInputNodeConfig)) as MqttInputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MqttInputNodeConfig create() => MqttInputNodeConfig._();
  MqttInputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<MqttInputNodeConfig> createRepeated() => $pb.PbList<MqttInputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static MqttInputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MqttInputNodeConfig>(create);
  static MqttInputNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get connection => $_getSZ(0);
  @$pb.TagNumber(1)
  set connection($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConnection() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnection() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);
}

class MqttOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MqttOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connection')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'retain')
    ..hasRequiredFields = false
  ;

  MqttOutputNodeConfig._() : super();
  factory MqttOutputNodeConfig({
    $core.String? connection,
    $core.String? path,
    $core.bool? retain,
  }) {
    final _result = create();
    if (connection != null) {
      _result.connection = connection;
    }
    if (path != null) {
      _result.path = path;
    }
    if (retain != null) {
      _result.retain = retain;
    }
    return _result;
  }
  factory MqttOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MqttOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MqttOutputNodeConfig clone() => MqttOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MqttOutputNodeConfig copyWith(void Function(MqttOutputNodeConfig) updates) => super.copyWith((message) => updates(message as MqttOutputNodeConfig)) as MqttOutputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MqttOutputNodeConfig create() => MqttOutputNodeConfig._();
  MqttOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<MqttOutputNodeConfig> createRepeated() => $pb.PbList<MqttOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static MqttOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MqttOutputNodeConfig>(create);
  static MqttOutputNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get connection => $_getSZ(0);
  @$pb.TagNumber(1)
  set connection($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConnection() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnection() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get retain => $_getBF(2);
  @$pb.TagNumber(3)
  set retain($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRetain() => $_has(2);
  @$pb.TagNumber(3)
  void clearRetain() => clearField(3);
}

class NumberToDataNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NumberToDataNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  NumberToDataNodeConfig._() : super();
  factory NumberToDataNodeConfig() => create();
  factory NumberToDataNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NumberToDataNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NumberToDataNodeConfig clone() => NumberToDataNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NumberToDataNodeConfig copyWith(void Function(NumberToDataNodeConfig) updates) => super.copyWith((message) => updates(message as NumberToDataNodeConfig)) as NumberToDataNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NumberToDataNodeConfig create() => NumberToDataNodeConfig._();
  NumberToDataNodeConfig createEmptyInstance() => create();
  static $pb.PbList<NumberToDataNodeConfig> createRepeated() => $pb.PbList<NumberToDataNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static NumberToDataNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NumberToDataNodeConfig>(create);
  static NumberToDataNodeConfig? _defaultInstance;
}

class DataToNumberNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DataToNumberNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  DataToNumberNodeConfig._() : super();
  factory DataToNumberNodeConfig() => create();
  factory DataToNumberNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DataToNumberNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DataToNumberNodeConfig clone() => DataToNumberNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DataToNumberNodeConfig copyWith(void Function(DataToNumberNodeConfig) updates) => super.copyWith((message) => updates(message as DataToNumberNodeConfig)) as DataToNumberNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DataToNumberNodeConfig create() => DataToNumberNodeConfig._();
  DataToNumberNodeConfig createEmptyInstance() => create();
  static $pb.PbList<DataToNumberNodeConfig> createRepeated() => $pb.PbList<DataToNumberNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static DataToNumberNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DataToNumberNodeConfig>(create);
  static DataToNumberNodeConfig? _defaultInstance;
}

class ValueNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValueNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  ValueNodeConfig._() : super();
  factory ValueNodeConfig({
    $core.String? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ValueNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValueNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValueNodeConfig clone() => ValueNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValueNodeConfig copyWith(void Function(ValueNodeConfig) updates) => super.copyWith((message) => updates(message as ValueNodeConfig)) as ValueNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValueNodeConfig create() => ValueNodeConfig._();
  ValueNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ValueNodeConfig> createRepeated() => $pb.PbList<ValueNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ValueNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValueNodeConfig>(create);
  static ValueNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class ExtractNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExtractNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  ExtractNodeConfig._() : super();
  factory ExtractNodeConfig({
    $core.String? path,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory ExtractNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExtractNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExtractNodeConfig clone() => ExtractNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExtractNodeConfig copyWith(void Function(ExtractNodeConfig) updates) => super.copyWith((message) => updates(message as ExtractNodeConfig)) as ExtractNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExtractNodeConfig create() => ExtractNodeConfig._();
  ExtractNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ExtractNodeConfig> createRepeated() => $pb.PbList<ExtractNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ExtractNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtractNodeConfig>(create);
  static ExtractNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class TemplateNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TemplateNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'template')
    ..hasRequiredFields = false
  ;

  TemplateNodeConfig._() : super();
  factory TemplateNodeConfig({
    $core.String? template,
  }) {
    final _result = create();
    if (template != null) {
      _result.template = template;
    }
    return _result;
  }
  factory TemplateNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TemplateNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TemplateNodeConfig clone() => TemplateNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TemplateNodeConfig copyWith(void Function(TemplateNodeConfig) updates) => super.copyWith((message) => updates(message as TemplateNodeConfig)) as TemplateNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TemplateNodeConfig create() => TemplateNodeConfig._();
  TemplateNodeConfig createEmptyInstance() => create();
  static $pb.PbList<TemplateNodeConfig> createRepeated() => $pb.PbList<TemplateNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static TemplateNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TemplateNodeConfig>(create);
  static TemplateNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get template => $_getSZ(0);
  @$pb.TagNumber(1)
  set template($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTemplate() => $_has(0);
  @$pb.TagNumber(1)
  void clearTemplate() => clearField(1);
}

class PlanScreenNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlanScreenNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'planId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'screenId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  PlanScreenNodeConfig._() : super();
  factory PlanScreenNodeConfig({
    $core.String? planId,
    $core.int? screenId,
  }) {
    final _result = create();
    if (planId != null) {
      _result.planId = planId;
    }
    if (screenId != null) {
      _result.screenId = screenId;
    }
    return _result;
  }
  factory PlanScreenNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlanScreenNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlanScreenNodeConfig clone() => PlanScreenNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlanScreenNodeConfig copyWith(void Function(PlanScreenNodeConfig) updates) => super.copyWith((message) => updates(message as PlanScreenNodeConfig)) as PlanScreenNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlanScreenNodeConfig create() => PlanScreenNodeConfig._();
  PlanScreenNodeConfig createEmptyInstance() => create();
  static $pb.PbList<PlanScreenNodeConfig> createRepeated() => $pb.PbList<PlanScreenNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static PlanScreenNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlanScreenNodeConfig>(create);
  static PlanScreenNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get planId => $_getSZ(0);
  @$pb.TagNumber(1)
  set planId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get screenId => $_getIZ(1);
  @$pb.TagNumber(2)
  set screenId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScreenId() => $_has(1);
  @$pb.TagNumber(2)
  void clearScreenId() => clearField(2);
}

class DelayNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DelayNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bufferSize', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DelayNodeConfig._() : super();
  factory DelayNodeConfig({
    $core.int? bufferSize,
  }) {
    final _result = create();
    if (bufferSize != null) {
      _result.bufferSize = bufferSize;
    }
    return _result;
  }
  factory DelayNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DelayNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DelayNodeConfig clone() => DelayNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DelayNodeConfig copyWith(void Function(DelayNodeConfig) updates) => super.copyWith((message) => updates(message as DelayNodeConfig)) as DelayNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DelayNodeConfig create() => DelayNodeConfig._();
  DelayNodeConfig createEmptyInstance() => create();
  static $pb.PbList<DelayNodeConfig> createRepeated() => $pb.PbList<DelayNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static DelayNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DelayNodeConfig>(create);
  static DelayNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get bufferSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set bufferSize($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBufferSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearBufferSize() => clearField(1);
}

class RampNodeConfig_RampStep extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RampNodeConfig.RampStep', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0b', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1a', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  RampNodeConfig_RampStep._() : super();
  factory RampNodeConfig_RampStep({
    $core.double? x,
    $core.double? y,
    $core.double? c0a,
    $core.double? c0b,
    $core.double? c1a,
    $core.double? c1b,
  }) {
    final _result = create();
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    if (c0a != null) {
      _result.c0a = c0a;
    }
    if (c0b != null) {
      _result.c0b = c0b;
    }
    if (c1a != null) {
      _result.c1a = c1a;
    }
    if (c1b != null) {
      _result.c1b = c1b;
    }
    return _result;
  }
  factory RampNodeConfig_RampStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RampNodeConfig_RampStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RampNodeConfig_RampStep clone() => RampNodeConfig_RampStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RampNodeConfig_RampStep copyWith(void Function(RampNodeConfig_RampStep) updates) => super.copyWith((message) => updates(message as RampNodeConfig_RampStep)) as RampNodeConfig_RampStep; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RampNodeConfig_RampStep create() => RampNodeConfig_RampStep._();
  RampNodeConfig_RampStep createEmptyInstance() => create();
  static $pb.PbList<RampNodeConfig_RampStep> createRepeated() => $pb.PbList<RampNodeConfig_RampStep>();
  @$core.pragma('dart2js:noInline')
  static RampNodeConfig_RampStep getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RampNodeConfig_RampStep>(create);
  static RampNodeConfig_RampStep? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get c0a => $_getN(2);
  @$pb.TagNumber(3)
  set c0a($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasC0a() => $_has(2);
  @$pb.TagNumber(3)
  void clearC0a() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get c0b => $_getN(3);
  @$pb.TagNumber(4)
  set c0b($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasC0b() => $_has(3);
  @$pb.TagNumber(4)
  void clearC0b() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get c1a => $_getN(4);
  @$pb.TagNumber(5)
  set c1a($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasC1a() => $_has(4);
  @$pb.TagNumber(5)
  void clearC1a() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get c1b => $_getN(5);
  @$pb.TagNumber(6)
  set c1b($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasC1b() => $_has(5);
  @$pb.TagNumber(6)
  void clearC1b() => clearField(6);
}

class RampNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RampNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<RampNodeConfig_RampStep>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: RampNodeConfig_RampStep.create)
    ..hasRequiredFields = false
  ;

  RampNodeConfig._() : super();
  factory RampNodeConfig({
    $core.Iterable<RampNodeConfig_RampStep>? steps,
  }) {
    final _result = create();
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    return _result;
  }
  factory RampNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RampNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RampNodeConfig clone() => RampNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RampNodeConfig copyWith(void Function(RampNodeConfig) updates) => super.copyWith((message) => updates(message as RampNodeConfig)) as RampNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RampNodeConfig create() => RampNodeConfig._();
  RampNodeConfig createEmptyInstance() => create();
  static $pb.PbList<RampNodeConfig> createRepeated() => $pb.PbList<RampNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static RampNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RampNodeConfig>(create);
  static RampNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<RampNodeConfig_RampStep> get steps => $_getList(0);
}

class NoiseNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NoiseNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tickRate', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fade')
    ..hasRequiredFields = false
  ;

  NoiseNodeConfig._() : super();
  factory NoiseNodeConfig({
    $fixnum.Int64? tickRate,
    $core.bool? fade,
  }) {
    final _result = create();
    if (tickRate != null) {
      _result.tickRate = tickRate;
    }
    if (fade != null) {
      _result.fade = fade;
    }
    return _result;
  }
  factory NoiseNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NoiseNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NoiseNodeConfig clone() => NoiseNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NoiseNodeConfig copyWith(void Function(NoiseNodeConfig) updates) => super.copyWith((message) => updates(message as NoiseNodeConfig)) as NoiseNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NoiseNodeConfig create() => NoiseNodeConfig._();
  NoiseNodeConfig createEmptyInstance() => create();
  static $pb.PbList<NoiseNodeConfig> createRepeated() => $pb.PbList<NoiseNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static NoiseNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NoiseNodeConfig>(create);
  static NoiseNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get tickRate => $_getI64(0);
  @$pb.TagNumber(1)
  set tickRate($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTickRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearTickRate() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get fade => $_getBF(1);
  @$pb.TagNumber(2)
  set fade($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFade() => $_has(1);
  @$pb.TagNumber(2)
  void clearFade() => clearField(2);
}

class LabelNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LabelNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..hasRequiredFields = false
  ;

  LabelNodeConfig._() : super();
  factory LabelNodeConfig({
    $core.String? text,
  }) {
    final _result = create();
    if (text != null) {
      _result.text = text;
    }
    return _result;
  }
  factory LabelNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LabelNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LabelNodeConfig clone() => LabelNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LabelNodeConfig copyWith(void Function(LabelNodeConfig) updates) => super.copyWith((message) => updates(message as LabelNodeConfig)) as LabelNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LabelNodeConfig create() => LabelNodeConfig._();
  LabelNodeConfig createEmptyInstance() => create();
  static $pb.PbList<LabelNodeConfig> createRepeated() => $pb.PbList<LabelNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static LabelNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LabelNodeConfig>(create);
  static LabelNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);
}

class TransportNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransportNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  TransportNodeConfig._() : super();
  factory TransportNodeConfig() => create();
  factory TransportNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransportNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransportNodeConfig clone() => TransportNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransportNodeConfig copyWith(void Function(TransportNodeConfig) updates) => super.copyWith((message) => updates(message as TransportNodeConfig)) as TransportNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransportNodeConfig create() => TransportNodeConfig._();
  TransportNodeConfig createEmptyInstance() => create();
  static $pb.PbList<TransportNodeConfig> createRepeated() => $pb.PbList<TransportNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static TransportNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransportNodeConfig>(create);
  static TransportNodeConfig? _defaultInstance;
}

class G13InputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'G13InputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..e<G13InputNodeConfig_Key>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OE, defaultOrMaker: G13InputNodeConfig_Key.G1, valueOf: G13InputNodeConfig_Key.valueOf, enumValues: G13InputNodeConfig_Key.values)
    ..hasRequiredFields = false
  ;

  G13InputNodeConfig._() : super();
  factory G13InputNodeConfig({
    $core.String? deviceId,
    G13InputNodeConfig_Key? key,
  }) {
    final _result = create();
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (key != null) {
      _result.key = key;
    }
    return _result;
  }
  factory G13InputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory G13InputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  G13InputNodeConfig clone() => G13InputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  G13InputNodeConfig copyWith(void Function(G13InputNodeConfig) updates) => super.copyWith((message) => updates(message as G13InputNodeConfig)) as G13InputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static G13InputNodeConfig create() => G13InputNodeConfig._();
  G13InputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<G13InputNodeConfig> createRepeated() => $pb.PbList<G13InputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static G13InputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<G13InputNodeConfig>(create);
  static G13InputNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => clearField(1);

  @$pb.TagNumber(2)
  G13InputNodeConfig_Key get key => $_getN(1);
  @$pb.TagNumber(2)
  set key(G13InputNodeConfig_Key v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);
}

class G13OutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'G13OutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..hasRequiredFields = false
  ;

  G13OutputNodeConfig._() : super();
  factory G13OutputNodeConfig({
    $core.String? deviceId,
  }) {
    final _result = create();
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    return _result;
  }
  factory G13OutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory G13OutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  G13OutputNodeConfig clone() => G13OutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  G13OutputNodeConfig copyWith(void Function(G13OutputNodeConfig) updates) => super.copyWith((message) => updates(message as G13OutputNodeConfig)) as G13OutputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static G13OutputNodeConfig create() => G13OutputNodeConfig._();
  G13OutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<G13OutputNodeConfig> createRepeated() => $pb.PbList<G13OutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static G13OutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<G13OutputNodeConfig>(create);
  static G13OutputNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => clearField(1);
}

class ConstantNumberNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConstantNumberNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ConstantNumberNodeConfig._() : super();
  factory ConstantNumberNodeConfig({
    $core.double? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ConstantNumberNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConstantNumberNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConstantNumberNodeConfig clone() => ConstantNumberNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConstantNumberNodeConfig copyWith(void Function(ConstantNumberNodeConfig) updates) => super.copyWith((message) => updates(message as ConstantNumberNodeConfig)) as ConstantNumberNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConstantNumberNodeConfig create() => ConstantNumberNodeConfig._();
  ConstantNumberNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ConstantNumberNodeConfig> createRepeated() => $pb.PbList<ConstantNumberNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ConstantNumberNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConstantNumberNodeConfig>(create);
  static ConstantNumberNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class ConditionalNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConditionalNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'threshold', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ConditionalNodeConfig._() : super();
  factory ConditionalNodeConfig({
    $core.double? threshold,
  }) {
    final _result = create();
    if (threshold != null) {
      _result.threshold = threshold;
    }
    return _result;
  }
  factory ConditionalNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConditionalNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConditionalNodeConfig clone() => ConditionalNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConditionalNodeConfig copyWith(void Function(ConditionalNodeConfig) updates) => super.copyWith((message) => updates(message as ConditionalNodeConfig)) as ConditionalNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConditionalNodeConfig create() => ConditionalNodeConfig._();
  ConditionalNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ConditionalNodeConfig> createRepeated() => $pb.PbList<ConditionalNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ConditionalNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConditionalNodeConfig>(create);
  static ConditionalNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get threshold => $_getN(0);
  @$pb.TagNumber(1)
  set threshold($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasThreshold() => $_has(0);
  @$pb.TagNumber(1)
  void clearThreshold() => clearField(1);
}

class TimecodeControlNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TimecodeControlNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timecodeId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  TimecodeControlNodeConfig._() : super();
  factory TimecodeControlNodeConfig({
    $core.int? timecodeId,
  }) {
    final _result = create();
    if (timecodeId != null) {
      _result.timecodeId = timecodeId;
    }
    return _result;
  }
  factory TimecodeControlNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimecodeControlNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimecodeControlNodeConfig clone() => TimecodeControlNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimecodeControlNodeConfig copyWith(void Function(TimecodeControlNodeConfig) updates) => super.copyWith((message) => updates(message as TimecodeControlNodeConfig)) as TimecodeControlNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TimecodeControlNodeConfig create() => TimecodeControlNodeConfig._();
  TimecodeControlNodeConfig createEmptyInstance() => create();
  static $pb.PbList<TimecodeControlNodeConfig> createRepeated() => $pb.PbList<TimecodeControlNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static TimecodeControlNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimecodeControlNodeConfig>(create);
  static TimecodeControlNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get timecodeId => $_getIZ(0);
  @$pb.TagNumber(1)
  set timecodeId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimecodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimecodeId() => clearField(1);
}

class TimecodeOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TimecodeOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  TimecodeOutputNodeConfig._() : super();
  factory TimecodeOutputNodeConfig({
    $core.int? controlId,
  }) {
    final _result = create();
    if (controlId != null) {
      _result.controlId = controlId;
    }
    return _result;
  }
  factory TimecodeOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimecodeOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimecodeOutputNodeConfig clone() => TimecodeOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimecodeOutputNodeConfig copyWith(void Function(TimecodeOutputNodeConfig) updates) => super.copyWith((message) => updates(message as TimecodeOutputNodeConfig)) as TimecodeOutputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TimecodeOutputNodeConfig create() => TimecodeOutputNodeConfig._();
  TimecodeOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<TimecodeOutputNodeConfig> createRepeated() => $pb.PbList<TimecodeOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static TimecodeOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimecodeOutputNodeConfig>(create);
  static TimecodeOutputNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get controlId => $_getIZ(0);
  @$pb.TagNumber(1)
  set controlId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasControlId() => $_has(0);
  @$pb.TagNumber(1)
  void clearControlId() => clearField(1);
}

class AudioFileNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AudioFileNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'file')
    ..e<AudioFileNodeConfig_PlaybackMode>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playbackMode', $pb.PbFieldType.OE, protoName: 'playbackMode', defaultOrMaker: AudioFileNodeConfig_PlaybackMode.ONE_SHOT, valueOf: AudioFileNodeConfig_PlaybackMode.valueOf, enumValues: AudioFileNodeConfig_PlaybackMode.values)
    ..hasRequiredFields = false
  ;

  AudioFileNodeConfig._() : super();
  factory AudioFileNodeConfig({
    $core.String? file,
    AudioFileNodeConfig_PlaybackMode? playbackMode,
  }) {
    final _result = create();
    if (file != null) {
      _result.file = file;
    }
    if (playbackMode != null) {
      _result.playbackMode = playbackMode;
    }
    return _result;
  }
  factory AudioFileNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AudioFileNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AudioFileNodeConfig clone() => AudioFileNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AudioFileNodeConfig copyWith(void Function(AudioFileNodeConfig) updates) => super.copyWith((message) => updates(message as AudioFileNodeConfig)) as AudioFileNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AudioFileNodeConfig create() => AudioFileNodeConfig._();
  AudioFileNodeConfig createEmptyInstance() => create();
  static $pb.PbList<AudioFileNodeConfig> createRepeated() => $pb.PbList<AudioFileNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static AudioFileNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AudioFileNodeConfig>(create);
  static AudioFileNodeConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get file => $_getSZ(0);
  @$pb.TagNumber(1)
  set file($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => clearField(1);

  @$pb.TagNumber(2)
  AudioFileNodeConfig_PlaybackMode get playbackMode => $_getN(1);
  @$pb.TagNumber(2)
  set playbackMode(AudioFileNodeConfig_PlaybackMode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlaybackMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlaybackMode() => clearField(2);
}

class AudioOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AudioOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AudioOutputNodeConfig._() : super();
  factory AudioOutputNodeConfig() => create();
  factory AudioOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AudioOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AudioOutputNodeConfig clone() => AudioOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AudioOutputNodeConfig copyWith(void Function(AudioOutputNodeConfig) updates) => super.copyWith((message) => updates(message as AudioOutputNodeConfig)) as AudioOutputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AudioOutputNodeConfig create() => AudioOutputNodeConfig._();
  AudioOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<AudioOutputNodeConfig> createRepeated() => $pb.PbList<AudioOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static AudioOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AudioOutputNodeConfig>(create);
  static AudioOutputNodeConfig? _defaultInstance;
}

class AudioVolumeNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AudioVolumeNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AudioVolumeNodeConfig._() : super();
  factory AudioVolumeNodeConfig() => create();
  factory AudioVolumeNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AudioVolumeNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AudioVolumeNodeConfig clone() => AudioVolumeNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AudioVolumeNodeConfig copyWith(void Function(AudioVolumeNodeConfig) updates) => super.copyWith((message) => updates(message as AudioVolumeNodeConfig)) as AudioVolumeNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AudioVolumeNodeConfig create() => AudioVolumeNodeConfig._();
  AudioVolumeNodeConfig createEmptyInstance() => create();
  static $pb.PbList<AudioVolumeNodeConfig> createRepeated() => $pb.PbList<AudioVolumeNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static AudioVolumeNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AudioVolumeNodeConfig>(create);
  static AudioVolumeNodeConfig? _defaultInstance;
}

class AudioInputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AudioInputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AudioInputNodeConfig._() : super();
  factory AudioInputNodeConfig() => create();
  factory AudioInputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AudioInputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AudioInputNodeConfig clone() => AudioInputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AudioInputNodeConfig copyWith(void Function(AudioInputNodeConfig) updates) => super.copyWith((message) => updates(message as AudioInputNodeConfig)) as AudioInputNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AudioInputNodeConfig create() => AudioInputNodeConfig._();
  AudioInputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<AudioInputNodeConfig> createRepeated() => $pb.PbList<AudioInputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static AudioInputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AudioInputNodeConfig>(create);
  static AudioInputNodeConfig? _defaultInstance;
}

class AudioMixNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AudioMixNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AudioMixNodeConfig._() : super();
  factory AudioMixNodeConfig() => create();
  factory AudioMixNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AudioMixNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AudioMixNodeConfig clone() => AudioMixNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AudioMixNodeConfig copyWith(void Function(AudioMixNodeConfig) updates) => super.copyWith((message) => updates(message as AudioMixNodeConfig)) as AudioMixNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AudioMixNodeConfig create() => AudioMixNodeConfig._();
  AudioMixNodeConfig createEmptyInstance() => create();
  static $pb.PbList<AudioMixNodeConfig> createRepeated() => $pb.PbList<AudioMixNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static AudioMixNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AudioMixNodeConfig>(create);
  static AudioMixNodeConfig? _defaultInstance;
}

class AudioMeterNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AudioMeterNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AudioMeterNodeConfig._() : super();
  factory AudioMeterNodeConfig() => create();
  factory AudioMeterNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AudioMeterNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AudioMeterNodeConfig clone() => AudioMeterNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AudioMeterNodeConfig copyWith(void Function(AudioMeterNodeConfig) updates) => super.copyWith((message) => updates(message as AudioMeterNodeConfig)) as AudioMeterNodeConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AudioMeterNodeConfig create() => AudioMeterNodeConfig._();
  AudioMeterNodeConfig createEmptyInstance() => create();
  static $pb.PbList<AudioMeterNodeConfig> createRepeated() => $pb.PbList<AudioMeterNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static AudioMeterNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AudioMeterNodeConfig>(create);
  static AudioMeterNodeConfig? _defaultInstance;
}

class NodePosition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodePosition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  NodePosition._() : super();
  factory NodePosition({
    $core.double? x,
    $core.double? y,
  }) {
    final _result = create();
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    return _result;
  }
  factory NodePosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodePosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodePosition clone() => NodePosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodePosition copyWith(void Function(NodePosition) updates) => super.copyWith((message) => updates(message as NodePosition)) as NodePosition; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodePosition create() => NodePosition._();
  NodePosition createEmptyInstance() => create();
  static $pb.PbList<NodePosition> createRepeated() => $pb.PbList<NodePosition>();
  @$core.pragma('dart2js:noInline')
  static NodePosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodePosition>(create);
  static NodePosition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);
}

class NodeDesigner extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeDesigner', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOM<NodePosition>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: NodePosition.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scale', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hidden')
    ..hasRequiredFields = false
  ;

  NodeDesigner._() : super();
  factory NodeDesigner({
    NodePosition? position,
    $core.double? scale,
    $core.bool? hidden,
  }) {
    final _result = create();
    if (position != null) {
      _result.position = position;
    }
    if (scale != null) {
      _result.scale = scale;
    }
    if (hidden != null) {
      _result.hidden = hidden;
    }
    return _result;
  }
  factory NodeDesigner.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeDesigner.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeDesigner clone() => NodeDesigner()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeDesigner copyWith(void Function(NodeDesigner) updates) => super.copyWith((message) => updates(message as NodeDesigner)) as NodeDesigner; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodeDesigner create() => NodeDesigner._();
  NodeDesigner createEmptyInstance() => create();
  static $pb.PbList<NodeDesigner> createRepeated() => $pb.PbList<NodeDesigner>();
  @$core.pragma('dart2js:noInline')
  static NodeDesigner getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeDesigner>(create);
  static NodeDesigner? _defaultInstance;

  @$pb.TagNumber(1)
  NodePosition get position => $_getN(0);
  @$pb.TagNumber(1)
  set position(NodePosition v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearPosition() => clearField(1);
  @$pb.TagNumber(1)
  NodePosition ensurePosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get scale => $_getN(1);
  @$pb.TagNumber(2)
  set scale($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScale() => $_has(1);
  @$pb.TagNumber(2)
  void clearScale() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get hidden => $_getBF(2);
  @$pb.TagNumber(3)
  set hidden($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHidden() => $_has(2);
  @$pb.TagNumber(3)
  void clearHidden() => clearField(3);
}

class Port extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Port', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<ChannelProtocol>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: ChannelProtocol.SINGLE, valueOf: ChannelProtocol.valueOf, enumValues: ChannelProtocol.values)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'multiple')
    ..hasRequiredFields = false
  ;

  Port._() : super();
  factory Port({
    $core.String? name,
    ChannelProtocol? protocol,
    $core.bool? multiple,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (protocol != null) {
      _result.protocol = protocol;
    }
    if (multiple != null) {
      _result.multiple = multiple;
    }
    return _result;
  }
  factory Port.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Port.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Port clone() => Port()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Port copyWith(void Function(Port) updates) => super.copyWith((message) => updates(message as Port)) as Port; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Port create() => Port._();
  Port createEmptyInstance() => create();
  static $pb.PbList<Port> createRepeated() => $pb.PbList<Port>();
  @$core.pragma('dart2js:noInline')
  static Port getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Port>(create);
  static Port? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  ChannelProtocol get protocol => $_getN(1);
  @$pb.TagNumber(2)
  set protocol(ChannelProtocol v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProtocol() => $_has(1);
  @$pb.TagNumber(2)
  void clearProtocol() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get multiple => $_getBF(2);
  @$pb.TagNumber(3)
  set multiple($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMultiple() => $_has(2);
  @$pb.TagNumber(3)
  void clearMultiple() => clearField(3);
}

