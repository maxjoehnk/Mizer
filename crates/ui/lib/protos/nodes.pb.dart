///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'nodes.pbenum.dart';
import 'media.pbenum.dart' as $0;

export 'nodes.pbenum.dart';

class AddNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOM<NodePosition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: NodePosition.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parent')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'template')
    ..hasRequiredFields = false
  ;

  AddNodeRequest._() : super();
  factory AddNodeRequest({
    $core.String? type,
    NodePosition? position,
    $core.String? parent,
    $core.String? template,
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
    if (template != null) {
      _result.template = template;
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

  @$pb.TagNumber(4)
  $core.String get template => $_getSZ(3);
  @$pb.TagNumber(4)
  set template($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTemplate() => $_has(3);
  @$pb.TagNumber(4)
  void clearTemplate() => clearField(4);
}

class AddCommentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddCommentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOM<NodePosition>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: NodePosition.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  AddCommentRequest._() : super();
  factory AddCommentRequest({
    NodePosition? position,
    $core.double? width,
    $core.double? height,
    $core.String? parent,
  }) {
    final _result = create();
    if (position != null) {
      _result.position = position;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (parent != null) {
      _result.parent = parent;
    }
    return _result;
  }
  factory AddCommentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddCommentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddCommentRequest clone() => AddCommentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddCommentRequest copyWith(void Function(AddCommentRequest) updates) => super.copyWith((message) => updates(message as AddCommentRequest)) as AddCommentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddCommentRequest create() => AddCommentRequest._();
  AddCommentRequest createEmptyInstance() => create();
  static $pb.PbList<AddCommentRequest> createRepeated() => $pb.PbList<AddCommentRequest>();
  @$core.pragma('dart2js:noInline')
  static AddCommentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddCommentRequest>(create);
  static AddCommentRequest? _defaultInstance;

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
  $core.double get width => $_getN(1);
  @$pb.TagNumber(2)
  set width($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearWidth() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get height => $_getN(2);
  @$pb.TagNumber(3)
  set height($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeight() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get parent => $_getSZ(3);
  @$pb.TagNumber(4)
  set parent($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasParent() => $_has(3);
  @$pb.TagNumber(4)
  void clearParent() => clearField(4);
}

class UpdateCommentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCommentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<NodeColor>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', $pb.PbFieldType.OE, defaultOrMaker: NodeColor.NODE_COLOR_NONE, valueOf: NodeColor.valueOf, enumValues: NodeColor.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'showBackground')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'showBorder')
    ..hasRequiredFields = false
  ;

  UpdateCommentRequest._() : super();
  factory UpdateCommentRequest({
    $core.String? id,
    NodeColor? color,
    $core.String? label,
    $core.bool? showBackground,
    $core.bool? showBorder,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (color != null) {
      _result.color = color;
    }
    if (label != null) {
      _result.label = label;
    }
    if (showBackground != null) {
      _result.showBackground = showBackground;
    }
    if (showBorder != null) {
      _result.showBorder = showBorder;
    }
    return _result;
  }
  factory UpdateCommentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCommentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCommentRequest clone() => UpdateCommentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCommentRequest copyWith(void Function(UpdateCommentRequest) updates) => super.copyWith((message) => updates(message as UpdateCommentRequest)) as UpdateCommentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateCommentRequest create() => UpdateCommentRequest._();
  UpdateCommentRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCommentRequest> createRepeated() => $pb.PbList<UpdateCommentRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCommentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCommentRequest>(create);
  static UpdateCommentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  NodeColor get color => $_getN(1);
  @$pb.TagNumber(2)
  set color(NodeColor v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearColor() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(2);
  @$pb.TagNumber(3)
  set label($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLabel() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get showBackground => $_getBF(3);
  @$pb.TagNumber(4)
  set showBackground($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasShowBackground() => $_has(3);
  @$pb.TagNumber(4)
  void clearShowBackground() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get showBorder => $_getBF(4);
  @$pb.TagNumber(5)
  set showBorder($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasShowBorder() => $_has(4);
  @$pb.TagNumber(5)
  void clearShowBorder() => clearField(5);
}

class DuplicateNodesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DuplicateNodesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paths')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  DuplicateNodesRequest._() : super();
  factory DuplicateNodesRequest({
    $core.Iterable<$core.String>? paths,
    $core.String? parent,
  }) {
    final _result = create();
    if (paths != null) {
      _result.paths.addAll(paths);
    }
    if (parent != null) {
      _result.parent = parent;
    }
    return _result;
  }
  factory DuplicateNodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DuplicateNodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DuplicateNodesRequest clone() => DuplicateNodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DuplicateNodesRequest copyWith(void Function(DuplicateNodesRequest) updates) => super.copyWith((message) => updates(message as DuplicateNodesRequest)) as DuplicateNodesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DuplicateNodesRequest create() => DuplicateNodesRequest._();
  DuplicateNodesRequest createEmptyInstance() => create();
  static $pb.PbList<DuplicateNodesRequest> createRepeated() => $pb.PbList<DuplicateNodesRequest>();
  @$core.pragma('dart2js:noInline')
  static DuplicateNodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DuplicateNodesRequest>(create);
  static DuplicateNodesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get paths => $_getList(0);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisconnectPortRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port')
    ..hasRequiredFields = false
  ;

  DisconnectPortRequest._() : super();
  factory DisconnectPortRequest({
    $core.String? path,
    $core.String? port,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (port != null) {
      _result.port = port;
    }
    return _result;
  }
  factory DisconnectPortRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectPortRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectPortRequest clone() => DisconnectPortRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectPortRequest copyWith(void Function(DisconnectPortRequest) updates) => super.copyWith((message) => updates(message as DisconnectPortRequest)) as DisconnectPortRequest; // ignore: deprecated_member_use
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

class UpdateNodeSettingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateNodeSettingRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOM<NodeSetting>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'setting', subBuilder: NodeSetting.create)
    ..hasRequiredFields = false
  ;

  UpdateNodeSettingRequest._() : super();
  factory UpdateNodeSettingRequest({
    $core.String? path,
    NodeSetting? setting,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (setting != null) {
      _result.setting = setting;
    }
    return _result;
  }
  factory UpdateNodeSettingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNodeSettingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNodeSettingRequest clone() => UpdateNodeSettingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNodeSettingRequest copyWith(void Function(UpdateNodeSettingRequest) updates) => super.copyWith((message) => updates(message as UpdateNodeSettingRequest)) as UpdateNodeSettingRequest; // ignore: deprecated_member_use
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

class UpdateNodeColorRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateNodeColorRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..e<NodeColor>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', $pb.PbFieldType.OE, defaultOrMaker: NodeColor.NODE_COLOR_NONE, valueOf: NodeColor.valueOf, enumValues: NodeColor.values)
    ..hasRequiredFields = false
  ;

  UpdateNodeColorRequest._() : super();
  factory UpdateNodeColorRequest({
    $core.String? path,
    NodeColor? color,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (color != null) {
      _result.color = color;
    }
    return _result;
  }
  factory UpdateNodeColorRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateNodeColorRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateNodeColorRequest clone() => UpdateNodeColorRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateNodeColorRequest copyWith(void Function(UpdateNodeColorRequest) updates) => super.copyWith((message) => updates(message as UpdateNodeColorRequest)) as UpdateNodeColorRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateNodeColorRequest create() => UpdateNodeColorRequest._();
  UpdateNodeColorRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateNodeColorRequest> createRepeated() => $pb.PbList<UpdateNodeColorRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateNodeColorRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateNodeColorRequest>(create);
  static UpdateNodeColorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  NodeColor get color => $_getN(1);
  @$pb.TagNumber(2)
  set color(NodeColor v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearColor() => clearField(2);
}

class MoveNodesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MoveNodesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<MoveNodeRequest>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: MoveNodeRequest.create)
    ..hasRequiredFields = false
  ;

  MoveNodesRequest._() : super();
  factory MoveNodesRequest({
    $core.Iterable<MoveNodeRequest>? nodes,
  }) {
    final _result = create();
    if (nodes != null) {
      _result.nodes.addAll(nodes);
    }
    return _result;
  }
  factory MoveNodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveNodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveNodesRequest clone() => MoveNodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveNodesRequest copyWith(void Function(MoveNodesRequest) updates) => super.copyWith((message) => updates(message as MoveNodesRequest)) as MoveNodesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MoveNodesRequest create() => MoveNodesRequest._();
  MoveNodesRequest createEmptyInstance() => create();
  static $pb.PbList<MoveNodesRequest> createRepeated() => $pb.PbList<MoveNodesRequest>();
  @$core.pragma('dart2js:noInline')
  static MoveNodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveNodesRequest>(create);
  static MoveNodesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MoveNodeRequest> get nodes => $_getList(0);
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

class Nodes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Nodes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<Node>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..pc<NodeConnection>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: NodeConnection.create)
    ..pc<Node>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allNodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..pc<NodeCommentArea>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'comments', $pb.PbFieldType.PM, subBuilder: NodeCommentArea.create)
    ..hasRequiredFields = false
  ;

  Nodes._() : super();
  factory Nodes({
    $core.Iterable<Node>? nodes,
    $core.Iterable<NodeConnection>? channels,
    $core.Iterable<Node>? allNodes,
    $core.Iterable<NodeCommentArea>? comments,
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
    if (comments != null) {
      _result.comments.addAll(comments);
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

  @$pb.TagNumber(4)
  $core.List<NodeCommentArea> get comments => $_getList(3);
}

class AvailableNodes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AvailableNodes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<AvailableNode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: AvailableNode.create)
    ..hasRequiredFields = false
  ;

  AvailableNodes._() : super();
  factory AvailableNodes({
    $core.Iterable<AvailableNode>? nodes,
  }) {
    final _result = create();
    if (nodes != null) {
      _result.nodes.addAll(nodes);
    }
    return _result;
  }
  factory AvailableNodes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AvailableNodes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AvailableNodes clone() => AvailableNodes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AvailableNodes copyWith(void Function(AvailableNodes) updates) => super.copyWith((message) => updates(message as AvailableNodes)) as AvailableNodes; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AvailableNode', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<NodeCategory>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: NodeCategory.NODE_CATEGORY_NONE, valueOf: NodeCategory.valueOf, enumValues: NodeCategory.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..pc<NodeSettingDescription>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settings', $pb.PbFieldType.PM, subBuilder: NodeSettingDescription.create)
    ..pc<NodeTemplate>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'templates', $pb.PbFieldType.PM, subBuilder: NodeTemplate.create)
    ..hasRequiredFields = false
  ;

  AvailableNode._() : super();
  factory AvailableNode({
    $core.String? type,
    $core.String? name,
    NodeCategory? category,
    $core.String? description,
    $core.Iterable<NodeSettingDescription>? settings,
    $core.Iterable<NodeTemplate>? templates,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (name != null) {
      _result.name = name;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (settings != null) {
      _result.settings.addAll(settings);
    }
    if (templates != null) {
      _result.templates.addAll(templates);
    }
    return _result;
  }
  factory AvailableNode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AvailableNode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AvailableNode clone() => AvailableNode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AvailableNode copyWith(void Function(AvailableNode) updates) => super.copyWith((message) => updates(message as AvailableNode)) as AvailableNode; // ignore: deprecated_member_use
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

  @$pb.TagNumber(5)
  $core.List<NodeSettingDescription> get settings => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<NodeTemplate> get templates => $_getList(5);
}

class NodeSettingDescription extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSettingDescription', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  NodeSettingDescription._() : super();
  factory NodeSettingDescription({
    $core.String? name,
    $core.String? description,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory NodeSettingDescription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSettingDescription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSettingDescription clone() => NodeSettingDescription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSettingDescription copyWith(void Function(NodeSettingDescription) updates) => super.copyWith((message) => updates(message as NodeSettingDescription)) as NodeSettingDescription; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodeSettingDescription create() => NodeSettingDescription._();
  NodeSettingDescription createEmptyInstance() => create();
  static $pb.PbList<NodeSettingDescription> createRepeated() => $pb.PbList<NodeSettingDescription>();
  @$core.pragma('dart2js:noInline')
  static NodeSettingDescription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeSettingDescription>(create);
  static NodeSettingDescription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);
}

class NodeTemplate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeTemplate', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  NodeTemplate._() : super();
  factory NodeTemplate({
    $core.String? name,
    $core.String? description,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory NodeTemplate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeTemplate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeTemplate clone() => NodeTemplate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeTemplate copyWith(void Function(NodeTemplate) updates) => super.copyWith((message) => updates(message as NodeTemplate)) as NodeTemplate; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodeTemplate create() => NodeTemplate._();
  NodeTemplate createEmptyInstance() => create();
  static $pb.PbList<NodeTemplate> createRepeated() => $pb.PbList<NodeTemplate>();
  @$core.pragma('dart2js:noInline')
  static NodeTemplate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeTemplate>(create);
  static NodeTemplate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);
}

class NodeConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetNode')
    ..aOM<Port>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetPort', subBuilder: Port.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceNode')
    ..aOM<Port>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourcePort', subBuilder: Port.create)
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
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..pc<Port>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..pc<Port>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..aOM<NodeDesigner>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'designer', subBuilder: NodeDesigner.create)
    ..e<Node_NodePreviewType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preview', $pb.PbFieldType.OE, defaultOrMaker: Node_NodePreviewType.NONE, valueOf: Node_NodePreviewType.valueOf, enumValues: Node_NodePreviewType.values)
    ..pc<NodeSetting>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settings', $pb.PbFieldType.PM, subBuilder: NodeSetting.create)
    ..aOM<NodeDetails>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'details', subBuilder: NodeDetails.create)
    ..pc<Node>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'children', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..hasRequiredFields = false
  ;

  Node._() : super();
  factory Node({
    $core.String? type,
    $core.String? path,
    $core.Iterable<Port>? inputs,
    $core.Iterable<Port>? outputs,
    NodeDesigner? designer,
    Node_NodePreviewType? preview,
    $core.Iterable<NodeSetting>? settings,
    NodeDetails? details,
    $core.Iterable<Node>? children,
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
    if (settings != null) {
      _result.settings.addAll(settings);
    }
    if (details != null) {
      _result.details = details;
    }
    if (children != null) {
      _result.children.addAll(children);
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
  $core.List<NodeSetting> get settings => $_getList(6);

  @$pb.TagNumber(8)
  NodeDetails get details => $_getN(7);
  @$pb.TagNumber(8)
  set details(NodeDetails v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasDetails() => $_has(7);
  @$pb.TagNumber(8)
  void clearDetails() => clearField(8);
  @$pb.TagNumber(8)
  NodeDetails ensureDetails() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.List<Node> get children => $_getList(8);
}

class NodeDetails extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeDetails', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodeTypeName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasCustomName')
    ..e<NodeCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: NodeCategory.NODE_CATEGORY_NONE, valueOf: NodeCategory.valueOf, enumValues: NodeCategory.values)
    ..hasRequiredFields = false
  ;

  NodeDetails._() : super();
  factory NodeDetails({
    $core.String? nodeTypeName,
    $core.String? displayName,
    $core.bool? hasCustomName,
    NodeCategory? category,
  }) {
    final _result = create();
    if (nodeTypeName != null) {
      _result.nodeTypeName = nodeTypeName;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (hasCustomName != null) {
      _result.hasCustomName = hasCustomName;
    }
    if (category != null) {
      _result.category = category;
    }
    return _result;
  }
  factory NodeDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeDetails clone() => NodeDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeDetails copyWith(void Function(NodeDetails) updates) => super.copyWith((message) => updates(message as NodeDetails)) as NodeDetails; // ignore: deprecated_member_use
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

class NodeSetting_TextValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.TextValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'multiline')
    ..hasRequiredFields = false
  ;

  NodeSetting_TextValue._() : super();
  factory NodeSetting_TextValue({
    $core.String? value,
    $core.bool? multiline,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (multiline != null) {
      _result.multiline = multiline;
    }
    return _result;
  }
  factory NodeSetting_TextValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_TextValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_TextValue clone() => NodeSetting_TextValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_TextValue copyWith(void Function(NodeSetting_TextValue) updates) => super.copyWith((message) => updates(message as NodeSetting_TextValue)) as NodeSetting_TextValue; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.FloatValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'min', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minHint', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'max', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxHint', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepSize', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  NodeSetting_FloatValue._() : super();
  factory NodeSetting_FloatValue({
    $core.double? value,
    $core.double? min,
    $core.double? minHint,
    $core.double? max,
    $core.double? maxHint,
    $core.double? stepSize,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (min != null) {
      _result.min = min;
    }
    if (minHint != null) {
      _result.minHint = minHint;
    }
    if (max != null) {
      _result.max = max;
    }
    if (maxHint != null) {
      _result.maxHint = maxHint;
    }
    if (stepSize != null) {
      _result.stepSize = stepSize;
    }
    return _result;
  }
  factory NodeSetting_FloatValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_FloatValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_FloatValue clone() => NodeSetting_FloatValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_FloatValue copyWith(void Function(NodeSetting_FloatValue) updates) => super.copyWith((message) => updates(message as NodeSetting_FloatValue)) as NodeSetting_FloatValue; // ignore: deprecated_member_use
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

  @$pb.TagNumber(6)
  $core.double get stepSize => $_getN(5);
  @$pb.TagNumber(6)
  set stepSize($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStepSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearStepSize() => clearField(6);
}

class NodeSetting_IntValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.IntValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'min', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minHint', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'max', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxHint', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  NodeSetting_IntValue._() : super();
  factory NodeSetting_IntValue({
    $core.int? value,
    $core.int? min,
    $core.int? minHint,
    $core.int? max,
    $core.int? maxHint,
    $core.int? stepSize,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (min != null) {
      _result.min = min;
    }
    if (minHint != null) {
      _result.minHint = minHint;
    }
    if (max != null) {
      _result.max = max;
    }
    if (maxHint != null) {
      _result.maxHint = maxHint;
    }
    if (stepSize != null) {
      _result.stepSize = stepSize;
    }
    return _result;
  }
  factory NodeSetting_IntValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_IntValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_IntValue clone() => NodeSetting_IntValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_IntValue copyWith(void Function(NodeSetting_IntValue) updates) => super.copyWith((message) => updates(message as NodeSetting_IntValue)) as NodeSetting_IntValue; // ignore: deprecated_member_use
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

  @$pb.TagNumber(6)
  $core.int get stepSize => $_getIZ(5);
  @$pb.TagNumber(6)
  set stepSize($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStepSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearStepSize() => clearField(6);
}

class NodeSetting_UintValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.UintValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'min', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minHint', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'max', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxHint', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepSize', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  NodeSetting_UintValue._() : super();
  factory NodeSetting_UintValue({
    $core.int? value,
    $core.int? min,
    $core.int? minHint,
    $core.int? max,
    $core.int? maxHint,
    $core.int? stepSize,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (min != null) {
      _result.min = min;
    }
    if (minHint != null) {
      _result.minHint = minHint;
    }
    if (max != null) {
      _result.max = max;
    }
    if (maxHint != null) {
      _result.maxHint = maxHint;
    }
    if (stepSize != null) {
      _result.stepSize = stepSize;
    }
    return _result;
  }
  factory NodeSetting_UintValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_UintValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_UintValue clone() => NodeSetting_UintValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_UintValue copyWith(void Function(NodeSetting_UintValue) updates) => super.copyWith((message) => updates(message as NodeSetting_UintValue)) as NodeSetting_UintValue; // ignore: deprecated_member_use
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

  @$pb.TagNumber(6)
  $core.int get stepSize => $_getIZ(5);
  @$pb.TagNumber(6)
  set stepSize($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStepSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearStepSize() => clearField(6);
}

class NodeSetting_BoolValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.BoolValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  NodeSetting_BoolValue._() : super();
  factory NodeSetting_BoolValue({
    $core.bool? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory NodeSetting_BoolValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_BoolValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_BoolValue clone() => NodeSetting_BoolValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_BoolValue copyWith(void Function(NodeSetting_BoolValue) updates) => super.copyWith((message) => updates(message as NodeSetting_BoolValue)) as NodeSetting_BoolValue; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.SelectValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..pc<NodeSetting_SelectVariant>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variants', $pb.PbFieldType.PM, subBuilder: NodeSetting_SelectVariant.create)
    ..hasRequiredFields = false
  ;

  NodeSetting_SelectValue._() : super();
  factory NodeSetting_SelectValue({
    $core.String? value,
    $core.Iterable<NodeSetting_SelectVariant>? variants,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (variants != null) {
      _result.variants.addAll(variants);
    }
    return _result;
  }
  factory NodeSetting_SelectValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SelectValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectValue clone() => NodeSetting_SelectValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectValue copyWith(void Function(NodeSetting_SelectValue) updates) => super.copyWith((message) => updates(message as NodeSetting_SelectValue)) as NodeSetting_SelectValue; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.SelectVariant.SelectGroup', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..pc<NodeSetting_SelectVariant>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: NodeSetting_SelectVariant.create)
    ..hasRequiredFields = false
  ;

  NodeSetting_SelectVariant_SelectGroup._() : super();
  factory NodeSetting_SelectVariant_SelectGroup({
    $core.String? label,
    $core.Iterable<NodeSetting_SelectVariant>? items,
  }) {
    final _result = create();
    if (label != null) {
      _result.label = label;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory NodeSetting_SelectVariant_SelectGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SelectVariant_SelectGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant_SelectGroup clone() => NodeSetting_SelectVariant_SelectGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant_SelectGroup copyWith(void Function(NodeSetting_SelectVariant_SelectGroup) updates) => super.copyWith((message) => updates(message as NodeSetting_SelectVariant_SelectGroup)) as NodeSetting_SelectVariant_SelectGroup; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.SelectVariant.SelectItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..hasRequiredFields = false
  ;

  NodeSetting_SelectVariant_SelectItem._() : super();
  factory NodeSetting_SelectVariant_SelectItem({
    $core.String? value,
    $core.String? label,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (label != null) {
      _result.label = label;
    }
    return _result;
  }
  factory NodeSetting_SelectVariant_SelectItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SelectVariant_SelectItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant_SelectItem clone() => NodeSetting_SelectVariant_SelectItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant_SelectItem copyWith(void Function(NodeSetting_SelectVariant_SelectItem) updates) => super.copyWith((message) => updates(message as NodeSetting_SelectVariant_SelectItem)) as NodeSetting_SelectVariant_SelectItem; // ignore: deprecated_member_use
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
  static const $core.Map<$core.int, NodeSetting_SelectVariant_Variant> _NodeSetting_SelectVariant_VariantByTag = {
    1 : NodeSetting_SelectVariant_Variant.group,
    2 : NodeSetting_SelectVariant_Variant.item,
    0 : NodeSetting_SelectVariant_Variant.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.SelectVariant', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<NodeSetting_SelectVariant_SelectGroup>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'group', subBuilder: NodeSetting_SelectVariant_SelectGroup.create)
    ..aOM<NodeSetting_SelectVariant_SelectItem>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: NodeSetting_SelectVariant_SelectItem.create)
    ..hasRequiredFields = false
  ;

  NodeSetting_SelectVariant._() : super();
  factory NodeSetting_SelectVariant({
    NodeSetting_SelectVariant_SelectGroup? group,
    NodeSetting_SelectVariant_SelectItem? item,
  }) {
    final _result = create();
    if (group != null) {
      _result.group = group;
    }
    if (item != null) {
      _result.item = item;
    }
    return _result;
  }
  factory NodeSetting_SelectVariant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SelectVariant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant clone() => NodeSetting_SelectVariant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SelectVariant copyWith(void Function(NodeSetting_SelectVariant) updates) => super.copyWith((message) => updates(message as NodeSetting_SelectVariant)) as NodeSetting_SelectVariant; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.EnumValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OU3)
    ..pc<NodeSetting_EnumVariant>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variants', $pb.PbFieldType.PM, subBuilder: NodeSetting_EnumVariant.create)
    ..hasRequiredFields = false
  ;

  NodeSetting_EnumValue._() : super();
  factory NodeSetting_EnumValue({
    $core.int? value,
    $core.Iterable<NodeSetting_EnumVariant>? variants,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (variants != null) {
      _result.variants.addAll(variants);
    }
    return _result;
  }
  factory NodeSetting_EnumValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_EnumValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_EnumValue clone() => NodeSetting_EnumValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_EnumValue copyWith(void Function(NodeSetting_EnumValue) updates) => super.copyWith((message) => updates(message as NodeSetting_EnumValue)) as NodeSetting_EnumValue; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.EnumVariant', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..hasRequiredFields = false
  ;

  NodeSetting_EnumVariant._() : super();
  factory NodeSetting_EnumVariant({
    $core.int? value,
    $core.String? label,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (label != null) {
      _result.label = label;
    }
    return _result;
  }
  factory NodeSetting_EnumVariant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_EnumVariant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_EnumVariant clone() => NodeSetting_EnumVariant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_EnumVariant copyWith(void Function(NodeSetting_EnumVariant) updates) => super.copyWith((message) => updates(message as NodeSetting_EnumVariant)) as NodeSetting_EnumVariant; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.IdValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OU3)
    ..pc<NodeSetting_IdVariant>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variants', $pb.PbFieldType.PM, subBuilder: NodeSetting_IdVariant.create)
    ..hasRequiredFields = false
  ;

  NodeSetting_IdValue._() : super();
  factory NodeSetting_IdValue({
    $core.int? value,
    $core.Iterable<NodeSetting_IdVariant>? variants,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (variants != null) {
      _result.variants.addAll(variants);
    }
    return _result;
  }
  factory NodeSetting_IdValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_IdValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_IdValue clone() => NodeSetting_IdValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_IdValue copyWith(void Function(NodeSetting_IdValue) updates) => super.copyWith((message) => updates(message as NodeSetting_IdValue)) as NodeSetting_IdValue; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.IdVariant', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..hasRequiredFields = false
  ;

  NodeSetting_IdVariant._() : super();
  factory NodeSetting_IdVariant({
    $core.int? value,
    $core.String? label,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (label != null) {
      _result.label = label;
    }
    return _result;
  }
  factory NodeSetting_IdVariant.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_IdVariant.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_IdVariant clone() => NodeSetting_IdVariant()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_IdVariant copyWith(void Function(NodeSetting_IdVariant) updates) => super.copyWith((message) => updates(message as NodeSetting_IdVariant)) as NodeSetting_IdVariant; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.SplineValue.SplineStep', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0b', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1a', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  NodeSetting_SplineValue_SplineStep._() : super();
  factory NodeSetting_SplineValue_SplineStep({
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
  factory NodeSetting_SplineValue_SplineStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SplineValue_SplineStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SplineValue_SplineStep clone() => NodeSetting_SplineValue_SplineStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SplineValue_SplineStep copyWith(void Function(NodeSetting_SplineValue_SplineStep) updates) => super.copyWith((message) => updates(message as NodeSetting_SplineValue_SplineStep)) as NodeSetting_SplineValue_SplineStep; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.SplineValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..pc<NodeSetting_SplineValue_SplineStep>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: NodeSetting_SplineValue_SplineStep.create)
    ..hasRequiredFields = false
  ;

  NodeSetting_SplineValue._() : super();
  factory NodeSetting_SplineValue({
    $core.Iterable<NodeSetting_SplineValue_SplineStep>? steps,
  }) {
    final _result = create();
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    return _result;
  }
  factory NodeSetting_SplineValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_SplineValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_SplineValue clone() => NodeSetting_SplineValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_SplineValue copyWith(void Function(NodeSetting_SplineValue) updates) => super.copyWith((message) => updates(message as NodeSetting_SplineValue)) as NodeSetting_SplineValue; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.MediaValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..pc<$0.MediaType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allowedTypes', $pb.PbFieldType.KE, valueOf: $0.MediaType.valueOf, enumValues: $0.MediaType.values, defaultEnumValue: $0.MediaType.IMAGE)
    ..hasRequiredFields = false
  ;

  NodeSetting_MediaValue._() : super();
  factory NodeSetting_MediaValue({
    $core.String? value,
    $core.Iterable<$0.MediaType>? allowedTypes,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (allowedTypes != null) {
      _result.allowedTypes.addAll(allowedTypes);
    }
    return _result;
  }
  factory NodeSetting_MediaValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_MediaValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_MediaValue clone() => NodeSetting_MediaValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_MediaValue copyWith(void Function(NodeSetting_MediaValue) updates) => super.copyWith((message) => updates(message as NodeSetting_MediaValue)) as NodeSetting_MediaValue; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting.StepSequencerValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..p<$core.bool>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.KB)
    ..hasRequiredFields = false
  ;

  NodeSetting_StepSequencerValue._() : super();
  factory NodeSetting_StepSequencerValue({
    $core.Iterable<$core.bool>? steps,
  }) {
    final _result = create();
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    return _result;
  }
  factory NodeSetting_StepSequencerValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting_StepSequencerValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting_StepSequencerValue clone() => NodeSetting_StepSequencerValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting_StepSequencerValue copyWith(void Function(NodeSetting_StepSequencerValue) updates) => super.copyWith((message) => updates(message as NodeSetting_StepSequencerValue)) as NodeSetting_StepSequencerValue; // ignore: deprecated_member_use
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
  textValue, 
  floatValue, 
  intValue, 
  boolValue, 
  selectValue, 
  enumValue, 
  idValue, 
  splineValue, 
  mediaValue, 
  uintValue, 
  stepSequencerValue, 
  notSet
}

class NodeSetting extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, NodeSetting_Value> _NodeSetting_ValueByTag = {
    6 : NodeSetting_Value.textValue,
    7 : NodeSetting_Value.floatValue,
    8 : NodeSetting_Value.intValue,
    9 : NodeSetting_Value.boolValue,
    10 : NodeSetting_Value.selectValue,
    11 : NodeSetting_Value.enumValue,
    12 : NodeSetting_Value.idValue,
    13 : NodeSetting_Value.splineValue,
    14 : NodeSetting_Value.mediaValue,
    15 : NodeSetting_Value.uintValue,
    16 : NodeSetting_Value.stepSequencerValue,
    0 : NodeSetting_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..oo(0, [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disabled')
    ..aOM<NodeSetting_TextValue>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'textValue', subBuilder: NodeSetting_TextValue.create)
    ..aOM<NodeSetting_FloatValue>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'floatValue', subBuilder: NodeSetting_FloatValue.create)
    ..aOM<NodeSetting_IntValue>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intValue', subBuilder: NodeSetting_IntValue.create)
    ..aOM<NodeSetting_BoolValue>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boolValue', subBuilder: NodeSetting_BoolValue.create)
    ..aOM<NodeSetting_SelectValue>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectValue', subBuilder: NodeSetting_SelectValue.create)
    ..aOM<NodeSetting_EnumValue>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enumValue', subBuilder: NodeSetting_EnumValue.create)
    ..aOM<NodeSetting_IdValue>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idValue', subBuilder: NodeSetting_IdValue.create)
    ..aOM<NodeSetting_SplineValue>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'splineValue', subBuilder: NodeSetting_SplineValue.create)
    ..aOM<NodeSetting_MediaValue>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mediaValue', subBuilder: NodeSetting_MediaValue.create)
    ..aOM<NodeSetting_UintValue>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uintValue', subBuilder: NodeSetting_UintValue.create)
    ..aOM<NodeSetting_StepSequencerValue>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepSequencerValue', subBuilder: NodeSetting_StepSequencerValue.create)
    ..hasRequiredFields = false
  ;

  NodeSetting._() : super();
  factory NodeSetting({
    $core.String? id,
    $core.String? label,
    $core.String? category,
    $core.String? description,
    $core.bool? disabled,
    NodeSetting_TextValue? textValue,
    NodeSetting_FloatValue? floatValue,
    NodeSetting_IntValue? intValue,
    NodeSetting_BoolValue? boolValue,
    NodeSetting_SelectValue? selectValue,
    NodeSetting_EnumValue? enumValue,
    NodeSetting_IdValue? idValue,
    NodeSetting_SplineValue? splineValue,
    NodeSetting_MediaValue? mediaValue,
    NodeSetting_UintValue? uintValue,
    NodeSetting_StepSequencerValue? stepSequencerValue,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (label != null) {
      _result.label = label;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (disabled != null) {
      _result.disabled = disabled;
    }
    if (textValue != null) {
      _result.textValue = textValue;
    }
    if (floatValue != null) {
      _result.floatValue = floatValue;
    }
    if (intValue != null) {
      _result.intValue = intValue;
    }
    if (boolValue != null) {
      _result.boolValue = boolValue;
    }
    if (selectValue != null) {
      _result.selectValue = selectValue;
    }
    if (enumValue != null) {
      _result.enumValue = enumValue;
    }
    if (idValue != null) {
      _result.idValue = idValue;
    }
    if (splineValue != null) {
      _result.splineValue = splineValue;
    }
    if (mediaValue != null) {
      _result.mediaValue = mediaValue;
    }
    if (uintValue != null) {
      _result.uintValue = uintValue;
    }
    if (stepSequencerValue != null) {
      _result.stepSequencerValue = stepSequencerValue;
    }
    return _result;
  }
  factory NodeSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeSetting clone() => NodeSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeSetting copyWith(void Function(NodeSetting) updates) => super.copyWith((message) => updates(message as NodeSetting)) as NodeSetting; // ignore: deprecated_member_use
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
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
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

  @$pb.TagNumber(5)
  $core.bool get disabled => $_getBF(4);
  @$pb.TagNumber(5)
  set disabled($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDisabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisabled() => clearField(5);

  @$pb.TagNumber(6)
  NodeSetting_TextValue get textValue => $_getN(5);
  @$pb.TagNumber(6)
  set textValue(NodeSetting_TextValue v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasTextValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearTextValue() => clearField(6);
  @$pb.TagNumber(6)
  NodeSetting_TextValue ensureTextValue() => $_ensure(5);

  @$pb.TagNumber(7)
  NodeSetting_FloatValue get floatValue => $_getN(6);
  @$pb.TagNumber(7)
  set floatValue(NodeSetting_FloatValue v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasFloatValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearFloatValue() => clearField(7);
  @$pb.TagNumber(7)
  NodeSetting_FloatValue ensureFloatValue() => $_ensure(6);

  @$pb.TagNumber(8)
  NodeSetting_IntValue get intValue => $_getN(7);
  @$pb.TagNumber(8)
  set intValue(NodeSetting_IntValue v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasIntValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearIntValue() => clearField(8);
  @$pb.TagNumber(8)
  NodeSetting_IntValue ensureIntValue() => $_ensure(7);

  @$pb.TagNumber(9)
  NodeSetting_BoolValue get boolValue => $_getN(8);
  @$pb.TagNumber(9)
  set boolValue(NodeSetting_BoolValue v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasBoolValue() => $_has(8);
  @$pb.TagNumber(9)
  void clearBoolValue() => clearField(9);
  @$pb.TagNumber(9)
  NodeSetting_BoolValue ensureBoolValue() => $_ensure(8);

  @$pb.TagNumber(10)
  NodeSetting_SelectValue get selectValue => $_getN(9);
  @$pb.TagNumber(10)
  set selectValue(NodeSetting_SelectValue v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSelectValue() => $_has(9);
  @$pb.TagNumber(10)
  void clearSelectValue() => clearField(10);
  @$pb.TagNumber(10)
  NodeSetting_SelectValue ensureSelectValue() => $_ensure(9);

  @$pb.TagNumber(11)
  NodeSetting_EnumValue get enumValue => $_getN(10);
  @$pb.TagNumber(11)
  set enumValue(NodeSetting_EnumValue v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasEnumValue() => $_has(10);
  @$pb.TagNumber(11)
  void clearEnumValue() => clearField(11);
  @$pb.TagNumber(11)
  NodeSetting_EnumValue ensureEnumValue() => $_ensure(10);

  @$pb.TagNumber(12)
  NodeSetting_IdValue get idValue => $_getN(11);
  @$pb.TagNumber(12)
  set idValue(NodeSetting_IdValue v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasIdValue() => $_has(11);
  @$pb.TagNumber(12)
  void clearIdValue() => clearField(12);
  @$pb.TagNumber(12)
  NodeSetting_IdValue ensureIdValue() => $_ensure(11);

  @$pb.TagNumber(13)
  NodeSetting_SplineValue get splineValue => $_getN(12);
  @$pb.TagNumber(13)
  set splineValue(NodeSetting_SplineValue v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasSplineValue() => $_has(12);
  @$pb.TagNumber(13)
  void clearSplineValue() => clearField(13);
  @$pb.TagNumber(13)
  NodeSetting_SplineValue ensureSplineValue() => $_ensure(12);

  @$pb.TagNumber(14)
  NodeSetting_MediaValue get mediaValue => $_getN(13);
  @$pb.TagNumber(14)
  set mediaValue(NodeSetting_MediaValue v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasMediaValue() => $_has(13);
  @$pb.TagNumber(14)
  void clearMediaValue() => clearField(14);
  @$pb.TagNumber(14)
  NodeSetting_MediaValue ensureMediaValue() => $_ensure(13);

  @$pb.TagNumber(15)
  NodeSetting_UintValue get uintValue => $_getN(14);
  @$pb.TagNumber(15)
  set uintValue(NodeSetting_UintValue v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasUintValue() => $_has(14);
  @$pb.TagNumber(15)
  void clearUintValue() => clearField(15);
  @$pb.TagNumber(15)
  NodeSetting_UintValue ensureUintValue() => $_ensure(14);

  @$pb.TagNumber(16)
  NodeSetting_StepSequencerValue get stepSequencerValue => $_getN(15);
  @$pb.TagNumber(16)
  set stepSequencerValue(NodeSetting_StepSequencerValue v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasStepSequencerValue() => $_has(15);
  @$pb.TagNumber(16)
  void clearStepSequencerValue() => clearField(16);
  @$pb.TagNumber(16)
  NodeSetting_StepSequencerValue ensureStepSequencerValue() => $_ensure(15);
}

class MidiNodeConfig_NoteBinding extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiNodeConfig.NoteBinding', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..e<MidiNodeConfig_NoteBinding_MidiType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MidiNodeConfig_NoteBinding_MidiType.CC, valueOf: MidiNodeConfig_NoteBinding_MidiType.valueOf, enumValues: MidiNodeConfig_NoteBinding_MidiType.values)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rangeFrom', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rangeTo', $pb.PbFieldType.OU3)
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
    ..aOM<MidiNodeConfig_NoteBinding>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'noteBinding', subBuilder: MidiNodeConfig_NoteBinding.create)
    ..aOM<MidiNodeConfig_ControlBinding>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlBinding', subBuilder: MidiNodeConfig_ControlBinding.create)
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
    ..e<NodeColor>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', $pb.PbFieldType.OE, defaultOrMaker: NodeColor.NODE_COLOR_NONE, valueOf: NodeColor.valueOf, enumValues: NodeColor.values)
    ..hasRequiredFields = false
  ;

  NodeDesigner._() : super();
  factory NodeDesigner({
    NodePosition? position,
    $core.double? scale,
    $core.bool? hidden,
    NodeColor? color,
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
    if (color != null) {
      _result.color = color;
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

  @$pb.TagNumber(4)
  NodeColor get color => $_getN(3);
  @$pb.TagNumber(4)
  set color(NodeColor v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasColor() => $_has(3);
  @$pb.TagNumber(4)
  void clearColor() => clearField(4);
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

class NodeCommentArea extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeCommentArea', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.nodes'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OD)
    ..aOM<NodeDesigner>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'designer', subBuilder: NodeDesigner.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'showBackground')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'showBorder')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parent')
    ..hasRequiredFields = false
  ;

  NodeCommentArea._() : super();
  factory NodeCommentArea({
    $core.String? id,
    $core.double? width,
    $core.double? height,
    NodeDesigner? designer,
    $core.String? label,
    $core.bool? showBackground,
    $core.bool? showBorder,
    $core.String? parent,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (designer != null) {
      _result.designer = designer;
    }
    if (label != null) {
      _result.label = label;
    }
    if (showBackground != null) {
      _result.showBackground = showBackground;
    }
    if (showBorder != null) {
      _result.showBorder = showBorder;
    }
    if (parent != null) {
      _result.parent = parent;
    }
    return _result;
  }
  factory NodeCommentArea.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeCommentArea.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeCommentArea clone() => NodeCommentArea()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeCommentArea copyWith(void Function(NodeCommentArea) updates) => super.copyWith((message) => updates(message as NodeCommentArea)) as NodeCommentArea; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodeCommentArea create() => NodeCommentArea._();
  NodeCommentArea createEmptyInstance() => create();
  static $pb.PbList<NodeCommentArea> createRepeated() => $pb.PbList<NodeCommentArea>();
  @$core.pragma('dart2js:noInline')
  static NodeCommentArea getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeCommentArea>(create);
  static NodeCommentArea? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get width => $_getN(1);
  @$pb.TagNumber(2)
  set width($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearWidth() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get height => $_getN(2);
  @$pb.TagNumber(3)
  set height($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeight() => clearField(3);

  @$pb.TagNumber(4)
  NodeDesigner get designer => $_getN(3);
  @$pb.TagNumber(4)
  set designer(NodeDesigner v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDesigner() => $_has(3);
  @$pb.TagNumber(4)
  void clearDesigner() => clearField(4);
  @$pb.TagNumber(4)
  NodeDesigner ensureDesigner() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get label => $_getSZ(4);
  @$pb.TagNumber(5)
  set label($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLabel() => $_has(4);
  @$pb.TagNumber(5)
  void clearLabel() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get showBackground => $_getBF(5);
  @$pb.TagNumber(6)
  set showBackground($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasShowBackground() => $_has(5);
  @$pb.TagNumber(6)
  void clearShowBackground() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get showBorder => $_getBF(6);
  @$pb.TagNumber(7)
  set showBorder($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasShowBorder() => $_has(6);
  @$pb.TagNumber(7)
  void clearShowBorder() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get parent => $_getSZ(7);
  @$pb.TagNumber(8)
  set parent($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasParent() => $_has(7);
  @$pb.TagNumber(8)
  void clearParent() => clearField(8);
}

