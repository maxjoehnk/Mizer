//
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'media.pbenum.dart' as $0;
import 'nodes.pbenum.dart';

export 'nodes.pbenum.dart';

class AddNodeRequest extends $pb.GeneratedMessage {
  factory AddNodeRequest({
    $core.String? type,
    NodePosition? position,
    $core.String? parent,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (position != null) {
      $result.position = position;
    }
    if (parent != null) {
      $result.parent = parent;
    }
    return $result;
  }
  AddNodeRequest._() : super();
  factory AddNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOM<NodePosition>(2, _omitFieldNames ? '' : 'position', subBuilder: NodePosition.create)
    ..aOS(3, _omitFieldNames ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddNodeRequest clone() => AddNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddNodeRequest copyWith(void Function(AddNodeRequest) updates) => super.copyWith((message) => updates(message as AddNodeRequest)) as AddNodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddNodeRequest create() => AddNodeRequest._();
  AddNodeRequest createEmptyInstance() => create();
  static $pb.PbList<AddNodeRequest> createRepeated() => $pb.PbList<AddNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static AddNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddNodeRequest>(create);
  static AddNodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
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
  factory DuplicateNodeRequest({
    $core.String? path,
    $core.String? parent,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (parent != null) {
      $result.parent = parent;
    }
    return $result;
  }
  DuplicateNodeRequest._() : super();
  factory DuplicateNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DuplicateNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DuplicateNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOS(2, _omitFieldNames ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DuplicateNodeRequest clone() => DuplicateNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DuplicateNodeRequest copyWith(void Function(DuplicateNodeRequest) updates) => super.copyWith((message) => updates(message as DuplicateNodeRequest)) as DuplicateNodeRequest;

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

class DisconnectPortRequest extends $pb.GeneratedMessage {
  factory DisconnectPortRequest({
    $core.String? path,
    $core.String? port,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (port != null) {
      $result.port = port;
    }
    return $result;
  }
  DisconnectPortRequest._() : super();
  factory DisconnectPortRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectPortRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectPortRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOS(2, _omitFieldNames ? '' : 'port')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectPortRequest clone() => DisconnectPortRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectPortRequest copyWith(void Function(DisconnectPortRequest) updates) => super.copyWith((message) => updates(message as DisconnectPortRequest)) as DisconnectPortRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectPortRequest create() => DisconnectPortRequest._();
  DisconnectPortRequest createEmptyInstance() => create();
  static $pb.PbList<DisconnectPortRequest> createRepeated() => $pb.PbList<DisconnectPortRequest>();
  @$core.pragma('dart2js:noInline')
  static DisconnectPortRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectPortRequest>(create);
  static DisconnectPortRequest? _defaultInstance;

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
}

class WriteControl extends $pb.GeneratedMessage {
  factory WriteControl({
    $core.String? path,
    $core.String? port,
    $core.double? value,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (port != null) {
      $result.port = port;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  WriteControl._() : super();
  factory WriteControl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteControl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WriteControl', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOS(2, _omitFieldNames ? '' : 'port')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteControl clone() => WriteControl()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteControl copyWith(void Function(WriteControl) updates) => super.copyWith((message) => updates(message as WriteControl)) as WriteControl;

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

class UpdateNodeSettingRequest extends $pb.GeneratedMessage {
  factory UpdateNodeSettingRequest({
    $core.String? path,
    NodeSetting? setting,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (setting != null) {
      $result.setting = setting;
    }
    return $result;
  }
  UpdateNodeSettingRequest._() : super();
  factory UpdateNodeSettingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNodeSettingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateNodeSettingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOM<NodeSetting>(2, _omitFieldNames ? '' : 'setting', subBuilder: NodeSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNodeSettingRequest clone() => UpdateNodeSettingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNodeSettingRequest copyWith(void Function(UpdateNodeSettingRequest) updates) => super.copyWith((message) => updates(message as UpdateNodeSettingRequest)) as UpdateNodeSettingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateNodeSettingRequest create() => UpdateNodeSettingRequest._();
  UpdateNodeSettingRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateNodeSettingRequest> createRepeated() => $pb.PbList<UpdateNodeSettingRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateNodeSettingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateNodeSettingRequest>(create);
  static UpdateNodeSettingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  NodeSetting get setting => $_getN(1);
  @$pb.TagNumber(2)
  set setting(NodeSetting v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSetting() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetting() => clearField(2);
  @$pb.TagNumber(2)
  NodeSetting ensureSetting() => $_ensure(1);
}

class MoveNodeRequest extends $pb.GeneratedMessage {
  factory MoveNodeRequest({
    $core.String? path,
    NodePosition? position,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  MoveNodeRequest._() : super();
  factory MoveNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MoveNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOM<NodePosition>(2, _omitFieldNames ? '' : 'position', subBuilder: NodePosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveNodeRequest clone() => MoveNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveNodeRequest copyWith(void Function(MoveNodeRequest) updates) => super.copyWith((message) => updates(message as MoveNodeRequest)) as MoveNodeRequest;

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

class ShowNodeRequest extends $pb.GeneratedMessage {
  factory ShowNodeRequest({
    $core.String? path,
    NodePosition? position,
    $core.String? parent,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (position != null) {
      $result.position = position;
    }
    if (parent != null) {
      $result.parent = parent;
    }
    return $result;
  }
  ShowNodeRequest._() : super();
  factory ShowNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ShowNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ShowNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOM<NodePosition>(2, _omitFieldNames ? '' : 'position', subBuilder: NodePosition.create)
    ..aOS(3, _omitFieldNames ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ShowNodeRequest clone() => ShowNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ShowNodeRequest copyWith(void Function(ShowNodeRequest) updates) => super.copyWith((message) => updates(message as ShowNodeRequest)) as ShowNodeRequest;

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

class RenameNodeRequest extends $pb.GeneratedMessage {
  factory RenameNodeRequest({
    $core.String? path,
    $core.String? newName,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    if (newName != null) {
      $result.newName = newName;
    }
    return $result;
  }
  RenameNodeRequest._() : super();
  factory RenameNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RenameNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..aOS(2, _omitFieldNames ? '' : 'newName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameNodeRequest clone() => RenameNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameNodeRequest copyWith(void Function(RenameNodeRequest) updates) => super.copyWith((message) => updates(message as RenameNodeRequest)) as RenameNodeRequest;

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

class GroupNodesRequest extends $pb.GeneratedMessage {
  factory GroupNodesRequest({
    $core.Iterable<$core.String>? nodes,
    $core.String? parent,
  }) {
    final $result = create();
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    if (parent != null) {
      $result.parent = parent;
    }
    return $result;
  }
  GroupNodesRequest._() : super();
  factory GroupNodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupNodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GroupNodesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'nodes')
    ..aOS(2, _omitFieldNames ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupNodesRequest clone() => GroupNodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupNodesRequest copyWith(void Function(GroupNodesRequest) updates) => super.copyWith((message) => updates(message as GroupNodesRequest)) as GroupNodesRequest;

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

class DeleteNodeRequest extends $pb.GeneratedMessage {
  factory DeleteNodeRequest({
    $core.String? path,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  DeleteNodeRequest._() : super();
  factory DeleteNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteNodeRequest clone() => DeleteNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteNodeRequest copyWith(void Function(DeleteNodeRequest) updates) => super.copyWith((message) => updates(message as DeleteNodeRequest)) as DeleteNodeRequest;

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

class HideNodeRequest extends $pb.GeneratedMessage {
  factory HideNodeRequest({
    $core.String? path,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  HideNodeRequest._() : super();
  factory HideNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HideNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HideNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HideNodeRequest clone() => HideNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HideNodeRequest copyWith(void Function(HideNodeRequest) updates) => super.copyWith((message) => updates(message as HideNodeRequest)) as HideNodeRequest;

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

class Nodes extends $pb.GeneratedMessage {
  factory Nodes({
    $core.Iterable<Node>? nodes,
    $core.Iterable<NodeConnection>? channels,
    $core.Iterable<Node>? allNodes,
  }) {
    final $result = create();
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    if (allNodes != null) {
      $result.allNodes.addAll(allNodes);
    }
    return $result;
  }
  Nodes._() : super();
  factory Nodes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Nodes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Nodes', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<Node>(1, _omitFieldNames ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..pc<NodeConnection>(2, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: NodeConnection.create)
    ..pc<Node>(3, _omitFieldNames ? '' : 'allNodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Nodes clone() => Nodes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Nodes copyWith(void Function(Nodes) updates) => super.copyWith((message) => updates(message as Nodes)) as Nodes;

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

  /// Flat list of all nodes
  @$pb.TagNumber(3)
  $core.List<Node> get allNodes => $_getList(2);
}

class AvailableNodes extends $pb.GeneratedMessage {
  factory AvailableNodes({
    $core.Iterable<AvailableNode>? nodes,
  }) {
    final $result = create();
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    return $result;
  }
  AvailableNodes._() : super();
  factory AvailableNodes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AvailableNodes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AvailableNodes', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<AvailableNode>(1, _omitFieldNames ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: AvailableNode.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AvailableNodes clone() => AvailableNodes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AvailableNodes copyWith(void Function(AvailableNodes) updates) => super.copyWith((message) => updates(message as AvailableNodes)) as AvailableNodes;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AvailableNodes create() => AvailableNodes._();
  AvailableNodes createEmptyInstance() => create();
  static $pb.PbList<AvailableNodes> createRepeated() => $pb.PbList<AvailableNodes>();
  @$core.pragma('dart2js:noInline')
  static AvailableNodes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AvailableNodes>(create);
  static AvailableNodes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AvailableNode> get nodes => $_getList(0);
}

class AvailableNode extends $pb.GeneratedMessage {
  factory AvailableNode({
    $core.String? type,
    $core.String? name,
    NodeCategory? category,
    $core.String? description,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (name != null) {
      $result.name = name;
    }
    if (category != null) {
      $result.category = category;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  AvailableNode._() : super();
  factory AvailableNode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AvailableNode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AvailableNode', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..e<NodeCategory>(3, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: NodeCategory.NODE_CATEGORY_NONE, valueOf: NodeCategory.valueOf, enumValues: NodeCategory.values)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AvailableNode clone() => AvailableNode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AvailableNode copyWith(void Function(AvailableNode) updates) => super.copyWith((message) => updates(message as AvailableNode)) as AvailableNode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AvailableNode create() => AvailableNode._();
  AvailableNode createEmptyInstance() => create();
  static $pb.PbList<AvailableNode> createRepeated() => $pb.PbList<AvailableNode>();
  @$core.pragma('dart2js:noInline')
  static AvailableNode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AvailableNode>(create);
  static AvailableNode? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  NodeCategory get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(NodeCategory v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);
}

class NodeConnection extends $pb.GeneratedMessage {
  factory NodeConnection({
    $core.String? targetNode,
    Port? targetPort,
    $core.String? sourceNode,
    Port? sourcePort,
    ChannelProtocol? protocol,
  }) {
    final $result = create();
    if (targetNode != null) {
      $result.targetNode = targetNode;
    }
    if (targetPort != null) {
      $result.targetPort = targetPort;
    }
    if (sourceNode != null) {
      $result.sourceNode = sourceNode;
    }
    if (sourcePort != null) {
      $result.sourcePort = sourcePort;
    }
    if (protocol != null) {
      $result.protocol = protocol;
    }
    return $result;
  }
  NodeConnection._() : super();
  factory NodeConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'targetNode')
    ..aOM<Port>(2, _omitFieldNames ? '' : 'targetPort', subBuilder: Port.create)
    ..aOS(3, _omitFieldNames ? '' : 'sourceNode')
    ..aOM<Port>(4, _omitFieldNames ? '' : 'sourcePort', subBuilder: Port.create)
    ..e<ChannelProtocol>(5, _omitFieldNames ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: ChannelProtocol.SINGLE, valueOf: ChannelProtocol.valueOf, enumValues: ChannelProtocol.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeConnection clone() => NodeConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeConnection copyWith(void Function(NodeConnection) updates) => super.copyWith((message) => updates(message as NodeConnection)) as NodeConnection;

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
  factory Node({
    $core.String? type,
    $core.String? path,
    $core.Iterable<Port>? inputs,
    $core.Iterable<Port>? outputs,
    NodeDesigner? designer,
    Node_NodePreviewType? preview,
    NodeConfig? config,
    $core.Iterable<NodeSetting>? settings,
    NodeDetails? details,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (path != null) {
      $result.path = path;
    }
    if (inputs != null) {
      $result.inputs.addAll(inputs);
    }
    if (outputs != null) {
      $result.outputs.addAll(outputs);
    }
    if (designer != null) {
      $result.designer = designer;
    }
    if (preview != null) {
      $result.preview = preview;
    }
    if (config != null) {
      $result.config = config;
    }
    if (settings != null) {
      $result.settings.addAll(settings);
    }
    if (details != null) {
      $result.details = details;
    }
    return $result;
  }
  Node._() : super();
  factory Node.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Node.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Node', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..pc<Port>(3, _omitFieldNames ? '' : 'inputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..pc<Port>(4, _omitFieldNames ? '' : 'outputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..aOM<NodeDesigner>(5, _omitFieldNames ? '' : 'designer', subBuilder: NodeDesigner.create)
    ..e<Node_NodePreviewType>(6, _omitFieldNames ? '' : 'preview', $pb.PbFieldType.OE, defaultOrMaker: Node_NodePreviewType.NONE, valueOf: Node_NodePreviewType.valueOf, enumValues: Node_NodePreviewType.values)
    ..aOM<NodeConfig>(7, _omitFieldNames ? '' : 'config', subBuilder: NodeConfig.create)
    ..pc<NodeSetting>(8, _omitFieldNames ? '' : 'settings', $pb.PbFieldType.PM, subBuilder: NodeSetting.create)
    ..aOM<NodeDetails>(9, _omitFieldNames ? '' : 'details', subBuilder: NodeDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Node clone() => Node()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Node copyWith(void Function(Node) updates) => super.copyWith((message) => updates(message as Node)) as Node;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Node create() => Node._();
  Node createEmptyInstance() => create();
  static $pb.PbList<Node> createRepeated() => $pb.PbList<Node>();
  @$core.pragma('dart2js:noInline')
  static Node getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Node>(create);
  static Node? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
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

  @$pb.TagNumber(8)
  $core.List<NodeSetting> get settings => $_getList(7);

  @$pb.TagNumber(9)
  NodeDetails get details => $_getN(8);
  @$pb.TagNumber(9)
  set details(NodeDetails v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDetails() => $_has(8);
  @$pb.TagNumber(9)
  void clearDetails() => clearField(9);
  @$pb.TagNumber(9)
  NodeDetails ensureDetails() => $_ensure(8);
}

class NodeDetails extends $pb.GeneratedMessage {
  factory NodeDetails({
    $core.String? nodeTypeName,
    $core.String? displayName,
    $core.bool? hasCustomName,
    NodeCategory? category,
  }) {
    final $result = create();
    if (nodeTypeName != null) {
      $result.nodeTypeName = nodeTypeName;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (hasCustomName != null) {
      $result.hasCustomName = hasCustomName;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  NodeDetails._() : super();
  factory NodeDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodeTypeName')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOB(3, _omitFieldNames ? '' : 'hasCustomName')
    ..e<NodeCategory>(4, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: NodeCategory.NODE_CATEGORY_NONE, valueOf: NodeCategory.valueOf, enumValues: NodeCategory.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeDetails clone() => NodeDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeDetails copyWith(void Function(NodeDetails) updates) => super.copyWith((message) => updates(message as NodeDetails)) as NodeDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeDetails create() => NodeDetails._();
  NodeDetails createEmptyInstance() => create();
  static $pb.PbList<NodeDetails> createRepeated() => $pb.PbList<NodeDetails>();
  @$core.pragma('dart2js:noInline')
  static NodeDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeDetails>(create);
  static NodeDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nodeTypeName => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeTypeName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeTypeName() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeTypeName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get hasCustomName => $_getBF(2);
  @$pb.TagNumber(3)
  set hasCustomName($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHasCustomName() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasCustomName() => clearField(3);

  @$pb.TagNumber(4)
  NodeCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category(NodeCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);
}

enum NodeConfig_Type {
  containerConfig, 
  notSet
}

class NodeConfig extends $pb.GeneratedMessage {
  factory NodeConfig({
    ContainerNodeConfig? containerConfig,
  }) {
    final $result = create();
    if (containerConfig != null) {
      $result.containerConfig = containerConfig;
    }
    return $result;
  }
  NodeConfig._() : super();
  factory NodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, NodeConfig_Type> _NodeConfig_TypeByTag = {
    45 : NodeConfig_Type.containerConfig,
    0 : NodeConfig_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..oo(0, [45])
    ..aOM<ContainerNodeConfig>(45, _omitFieldNames ? '' : 'containerConfig', subBuilder: ContainerNodeConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeConfig clone() => NodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeConfig copyWith(void Function(NodeConfig) updates) => super.copyWith((message) => updates(message as NodeConfig)) as NodeConfig;

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

  @$pb.TagNumber(45)
  ContainerNodeConfig get containerConfig => $_getN(0);
  @$pb.TagNumber(45)
  set containerConfig(ContainerNodeConfig v) { setField(45, v); }
  @$pb.TagNumber(45)
  $core.bool hasContainerConfig() => $_has(0);
  @$pb.TagNumber(45)
  void clearContainerConfig() => clearField(45);
  @$pb.TagNumber(45)
  ContainerNodeConfig ensureContainerConfig() => $_ensure(0);
}

class NodeSetting_TextValue extends $pb.GeneratedMessage {
  factory NodeSetting_TextValue({
    $core.String? value,
    $core.bool? multiline,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (multiline != null) {
      $result.multiline = multiline;
    }
    return $result;
  }
  NodeSetting_TextValue._() : super();
  factory NodeSetting_TextValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_TextValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.TextValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..aOB(2, _omitFieldNames ? '' : 'multiline')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_TextValue clone() => NodeSetting_TextValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_TextValue copyWith(void Function(NodeSetting_TextValue) updates) => super.copyWith((message) => updates(message as NodeSetting_TextValue)) as NodeSetting_TextValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_TextValue create() => NodeSetting_TextValue._();
  NodeSetting_TextValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_TextValue> createRepeated() => $pb.PbList<NodeSetting_TextValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_TextValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_TextValue>(create);
  static NodeSetting_TextValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get multiline => $_getBF(1);
  @$pb.TagNumber(2)
  set multiline($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMultiline() => $_has(1);
  @$pb.TagNumber(2)
  void clearMultiline() => clearField(2);
}

class NodeSetting_FloatValue extends $pb.GeneratedMessage {
  factory NodeSetting_FloatValue({
    $core.double? value,
    $core.double? min,
    $core.double? minHint,
    $core.double? max,
    $core.double? maxHint,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (min != null) {
      $result.min = min;
    }
    if (minHint != null) {
      $result.minHint = minHint;
    }
    if (max != null) {
      $result.max = max;
    }
    if (maxHint != null) {
      $result.maxHint = maxHint;
    }
    return $result;
  }
  NodeSetting_FloatValue._() : super();
  factory NodeSetting_FloatValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_FloatValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.FloatValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'min', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'minHint', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'max', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'maxHint', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_FloatValue clone() => NodeSetting_FloatValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_FloatValue copyWith(void Function(NodeSetting_FloatValue) updates) => super.copyWith((message) => updates(message as NodeSetting_FloatValue)) as NodeSetting_FloatValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_FloatValue create() => NodeSetting_FloatValue._();
  NodeSetting_FloatValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_FloatValue> createRepeated() => $pb.PbList<NodeSetting_FloatValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_FloatValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_FloatValue>(create);
  static NodeSetting_FloatValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get min => $_getN(1);
  @$pb.TagNumber(2)
  set min($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMin() => $_has(1);
  @$pb.TagNumber(2)
  void clearMin() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get minHint => $_getN(2);
  @$pb.TagNumber(3)
  set minHint($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinHint() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinHint() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get max => $_getN(3);
  @$pb.TagNumber(4)
  set max($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMax() => $_has(3);
  @$pb.TagNumber(4)
  void clearMax() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get maxHint => $_getN(4);
  @$pb.TagNumber(5)
  set maxHint($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaxHint() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxHint() => clearField(5);
}

class NodeSetting_IntValue extends $pb.GeneratedMessage {
  factory NodeSetting_IntValue({
    $core.int? value,
    $core.int? min,
    $core.int? minHint,
    $core.int? max,
    $core.int? maxHint,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (min != null) {
      $result.min = min;
    }
    if (minHint != null) {
      $result.minHint = minHint;
    }
    if (max != null) {
      $result.max = max;
    }
    if (maxHint != null) {
      $result.maxHint = maxHint;
    }
    return $result;
  }
  NodeSetting_IntValue._() : super();
  factory NodeSetting_IntValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_IntValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.IntValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'min', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'minHint', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'max', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'maxHint', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_IntValue clone() => NodeSetting_IntValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_IntValue copyWith(void Function(NodeSetting_IntValue) updates) => super.copyWith((message) => updates(message as NodeSetting_IntValue)) as NodeSetting_IntValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_IntValue create() => NodeSetting_IntValue._();
  NodeSetting_IntValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_IntValue> createRepeated() => $pb.PbList<NodeSetting_IntValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_IntValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_IntValue>(create);
  static NodeSetting_IntValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get min => $_getIZ(1);
  @$pb.TagNumber(2)
  set min($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMin() => $_has(1);
  @$pb.TagNumber(2)
  void clearMin() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get minHint => $_getIZ(2);
  @$pb.TagNumber(3)
  set minHint($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinHint() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinHint() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get max => $_getIZ(3);
  @$pb.TagNumber(4)
  set max($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMax() => $_has(3);
  @$pb.TagNumber(4)
  void clearMax() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get maxHint => $_getIZ(4);
  @$pb.TagNumber(5)
  set maxHint($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaxHint() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxHint() => clearField(5);
}

class NodeSetting_UintValue extends $pb.GeneratedMessage {
  factory NodeSetting_UintValue({
    $core.int? value,
    $core.int? min,
    $core.int? minHint,
    $core.int? max,
    $core.int? maxHint,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (min != null) {
      $result.min = min;
    }
    if (minHint != null) {
      $result.minHint = minHint;
    }
    if (max != null) {
      $result.max = max;
    }
    if (maxHint != null) {
      $result.maxHint = maxHint;
    }
    return $result;
  }
  NodeSetting_UintValue._() : super();
  factory NodeSetting_UintValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_UintValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.UintValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'min', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'minHint', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'max', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'maxHint', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_UintValue clone() => NodeSetting_UintValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_UintValue copyWith(void Function(NodeSetting_UintValue) updates) => super.copyWith((message) => updates(message as NodeSetting_UintValue)) as NodeSetting_UintValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_UintValue create() => NodeSetting_UintValue._();
  NodeSetting_UintValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_UintValue> createRepeated() => $pb.PbList<NodeSetting_UintValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_UintValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_UintValue>(create);
  static NodeSetting_UintValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get min => $_getIZ(1);
  @$pb.TagNumber(2)
  set min($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMin() => $_has(1);
  @$pb.TagNumber(2)
  void clearMin() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get minHint => $_getIZ(2);
  @$pb.TagNumber(3)
  set minHint($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinHint() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinHint() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get max => $_getIZ(3);
  @$pb.TagNumber(4)
  set max($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMax() => $_has(3);
  @$pb.TagNumber(4)
  void clearMax() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get maxHint => $_getIZ(4);
  @$pb.TagNumber(5)
  set maxHint($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaxHint() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxHint() => clearField(5);
}

class NodeSetting_BoolValue extends $pb.GeneratedMessage {
  factory NodeSetting_BoolValue({
    $core.bool? value,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  NodeSetting_BoolValue._() : super();
  factory NodeSetting_BoolValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_BoolValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.BoolValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_BoolValue clone() => NodeSetting_BoolValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_BoolValue copyWith(void Function(NodeSetting_BoolValue) updates) => super.copyWith((message) => updates(message as NodeSetting_BoolValue)) as NodeSetting_BoolValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_BoolValue create() => NodeSetting_BoolValue._();
  NodeSetting_BoolValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_BoolValue> createRepeated() => $pb.PbList<NodeSetting_BoolValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_BoolValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_BoolValue>(create);
  static NodeSetting_BoolValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get value => $_getBF(0);
  @$pb.TagNumber(1)
  set value($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class NodeSetting_SelectValue extends $pb.GeneratedMessage {
  factory NodeSetting_SelectValue({
    $core.String? value,
    $core.Iterable<NodeSetting_SelectVariant>? variants,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (variants != null) {
      $result.variants.addAll(variants);
    }
    return $result;
  }
  NodeSetting_SelectValue._() : super();
  factory NodeSetting_SelectValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SelectValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.SelectValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..pc<NodeSetting_SelectVariant>(2, _omitFieldNames ? '' : 'variants', $pb.PbFieldType.PM, subBuilder: NodeSetting_SelectVariant.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectValue clone() => NodeSetting_SelectValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectValue copyWith(void Function(NodeSetting_SelectValue) updates) => super.copyWith((message) => updates(message as NodeSetting_SelectValue)) as NodeSetting_SelectValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_SelectValue create() => NodeSetting_SelectValue._();
  NodeSetting_SelectValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_SelectValue> createRepeated() => $pb.PbList<NodeSetting_SelectValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_SelectValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_SelectValue>(create);
  static NodeSetting_SelectValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<NodeSetting_SelectVariant> get variants => $_getList(1);
}

class NodeSetting_SelectVariant_SelectGroup extends $pb.GeneratedMessage {
  factory NodeSetting_SelectVariant_SelectGroup({
    $core.String? label,
    $core.Iterable<NodeSetting_SelectVariant>? items,
  }) {
    final $result = create();
    if (label != null) {
      $result.label = label;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  NodeSetting_SelectVariant_SelectGroup._() : super();
  factory NodeSetting_SelectVariant_SelectGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SelectVariant_SelectGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.SelectVariant.SelectGroup', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..pc<NodeSetting_SelectVariant>(2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: NodeSetting_SelectVariant.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant_SelectGroup clone() => NodeSetting_SelectVariant_SelectGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant_SelectGroup copyWith(void Function(NodeSetting_SelectVariant_SelectGroup) updates) => super.copyWith((message) => updates(message as NodeSetting_SelectVariant_SelectGroup)) as NodeSetting_SelectVariant_SelectGroup;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_SelectVariant_SelectGroup create() => NodeSetting_SelectVariant_SelectGroup._();
  NodeSetting_SelectVariant_SelectGroup createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_SelectVariant_SelectGroup> createRepeated() => $pb.PbList<NodeSetting_SelectVariant_SelectGroup>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_SelectVariant_SelectGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_SelectVariant_SelectGroup>(create);
  static NodeSetting_SelectVariant_SelectGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<NodeSetting_SelectVariant> get items => $_getList(1);
}

class NodeSetting_SelectVariant_SelectItem extends $pb.GeneratedMessage {
  factory NodeSetting_SelectVariant_SelectItem({
    $core.String? value,
    $core.String? label,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (label != null) {
      $result.label = label;
    }
    return $result;
  }
  NodeSetting_SelectVariant_SelectItem._() : super();
  factory NodeSetting_SelectVariant_SelectItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SelectVariant_SelectItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.SelectVariant.SelectItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant_SelectItem clone() => NodeSetting_SelectVariant_SelectItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant_SelectItem copyWith(void Function(NodeSetting_SelectVariant_SelectItem) updates) => super.copyWith((message) => updates(message as NodeSetting_SelectVariant_SelectItem)) as NodeSetting_SelectVariant_SelectItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_SelectVariant_SelectItem create() => NodeSetting_SelectVariant_SelectItem._();
  NodeSetting_SelectVariant_SelectItem createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_SelectVariant_SelectItem> createRepeated() => $pb.PbList<NodeSetting_SelectVariant_SelectItem>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_SelectVariant_SelectItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_SelectVariant_SelectItem>(create);
  static NodeSetting_SelectVariant_SelectItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);
}

enum NodeSetting_SelectVariant_Variant {
  group, 
  item, 
  notSet
}

class NodeSetting_SelectVariant extends $pb.GeneratedMessage {
  factory NodeSetting_SelectVariant({
    NodeSetting_SelectVariant_SelectGroup? group,
    NodeSetting_SelectVariant_SelectItem? item,
  }) {
    final $result = create();
    if (group != null) {
      $result.group = group;
    }
    if (item != null) {
      $result.item = item;
    }
    return $result;
  }
  NodeSetting_SelectVariant._() : super();
  factory NodeSetting_SelectVariant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SelectVariant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, NodeSetting_SelectVariant_Variant> _NodeSetting_SelectVariant_VariantByTag = {
    1 : NodeSetting_SelectVariant_Variant.group,
    2 : NodeSetting_SelectVariant_Variant.item,
    0 : NodeSetting_SelectVariant_Variant.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.SelectVariant', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<NodeSetting_SelectVariant_SelectGroup>(1, _omitFieldNames ? '' : 'group', subBuilder: NodeSetting_SelectVariant_SelectGroup.create)
    ..aOM<NodeSetting_SelectVariant_SelectItem>(2, _omitFieldNames ? '' : 'item', subBuilder: NodeSetting_SelectVariant_SelectItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant clone() => NodeSetting_SelectVariant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant copyWith(void Function(NodeSetting_SelectVariant) updates) => super.copyWith((message) => updates(message as NodeSetting_SelectVariant)) as NodeSetting_SelectVariant;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_SelectVariant create() => NodeSetting_SelectVariant._();
  NodeSetting_SelectVariant createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_SelectVariant> createRepeated() => $pb.PbList<NodeSetting_SelectVariant>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_SelectVariant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_SelectVariant>(create);
  static NodeSetting_SelectVariant? _defaultInstance;

  NodeSetting_SelectVariant_Variant whichVariant() => _NodeSetting_SelectVariant_VariantByTag[$_whichOneof(0)]!;
  void clearVariant() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  NodeSetting_SelectVariant_SelectGroup get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(NodeSetting_SelectVariant_SelectGroup v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => clearField(1);
  @$pb.TagNumber(1)
  NodeSetting_SelectVariant_SelectGroup ensureGroup() => $_ensure(0);

  @$pb.TagNumber(2)
  NodeSetting_SelectVariant_SelectItem get item => $_getN(1);
  @$pb.TagNumber(2)
  set item(NodeSetting_SelectVariant_SelectItem v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasItem() => $_has(1);
  @$pb.TagNumber(2)
  void clearItem() => clearField(2);
  @$pb.TagNumber(2)
  NodeSetting_SelectVariant_SelectItem ensureItem() => $_ensure(1);
}

class NodeSetting_EnumValue extends $pb.GeneratedMessage {
  factory NodeSetting_EnumValue({
    $core.int? value,
    $core.Iterable<NodeSetting_EnumVariant>? variants,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (variants != null) {
      $result.variants.addAll(variants);
    }
    return $result;
  }
  NodeSetting_EnumValue._() : super();
  factory NodeSetting_EnumValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_EnumValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.EnumValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OU3)
    ..pc<NodeSetting_EnumVariant>(2, _omitFieldNames ? '' : 'variants', $pb.PbFieldType.PM, subBuilder: NodeSetting_EnumVariant.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_EnumValue clone() => NodeSetting_EnumValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_EnumValue copyWith(void Function(NodeSetting_EnumValue) updates) => super.copyWith((message) => updates(message as NodeSetting_EnumValue)) as NodeSetting_EnumValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_EnumValue create() => NodeSetting_EnumValue._();
  NodeSetting_EnumValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_EnumValue> createRepeated() => $pb.PbList<NodeSetting_EnumValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_EnumValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_EnumValue>(create);
  static NodeSetting_EnumValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<NodeSetting_EnumVariant> get variants => $_getList(1);
}

class NodeSetting_EnumVariant extends $pb.GeneratedMessage {
  factory NodeSetting_EnumVariant({
    $core.int? value,
    $core.String? label,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (label != null) {
      $result.label = label;
    }
    return $result;
  }
  NodeSetting_EnumVariant._() : super();
  factory NodeSetting_EnumVariant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_EnumVariant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.EnumVariant', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_EnumVariant clone() => NodeSetting_EnumVariant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_EnumVariant copyWith(void Function(NodeSetting_EnumVariant) updates) => super.copyWith((message) => updates(message as NodeSetting_EnumVariant)) as NodeSetting_EnumVariant;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_EnumVariant create() => NodeSetting_EnumVariant._();
  NodeSetting_EnumVariant createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_EnumVariant> createRepeated() => $pb.PbList<NodeSetting_EnumVariant>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_EnumVariant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_EnumVariant>(create);
  static NodeSetting_EnumVariant? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);
}

class NodeSetting_IdValue extends $pb.GeneratedMessage {
  factory NodeSetting_IdValue({
    $core.int? value,
    $core.Iterable<NodeSetting_IdVariant>? variants,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (variants != null) {
      $result.variants.addAll(variants);
    }
    return $result;
  }
  NodeSetting_IdValue._() : super();
  factory NodeSetting_IdValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_IdValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.IdValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OU3)
    ..pc<NodeSetting_IdVariant>(2, _omitFieldNames ? '' : 'variants', $pb.PbFieldType.PM, subBuilder: NodeSetting_IdVariant.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_IdValue clone() => NodeSetting_IdValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_IdValue copyWith(void Function(NodeSetting_IdValue) updates) => super.copyWith((message) => updates(message as NodeSetting_IdValue)) as NodeSetting_IdValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_IdValue create() => NodeSetting_IdValue._();
  NodeSetting_IdValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_IdValue> createRepeated() => $pb.PbList<NodeSetting_IdValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_IdValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_IdValue>(create);
  static NodeSetting_IdValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<NodeSetting_IdVariant> get variants => $_getList(1);
}

class NodeSetting_IdVariant extends $pb.GeneratedMessage {
  factory NodeSetting_IdVariant({
    $core.int? value,
    $core.String? label,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (label != null) {
      $result.label = label;
    }
    return $result;
  }
  NodeSetting_IdVariant._() : super();
  factory NodeSetting_IdVariant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_IdVariant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.IdVariant', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_IdVariant clone() => NodeSetting_IdVariant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_IdVariant copyWith(void Function(NodeSetting_IdVariant) updates) => super.copyWith((message) => updates(message as NodeSetting_IdVariant)) as NodeSetting_IdVariant;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_IdVariant create() => NodeSetting_IdVariant._();
  NodeSetting_IdVariant createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_IdVariant> createRepeated() => $pb.PbList<NodeSetting_IdVariant>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_IdVariant getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_IdVariant>(create);
  static NodeSetting_IdVariant? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);
}

class NodeSetting_SplineValue_SplineStep extends $pb.GeneratedMessage {
  factory NodeSetting_SplineValue_SplineStep({
    $core.double? x,
    $core.double? y,
    $core.double? c0a,
    $core.double? c0b,
    $core.double? c1a,
    $core.double? c1b,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    if (c0a != null) {
      $result.c0a = c0a;
    }
    if (c0b != null) {
      $result.c0b = c0b;
    }
    if (c1a != null) {
      $result.c1a = c1a;
    }
    if (c1b != null) {
      $result.c1b = c1b;
    }
    return $result;
  }
  NodeSetting_SplineValue_SplineStep._() : super();
  factory NodeSetting_SplineValue_SplineStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SplineValue_SplineStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.SplineValue.SplineStep', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'c0b', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'c1a', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'c1b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SplineValue_SplineStep clone() => NodeSetting_SplineValue_SplineStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SplineValue_SplineStep copyWith(void Function(NodeSetting_SplineValue_SplineStep) updates) => super.copyWith((message) => updates(message as NodeSetting_SplineValue_SplineStep)) as NodeSetting_SplineValue_SplineStep;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_SplineValue_SplineStep create() => NodeSetting_SplineValue_SplineStep._();
  NodeSetting_SplineValue_SplineStep createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_SplineValue_SplineStep> createRepeated() => $pb.PbList<NodeSetting_SplineValue_SplineStep>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_SplineValue_SplineStep getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_SplineValue_SplineStep>(create);
  static NodeSetting_SplineValue_SplineStep? _defaultInstance;

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

class NodeSetting_SplineValue extends $pb.GeneratedMessage {
  factory NodeSetting_SplineValue({
    $core.Iterable<NodeSetting_SplineValue_SplineStep>? steps,
  }) {
    final $result = create();
    if (steps != null) {
      $result.steps.addAll(steps);
    }
    return $result;
  }
  NodeSetting_SplineValue._() : super();
  factory NodeSetting_SplineValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SplineValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.SplineValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<NodeSetting_SplineValue_SplineStep>(1, _omitFieldNames ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: NodeSetting_SplineValue_SplineStep.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SplineValue clone() => NodeSetting_SplineValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SplineValue copyWith(void Function(NodeSetting_SplineValue) updates) => super.copyWith((message) => updates(message as NodeSetting_SplineValue)) as NodeSetting_SplineValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_SplineValue create() => NodeSetting_SplineValue._();
  NodeSetting_SplineValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_SplineValue> createRepeated() => $pb.PbList<NodeSetting_SplineValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_SplineValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_SplineValue>(create);
  static NodeSetting_SplineValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<NodeSetting_SplineValue_SplineStep> get steps => $_getList(0);
}

class NodeSetting_MediaValue extends $pb.GeneratedMessage {
  factory NodeSetting_MediaValue({
    $core.String? value,
    $core.Iterable<$0.MediaType>? allowedTypes,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (allowedTypes != null) {
      $result.allowedTypes.addAll(allowedTypes);
    }
    return $result;
  }
  NodeSetting_MediaValue._() : super();
  factory NodeSetting_MediaValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_MediaValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.MediaValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..pc<$0.MediaType>(2, _omitFieldNames ? '' : 'allowedTypes', $pb.PbFieldType.KE, valueOf: $0.MediaType.valueOf, enumValues: $0.MediaType.values, defaultEnumValue: $0.MediaType.IMAGE)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_MediaValue clone() => NodeSetting_MediaValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_MediaValue copyWith(void Function(NodeSetting_MediaValue) updates) => super.copyWith((message) => updates(message as NodeSetting_MediaValue)) as NodeSetting_MediaValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_MediaValue create() => NodeSetting_MediaValue._();
  NodeSetting_MediaValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_MediaValue> createRepeated() => $pb.PbList<NodeSetting_MediaValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_MediaValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_MediaValue>(create);
  static NodeSetting_MediaValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$0.MediaType> get allowedTypes => $_getList(1);
}

class NodeSetting_StepSequencerValue extends $pb.GeneratedMessage {
  factory NodeSetting_StepSequencerValue({
    $core.Iterable<$core.bool>? steps,
  }) {
    final $result = create();
    if (steps != null) {
      $result.steps.addAll(steps);
    }
    return $result;
  }
  NodeSetting_StepSequencerValue._() : super();
  factory NodeSetting_StepSequencerValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_StepSequencerValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting.StepSequencerValue', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..p<$core.bool>(1, _omitFieldNames ? '' : 'steps', $pb.PbFieldType.KB)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_StepSequencerValue clone() => NodeSetting_StepSequencerValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_StepSequencerValue copyWith(void Function(NodeSetting_StepSequencerValue) updates) => super.copyWith((message) => updates(message as NodeSetting_StepSequencerValue)) as NodeSetting_StepSequencerValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting_StepSequencerValue create() => NodeSetting_StepSequencerValue._();
  NodeSetting_StepSequencerValue createEmptyInstance() => create();
  static $pb.PbList<NodeSetting_StepSequencerValue> createRepeated() => $pb.PbList<NodeSetting_StepSequencerValue>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting_StepSequencerValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting_StepSequencerValue>(create);
  static NodeSetting_StepSequencerValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.bool> get steps => $_getList(0);
}

enum NodeSetting_Value {
  text, 
  float, 
  int_6, 
  bool_7, 
  select, 
  enum_9, 
  id, 
  spline, 
  media, 
  uint, 
  stepSequencer, 
  notSet
}

class NodeSetting extends $pb.GeneratedMessage {
  factory NodeSetting({
    $core.String? label,
    $core.String? description,
    $core.bool? disabled,
    NodeSetting_TextValue? text,
    NodeSetting_FloatValue? float,
    NodeSetting_IntValue? int_6,
    NodeSetting_BoolValue? bool_7,
    NodeSetting_SelectValue? select,
    NodeSetting_EnumValue? enum_9,
    NodeSetting_IdValue? id,
    NodeSetting_SplineValue? spline,
    NodeSetting_MediaValue? media,
    NodeSetting_UintValue? uint,
    NodeSetting_StepSequencerValue? stepSequencer,
  }) {
    final $result = create();
    if (label != null) {
      $result.label = label;
    }
    if (description != null) {
      $result.description = description;
    }
    if (disabled != null) {
      $result.disabled = disabled;
    }
    if (text != null) {
      $result.text = text;
    }
    if (float != null) {
      $result.float = float;
    }
    if (int_6 != null) {
      $result.int_6 = int_6;
    }
    if (bool_7 != null) {
      $result.bool_7 = bool_7;
    }
    if (select != null) {
      $result.select = select;
    }
    if (enum_9 != null) {
      $result.enum_9 = enum_9;
    }
    if (id != null) {
      $result.id = id;
    }
    if (spline != null) {
      $result.spline = spline;
    }
    if (media != null) {
      $result.media = media;
    }
    if (uint != null) {
      $result.uint = uint;
    }
    if (stepSequencer != null) {
      $result.stepSequencer = stepSequencer;
    }
    return $result;
  }
  NodeSetting._() : super();
  factory NodeSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, NodeSetting_Value> _NodeSetting_ValueByTag = {
    4 : NodeSetting_Value.text,
    5 : NodeSetting_Value.float,
    6 : NodeSetting_Value.int_6,
    7 : NodeSetting_Value.bool_7,
    8 : NodeSetting_Value.select,
    9 : NodeSetting_Value.enum_9,
    10 : NodeSetting_Value.id,
    11 : NodeSetting_Value.spline,
    12 : NodeSetting_Value.media,
    13 : NodeSetting_Value.uint,
    14 : NodeSetting_Value.stepSequencer,
    0 : NodeSetting_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeSetting', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOB(3, _omitFieldNames ? '' : 'disabled')
    ..aOM<NodeSetting_TextValue>(4, _omitFieldNames ? '' : 'text', subBuilder: NodeSetting_TextValue.create)
    ..aOM<NodeSetting_FloatValue>(5, _omitFieldNames ? '' : 'float', subBuilder: NodeSetting_FloatValue.create)
    ..aOM<NodeSetting_IntValue>(6, _omitFieldNames ? '' : 'int', subBuilder: NodeSetting_IntValue.create)
    ..aOM<NodeSetting_BoolValue>(7, _omitFieldNames ? '' : 'bool', subBuilder: NodeSetting_BoolValue.create)
    ..aOM<NodeSetting_SelectValue>(8, _omitFieldNames ? '' : 'select', subBuilder: NodeSetting_SelectValue.create)
    ..aOM<NodeSetting_EnumValue>(9, _omitFieldNames ? '' : 'enum', subBuilder: NodeSetting_EnumValue.create)
    ..aOM<NodeSetting_IdValue>(10, _omitFieldNames ? '' : 'id', subBuilder: NodeSetting_IdValue.create)
    ..aOM<NodeSetting_SplineValue>(11, _omitFieldNames ? '' : 'spline', subBuilder: NodeSetting_SplineValue.create)
    ..aOM<NodeSetting_MediaValue>(12, _omitFieldNames ? '' : 'media', subBuilder: NodeSetting_MediaValue.create)
    ..aOM<NodeSetting_UintValue>(13, _omitFieldNames ? '' : 'uint', subBuilder: NodeSetting_UintValue.create)
    ..aOM<NodeSetting_StepSequencerValue>(14, _omitFieldNames ? '' : 'stepSequencer', subBuilder: NodeSetting_StepSequencerValue.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting clone() => NodeSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting copyWith(void Function(NodeSetting) updates) => super.copyWith((message) => updates(message as NodeSetting)) as NodeSetting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeSetting create() => NodeSetting._();
  NodeSetting createEmptyInstance() => create();
  static $pb.PbList<NodeSetting> createRepeated() => $pb.PbList<NodeSetting>();
  @$core.pragma('dart2js:noInline')
  static NodeSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSetting>(create);
  static NodeSetting? _defaultInstance;

  NodeSetting_Value whichValue() => _NodeSetting_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get disabled => $_getBF(2);
  @$pb.TagNumber(3)
  set disabled($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisabled() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisabled() => clearField(3);

  @$pb.TagNumber(4)
  NodeSetting_TextValue get text => $_getN(3);
  @$pb.TagNumber(4)
  set text(NodeSetting_TextValue v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasText() => $_has(3);
  @$pb.TagNumber(4)
  void clearText() => clearField(4);
  @$pb.TagNumber(4)
  NodeSetting_TextValue ensureText() => $_ensure(3);

  @$pb.TagNumber(5)
  NodeSetting_FloatValue get float => $_getN(4);
  @$pb.TagNumber(5)
  set float(NodeSetting_FloatValue v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFloat() => $_has(4);
  @$pb.TagNumber(5)
  void clearFloat() => clearField(5);
  @$pb.TagNumber(5)
  NodeSetting_FloatValue ensureFloat() => $_ensure(4);

  @$pb.TagNumber(6)
  NodeSetting_IntValue get int_6 => $_getN(5);
  @$pb.TagNumber(6)
  set int_6(NodeSetting_IntValue v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasInt_6() => $_has(5);
  @$pb.TagNumber(6)
  void clearInt_6() => clearField(6);
  @$pb.TagNumber(6)
  NodeSetting_IntValue ensureInt_6() => $_ensure(5);

  @$pb.TagNumber(7)
  NodeSetting_BoolValue get bool_7 => $_getN(6);
  @$pb.TagNumber(7)
  set bool_7(NodeSetting_BoolValue v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasBool_7() => $_has(6);
  @$pb.TagNumber(7)
  void clearBool_7() => clearField(7);
  @$pb.TagNumber(7)
  NodeSetting_BoolValue ensureBool_7() => $_ensure(6);

  @$pb.TagNumber(8)
  NodeSetting_SelectValue get select => $_getN(7);
  @$pb.TagNumber(8)
  set select(NodeSetting_SelectValue v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasSelect() => $_has(7);
  @$pb.TagNumber(8)
  void clearSelect() => clearField(8);
  @$pb.TagNumber(8)
  NodeSetting_SelectValue ensureSelect() => $_ensure(7);

  @$pb.TagNumber(9)
  NodeSetting_EnumValue get enum_9 => $_getN(8);
  @$pb.TagNumber(9)
  set enum_9(NodeSetting_EnumValue v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasEnum_9() => $_has(8);
  @$pb.TagNumber(9)
  void clearEnum_9() => clearField(9);
  @$pb.TagNumber(9)
  NodeSetting_EnumValue ensureEnum_9() => $_ensure(8);

  @$pb.TagNumber(10)
  NodeSetting_IdValue get id => $_getN(9);
  @$pb.TagNumber(10)
  set id(NodeSetting_IdValue v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasId() => $_has(9);
  @$pb.TagNumber(10)
  void clearId() => clearField(10);
  @$pb.TagNumber(10)
  NodeSetting_IdValue ensureId() => $_ensure(9);

  @$pb.TagNumber(11)
  NodeSetting_SplineValue get spline => $_getN(10);
  @$pb.TagNumber(11)
  set spline(NodeSetting_SplineValue v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasSpline() => $_has(10);
  @$pb.TagNumber(11)
  void clearSpline() => clearField(11);
  @$pb.TagNumber(11)
  NodeSetting_SplineValue ensureSpline() => $_ensure(10);

  @$pb.TagNumber(12)
  NodeSetting_MediaValue get media => $_getN(11);
  @$pb.TagNumber(12)
  set media(NodeSetting_MediaValue v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasMedia() => $_has(11);
  @$pb.TagNumber(12)
  void clearMedia() => clearField(12);
  @$pb.TagNumber(12)
  NodeSetting_MediaValue ensureMedia() => $_ensure(11);

  @$pb.TagNumber(13)
  NodeSetting_UintValue get uint => $_getN(12);
  @$pb.TagNumber(13)
  set uint(NodeSetting_UintValue v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasUint() => $_has(12);
  @$pb.TagNumber(13)
  void clearUint() => clearField(13);
  @$pb.TagNumber(13)
  NodeSetting_UintValue ensureUint() => $_ensure(12);

  @$pb.TagNumber(14)
  NodeSetting_StepSequencerValue get stepSequencer => $_getN(13);
  @$pb.TagNumber(14)
  set stepSequencer(NodeSetting_StepSequencerValue v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasStepSequencer() => $_has(13);
  @$pb.TagNumber(14)
  void clearStepSequencer() => clearField(14);
  @$pb.TagNumber(14)
  NodeSetting_StepSequencerValue ensureStepSequencer() => $_ensure(13);
}

class MidiNodeConfig_NoteBinding extends $pb.GeneratedMessage {
  factory MidiNodeConfig_NoteBinding({
    $core.int? channel,
    MidiNodeConfig_NoteBinding_MidiType? type,
    $core.int? port,
    $core.int? rangeFrom,
    $core.int? rangeTo,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (type != null) {
      $result.type = type;
    }
    if (port != null) {
      $result.port = port;
    }
    if (rangeFrom != null) {
      $result.rangeFrom = rangeFrom;
    }
    if (rangeTo != null) {
      $result.rangeTo = rangeTo;
    }
    return $result;
  }
  MidiNodeConfig_NoteBinding._() : super();
  factory MidiNodeConfig_NoteBinding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiNodeConfig_NoteBinding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiNodeConfig.NoteBinding', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'channel', $pb.PbFieldType.OU3)
    ..e<MidiNodeConfig_NoteBinding_MidiType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MidiNodeConfig_NoteBinding_MidiType.CC, valueOf: MidiNodeConfig_NoteBinding_MidiType.valueOf, enumValues: MidiNodeConfig_NoteBinding_MidiType.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'port', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'rangeFrom', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'rangeTo', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiNodeConfig_NoteBinding clone() => MidiNodeConfig_NoteBinding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiNodeConfig_NoteBinding copyWith(void Function(MidiNodeConfig_NoteBinding) updates) => super.copyWith((message) => updates(message as MidiNodeConfig_NoteBinding)) as MidiNodeConfig_NoteBinding;

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
  factory MidiNodeConfig_ControlBinding({
    $core.String? page,
    $core.String? control,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (control != null) {
      $result.control = control;
    }
    return $result;
  }
  MidiNodeConfig_ControlBinding._() : super();
  factory MidiNodeConfig_ControlBinding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiNodeConfig_ControlBinding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiNodeConfig.ControlBinding', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'page')
    ..aOS(2, _omitFieldNames ? '' : 'control')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiNodeConfig_ControlBinding clone() => MidiNodeConfig_ControlBinding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiNodeConfig_ControlBinding copyWith(void Function(MidiNodeConfig_ControlBinding) updates) => super.copyWith((message) => updates(message as MidiNodeConfig_ControlBinding)) as MidiNodeConfig_ControlBinding;

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
  factory MidiNodeConfig({
    $core.String? device,
    MidiNodeConfig_NoteBinding? noteBinding,
    MidiNodeConfig_ControlBinding? controlBinding,
  }) {
    final $result = create();
    if (device != null) {
      $result.device = device;
    }
    if (noteBinding != null) {
      $result.noteBinding = noteBinding;
    }
    if (controlBinding != null) {
      $result.controlBinding = controlBinding;
    }
    return $result;
  }
  MidiNodeConfig._() : super();
  factory MidiNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, MidiNodeConfig_Binding> _MidiNodeConfig_BindingByTag = {
    2 : MidiNodeConfig_Binding.noteBinding,
    3 : MidiNodeConfig_Binding.controlBinding,
    0 : MidiNodeConfig_Binding.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MidiNodeConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'device')
    ..aOM<MidiNodeConfig_NoteBinding>(2, _omitFieldNames ? '' : 'noteBinding', subBuilder: MidiNodeConfig_NoteBinding.create)
    ..aOM<MidiNodeConfig_ControlBinding>(3, _omitFieldNames ? '' : 'controlBinding', subBuilder: MidiNodeConfig_ControlBinding.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiNodeConfig clone() => MidiNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiNodeConfig copyWith(void Function(MidiNodeConfig) updates) => super.copyWith((message) => updates(message as MidiNodeConfig)) as MidiNodeConfig;

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

class ContainerNodeConfig extends $pb.GeneratedMessage {
  factory ContainerNodeConfig({
    $core.Iterable<Node>? nodes,
  }) {
    final $result = create();
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    return $result;
  }
  ContainerNodeConfig._() : super();
  factory ContainerNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContainerNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContainerNodeConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<Node>(1, _omitFieldNames ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContainerNodeConfig clone() => ContainerNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContainerNodeConfig copyWith(void Function(ContainerNodeConfig) updates) => super.copyWith((message) => updates(message as ContainerNodeConfig)) as ContainerNodeConfig;

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

class NodePosition extends $pb.GeneratedMessage {
  factory NodePosition({
    $core.double? x,
    $core.double? y,
  }) {
    final $result = create();
    if (x != null) {
      $result.x = x;
    }
    if (y != null) {
      $result.y = y;
    }
    return $result;
  }
  NodePosition._() : super();
  factory NodePosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodePosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodePosition', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodePosition clone() => NodePosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodePosition copyWith(void Function(NodePosition) updates) => super.copyWith((message) => updates(message as NodePosition)) as NodePosition;

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
  factory NodeDesigner({
    NodePosition? position,
    $core.double? scale,
    $core.bool? hidden,
  }) {
    final $result = create();
    if (position != null) {
      $result.position = position;
    }
    if (scale != null) {
      $result.scale = scale;
    }
    if (hidden != null) {
      $result.hidden = hidden;
    }
    return $result;
  }
  NodeDesigner._() : super();
  factory NodeDesigner.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeDesigner.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeDesigner', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOM<NodePosition>(1, _omitFieldNames ? '' : 'position', subBuilder: NodePosition.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'scale', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'hidden')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeDesigner clone() => NodeDesigner()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeDesigner copyWith(void Function(NodeDesigner) updates) => super.copyWith((message) => updates(message as NodeDesigner)) as NodeDesigner;

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
  factory Port({
    $core.String? name,
    ChannelProtocol? protocol,
    $core.bool? multiple,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (protocol != null) {
      $result.protocol = protocol;
    }
    if (multiple != null) {
      $result.multiple = multiple;
    }
    return $result;
  }
  Port._() : super();
  factory Port.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Port.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Port', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<ChannelProtocol>(2, _omitFieldNames ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: ChannelProtocol.SINGLE, valueOf: ChannelProtocol.valueOf, enumValues: ChannelProtocol.values)
    ..aOB(3, _omitFieldNames ? '' : 'multiple')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Port clone() => Port()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Port copyWith(void Function(Port) updates) => super.copyWith((message) => updates(message as Port)) as Port;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
