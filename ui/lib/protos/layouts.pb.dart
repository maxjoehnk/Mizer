///
//  Generated code. Do not modify.
//  source: layouts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'nodes.pbenum.dart' as $2;
import 'layouts.pbenum.dart';

export 'layouts.pbenum.dart';

class LayoutResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LayoutResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  LayoutResponse._() : super();
  factory LayoutResponse() => create();
  factory LayoutResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LayoutResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LayoutResponse clone() => LayoutResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LayoutResponse copyWith(void Function(LayoutResponse) updates) => super.copyWith((message) => updates(message as LayoutResponse)) as LayoutResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LayoutResponse create() => LayoutResponse._();
  LayoutResponse createEmptyInstance() => create();
  static $pb.PbList<LayoutResponse> createRepeated() => $pb.PbList<LayoutResponse>();
  @$core.pragma('dart2js:noInline')
  static LayoutResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LayoutResponse>(create);
  static LayoutResponse? _defaultInstance;
}

class GetLayoutsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLayoutsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetLayoutsRequest._() : super();
  factory GetLayoutsRequest() => create();
  factory GetLayoutsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLayoutsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLayoutsRequest clone() => GetLayoutsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLayoutsRequest copyWith(void Function(GetLayoutsRequest) updates) => super.copyWith((message) => updates(message as GetLayoutsRequest)) as GetLayoutsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLayoutsRequest create() => GetLayoutsRequest._();
  GetLayoutsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLayoutsRequest> createRepeated() => $pb.PbList<GetLayoutsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLayoutsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLayoutsRequest>(create);
  static GetLayoutsRequest? _defaultInstance;
}

class AddLayoutRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddLayoutRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  AddLayoutRequest._() : super();
  factory AddLayoutRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory AddLayoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddLayoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddLayoutRequest clone() => AddLayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddLayoutRequest copyWith(void Function(AddLayoutRequest) updates) => super.copyWith((message) => updates(message as AddLayoutRequest)) as AddLayoutRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddLayoutRequest create() => AddLayoutRequest._();
  AddLayoutRequest createEmptyInstance() => create();
  static $pb.PbList<AddLayoutRequest> createRepeated() => $pb.PbList<AddLayoutRequest>();
  @$core.pragma('dart2js:noInline')
  static AddLayoutRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddLayoutRequest>(create);
  static AddLayoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class RemoveLayoutRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveLayoutRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  RemoveLayoutRequest._() : super();
  factory RemoveLayoutRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory RemoveLayoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveLayoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveLayoutRequest clone() => RemoveLayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveLayoutRequest copyWith(void Function(RemoveLayoutRequest) updates) => super.copyWith((message) => updates(message as RemoveLayoutRequest)) as RemoveLayoutRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveLayoutRequest create() => RemoveLayoutRequest._();
  RemoveLayoutRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveLayoutRequest> createRepeated() => $pb.PbList<RemoveLayoutRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveLayoutRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveLayoutRequest>(create);
  static RemoveLayoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class RenameLayoutRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenameLayoutRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  RenameLayoutRequest._() : super();
  factory RenameLayoutRequest({
    $core.String? id,
    $core.String? name,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory RenameLayoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameLayoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameLayoutRequest clone() => RenameLayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameLayoutRequest copyWith(void Function(RenameLayoutRequest) updates) => super.copyWith((message) => updates(message as RenameLayoutRequest)) as RenameLayoutRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenameLayoutRequest create() => RenameLayoutRequest._();
  RenameLayoutRequest createEmptyInstance() => create();
  static $pb.PbList<RenameLayoutRequest> createRepeated() => $pb.PbList<RenameLayoutRequest>();
  @$core.pragma('dart2js:noInline')
  static RenameLayoutRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameLayoutRequest>(create);
  static RenameLayoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class RenameControlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenameControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layoutId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  RenameControlRequest._() : super();
  factory RenameControlRequest({
    $core.String? layoutId,
    $core.String? controlId,
    $core.String? name,
  }) {
    final _result = create();
    if (layoutId != null) {
      _result.layoutId = layoutId;
    }
    if (controlId != null) {
      _result.controlId = controlId;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory RenameControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameControlRequest clone() => RenameControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameControlRequest copyWith(void Function(RenameControlRequest) updates) => super.copyWith((message) => updates(message as RenameControlRequest)) as RenameControlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenameControlRequest create() => RenameControlRequest._();
  RenameControlRequest createEmptyInstance() => create();
  static $pb.PbList<RenameControlRequest> createRepeated() => $pb.PbList<RenameControlRequest>();
  @$core.pragma('dart2js:noInline')
  static RenameControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameControlRequest>(create);
  static RenameControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get controlId => $_getSZ(1);
  @$pb.TagNumber(2)
  set controlId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasControlId() => $_has(1);
  @$pb.TagNumber(2)
  void clearControlId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);
}

class MoveControlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MoveControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layoutId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlId')
    ..aOM<ControlPosition>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  MoveControlRequest._() : super();
  factory MoveControlRequest({
    $core.String? layoutId,
    $core.String? controlId,
    ControlPosition? position,
  }) {
    final _result = create();
    if (layoutId != null) {
      _result.layoutId = layoutId;
    }
    if (controlId != null) {
      _result.controlId = controlId;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory MoveControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveControlRequest clone() => MoveControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveControlRequest copyWith(void Function(MoveControlRequest) updates) => super.copyWith((message) => updates(message as MoveControlRequest)) as MoveControlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MoveControlRequest create() => MoveControlRequest._();
  MoveControlRequest createEmptyInstance() => create();
  static $pb.PbList<MoveControlRequest> createRepeated() => $pb.PbList<MoveControlRequest>();
  @$core.pragma('dart2js:noInline')
  static MoveControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveControlRequest>(create);
  static MoveControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get controlId => $_getSZ(1);
  @$pb.TagNumber(2)
  set controlId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasControlId() => $_has(1);
  @$pb.TagNumber(2)
  void clearControlId() => clearField(2);

  @$pb.TagNumber(3)
  ControlPosition get position => $_getN(2);
  @$pb.TagNumber(3)
  set position(ControlPosition v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearPosition() => clearField(3);
  @$pb.TagNumber(3)
  ControlPosition ensurePosition() => $_ensure(2);
}

class UpdateControlDecorationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateControlDecorationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layoutId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlId')
    ..aOM<ControlDecorations>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'decorations', subBuilder: ControlDecorations.create)
    ..hasRequiredFields = false
  ;

  UpdateControlDecorationRequest._() : super();
  factory UpdateControlDecorationRequest({
    $core.String? layoutId,
    $core.String? controlId,
    ControlDecorations? decorations,
  }) {
    final _result = create();
    if (layoutId != null) {
      _result.layoutId = layoutId;
    }
    if (controlId != null) {
      _result.controlId = controlId;
    }
    if (decorations != null) {
      _result.decorations = decorations;
    }
    return _result;
  }
  factory UpdateControlDecorationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateControlDecorationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateControlDecorationRequest clone() => UpdateControlDecorationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateControlDecorationRequest copyWith(void Function(UpdateControlDecorationRequest) updates) => super.copyWith((message) => updates(message as UpdateControlDecorationRequest)) as UpdateControlDecorationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateControlDecorationRequest create() => UpdateControlDecorationRequest._();
  UpdateControlDecorationRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateControlDecorationRequest> createRepeated() => $pb.PbList<UpdateControlDecorationRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateControlDecorationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateControlDecorationRequest>(create);
  static UpdateControlDecorationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get controlId => $_getSZ(1);
  @$pb.TagNumber(2)
  set controlId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasControlId() => $_has(1);
  @$pb.TagNumber(2)
  void clearControlId() => clearField(2);

  @$pb.TagNumber(3)
  ControlDecorations get decorations => $_getN(2);
  @$pb.TagNumber(3)
  set decorations(ControlDecorations v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDecorations() => $_has(2);
  @$pb.TagNumber(3)
  void clearDecorations() => clearField(3);
  @$pb.TagNumber(3)
  ControlDecorations ensureDecorations() => $_ensure(2);
}

class UpdateControlBehaviorRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateControlBehaviorRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layoutId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlId')
    ..aOM<ControlBehavior>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'behavior', subBuilder: ControlBehavior.create)
    ..hasRequiredFields = false
  ;

  UpdateControlBehaviorRequest._() : super();
  factory UpdateControlBehaviorRequest({
    $core.String? layoutId,
    $core.String? controlId,
    ControlBehavior? behavior,
  }) {
    final _result = create();
    if (layoutId != null) {
      _result.layoutId = layoutId;
    }
    if (controlId != null) {
      _result.controlId = controlId;
    }
    if (behavior != null) {
      _result.behavior = behavior;
    }
    return _result;
  }
  factory UpdateControlBehaviorRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateControlBehaviorRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateControlBehaviorRequest clone() => UpdateControlBehaviorRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateControlBehaviorRequest copyWith(void Function(UpdateControlBehaviorRequest) updates) => super.copyWith((message) => updates(message as UpdateControlBehaviorRequest)) as UpdateControlBehaviorRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateControlBehaviorRequest create() => UpdateControlBehaviorRequest._();
  UpdateControlBehaviorRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateControlBehaviorRequest> createRepeated() => $pb.PbList<UpdateControlBehaviorRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateControlBehaviorRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateControlBehaviorRequest>(create);
  static UpdateControlBehaviorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get controlId => $_getSZ(1);
  @$pb.TagNumber(2)
  set controlId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasControlId() => $_has(1);
  @$pb.TagNumber(2)
  void clearControlId() => clearField(2);

  @$pb.TagNumber(3)
  ControlBehavior get behavior => $_getN(2);
  @$pb.TagNumber(3)
  set behavior(ControlBehavior v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBehavior() => $_has(2);
  @$pb.TagNumber(3)
  void clearBehavior() => clearField(3);
  @$pb.TagNumber(3)
  ControlBehavior ensureBehavior() => $_ensure(2);
}

class RemoveControlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layoutId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlId')
    ..hasRequiredFields = false
  ;

  RemoveControlRequest._() : super();
  factory RemoveControlRequest({
    $core.String? layoutId,
    $core.String? controlId,
  }) {
    final _result = create();
    if (layoutId != null) {
      _result.layoutId = layoutId;
    }
    if (controlId != null) {
      _result.controlId = controlId;
    }
    return _result;
  }
  factory RemoveControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveControlRequest clone() => RemoveControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveControlRequest copyWith(void Function(RemoveControlRequest) updates) => super.copyWith((message) => updates(message as RemoveControlRequest)) as RemoveControlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveControlRequest create() => RemoveControlRequest._();
  RemoveControlRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveControlRequest> createRepeated() => $pb.PbList<RemoveControlRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveControlRequest>(create);
  static RemoveControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get controlId => $_getSZ(1);
  @$pb.TagNumber(2)
  set controlId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasControlId() => $_has(1);
  @$pb.TagNumber(2)
  void clearControlId() => clearField(2);
}

class AddControlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layoutId')
    ..e<$2.Node_NodeType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodeType', $pb.PbFieldType.OE, defaultOrMaker: $2.Node_NodeType.FADER, valueOf: $2.Node_NodeType.valueOf, enumValues: $2.Node_NodeType.values)
    ..aOM<ControlPosition>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  AddControlRequest._() : super();
  factory AddControlRequest({
    $core.String? layoutId,
    $2.Node_NodeType? nodeType,
    ControlPosition? position,
  }) {
    final _result = create();
    if (layoutId != null) {
      _result.layoutId = layoutId;
    }
    if (nodeType != null) {
      _result.nodeType = nodeType;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory AddControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddControlRequest clone() => AddControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddControlRequest copyWith(void Function(AddControlRequest) updates) => super.copyWith((message) => updates(message as AddControlRequest)) as AddControlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddControlRequest create() => AddControlRequest._();
  AddControlRequest createEmptyInstance() => create();
  static $pb.PbList<AddControlRequest> createRepeated() => $pb.PbList<AddControlRequest>();
  @$core.pragma('dart2js:noInline')
  static AddControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddControlRequest>(create);
  static AddControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $2.Node_NodeType get nodeType => $_getN(1);
  @$pb.TagNumber(2)
  set nodeType($2.Node_NodeType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNodeType() => $_has(1);
  @$pb.TagNumber(2)
  void clearNodeType() => clearField(2);

  @$pb.TagNumber(3)
  ControlPosition get position => $_getN(2);
  @$pb.TagNumber(3)
  set position(ControlPosition v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearPosition() => clearField(3);
  @$pb.TagNumber(3)
  ControlPosition ensurePosition() => $_ensure(2);
}

class AddExistingControlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddExistingControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layoutId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'node')
    ..aOM<ControlPosition>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  AddExistingControlRequest._() : super();
  factory AddExistingControlRequest({
    $core.String? layoutId,
    $core.String? node,
    ControlPosition? position,
  }) {
    final _result = create();
    if (layoutId != null) {
      _result.layoutId = layoutId;
    }
    if (node != null) {
      _result.node = node;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory AddExistingControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddExistingControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddExistingControlRequest clone() => AddExistingControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddExistingControlRequest copyWith(void Function(AddExistingControlRequest) updates) => super.copyWith((message) => updates(message as AddExistingControlRequest)) as AddExistingControlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddExistingControlRequest create() => AddExistingControlRequest._();
  AddExistingControlRequest createEmptyInstance() => create();
  static $pb.PbList<AddExistingControlRequest> createRepeated() => $pb.PbList<AddExistingControlRequest>();
  @$core.pragma('dart2js:noInline')
  static AddExistingControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddExistingControlRequest>(create);
  static AddExistingControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get node => $_getSZ(1);
  @$pb.TagNumber(2)
  set node($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNode() => clearField(2);

  @$pb.TagNumber(3)
  ControlPosition get position => $_getN(2);
  @$pb.TagNumber(3)
  set position(ControlPosition v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearPosition() => clearField(3);
  @$pb.TagNumber(3)
  ControlPosition ensurePosition() => $_ensure(2);
}

class Layouts extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Layouts', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<Layout>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layouts', $pb.PbFieldType.PM, subBuilder: Layout.create)
    ..hasRequiredFields = false
  ;

  Layouts._() : super();
  factory Layouts({
    $core.Iterable<Layout>? layouts,
  }) {
    final _result = create();
    if (layouts != null) {
      _result.layouts.addAll(layouts);
    }
    return _result;
  }
  factory Layouts.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Layouts.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Layouts clone() => Layouts()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Layouts copyWith(void Function(Layouts) updates) => super.copyWith((message) => updates(message as Layouts)) as Layouts; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Layouts create() => Layouts._();
  Layouts createEmptyInstance() => create();
  static $pb.PbList<Layouts> createRepeated() => $pb.PbList<Layouts>();
  @$core.pragma('dart2js:noInline')
  static Layouts getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Layouts>(create);
  static Layouts? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Layout> get layouts => $_getList(0);
}

class Layout extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Layout', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..pc<LayoutControl>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: LayoutControl.create)
    ..hasRequiredFields = false
  ;

  Layout._() : super();
  factory Layout({
    $core.String? id,
    $core.Iterable<LayoutControl>? controls,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (controls != null) {
      _result.controls.addAll(controls);
    }
    return _result;
  }
  factory Layout.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Layout.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Layout clone() => Layout()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Layout copyWith(void Function(Layout) updates) => super.copyWith((message) => updates(message as Layout)) as Layout; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Layout create() => Layout._();
  Layout createEmptyInstance() => create();
  static $pb.PbList<Layout> createRepeated() => $pb.PbList<Layout>();
  @$core.pragma('dart2js:noInline')
  static Layout getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Layout>(create);
  static Layout? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<LayoutControl> get controls => $_getList(1);
}

class LayoutControl extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LayoutControl', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'node')
    ..aOM<ControlPosition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: ControlPosition.create)
    ..aOM<ControlSize>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size', subBuilder: ControlSize.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOM<ControlDecorations>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'decoration', subBuilder: ControlDecorations.create)
    ..aOM<ControlBehavior>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'behavior', subBuilder: ControlBehavior.create)
    ..hasRequiredFields = false
  ;

  LayoutControl._() : super();
  factory LayoutControl({
    $core.String? node,
    ControlPosition? position,
    ControlSize? size,
    $core.String? label,
    ControlDecorations? decoration,
    ControlBehavior? behavior,
  }) {
    final _result = create();
    if (node != null) {
      _result.node = node;
    }
    if (position != null) {
      _result.position = position;
    }
    if (size != null) {
      _result.size = size;
    }
    if (label != null) {
      _result.label = label;
    }
    if (decoration != null) {
      _result.decoration = decoration;
    }
    if (behavior != null) {
      _result.behavior = behavior;
    }
    return _result;
  }
  factory LayoutControl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LayoutControl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LayoutControl clone() => LayoutControl()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LayoutControl copyWith(void Function(LayoutControl) updates) => super.copyWith((message) => updates(message as LayoutControl)) as LayoutControl; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LayoutControl create() => LayoutControl._();
  LayoutControl createEmptyInstance() => create();
  static $pb.PbList<LayoutControl> createRepeated() => $pb.PbList<LayoutControl>();
  @$core.pragma('dart2js:noInline')
  static LayoutControl getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LayoutControl>(create);
  static LayoutControl? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get node => $_getSZ(0);
  @$pb.TagNumber(1)
  set node($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearNode() => clearField(1);

  @$pb.TagNumber(2)
  ControlPosition get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(ControlPosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  ControlPosition ensurePosition() => $_ensure(1);

  @$pb.TagNumber(3)
  ControlSize get size => $_getN(2);
  @$pb.TagNumber(3)
  set size(ControlSize v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearSize() => clearField(3);
  @$pb.TagNumber(3)
  ControlSize ensureSize() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get label => $_getSZ(3);
  @$pb.TagNumber(4)
  set label($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLabel() => $_has(3);
  @$pb.TagNumber(4)
  void clearLabel() => clearField(4);

  @$pb.TagNumber(5)
  ControlDecorations get decoration => $_getN(4);
  @$pb.TagNumber(5)
  set decoration(ControlDecorations v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDecoration() => $_has(4);
  @$pb.TagNumber(5)
  void clearDecoration() => clearField(5);
  @$pb.TagNumber(5)
  ControlDecorations ensureDecoration() => $_ensure(4);

  @$pb.TagNumber(6)
  ControlBehavior get behavior => $_getN(5);
  @$pb.TagNumber(6)
  set behavior(ControlBehavior v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasBehavior() => $_has(5);
  @$pb.TagNumber(6)
  void clearBehavior() => clearField(6);
  @$pb.TagNumber(6)
  ControlBehavior ensureBehavior() => $_ensure(5);
}

class ControlPosition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ControlPosition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ControlPosition._() : super();
  factory ControlPosition({
    $fixnum.Int64? x,
    $fixnum.Int64? y,
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
  factory ControlPosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlPosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlPosition clone() => ControlPosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlPosition copyWith(void Function(ControlPosition) updates) => super.copyWith((message) => updates(message as ControlPosition)) as ControlPosition; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ControlPosition create() => ControlPosition._();
  ControlPosition createEmptyInstance() => create();
  static $pb.PbList<ControlPosition> createRepeated() => $pb.PbList<ControlPosition>();
  @$core.pragma('dart2js:noInline')
  static ControlPosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ControlPosition>(create);
  static ControlPosition? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get x => $_getI64(0);
  @$pb.TagNumber(1)
  set x($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get y => $_getI64(1);
  @$pb.TagNumber(2)
  set y($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);
}

class ControlSize extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ControlSize', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ControlSize._() : super();
  factory ControlSize({
    $fixnum.Int64? width,
    $fixnum.Int64? height,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory ControlSize.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlSize.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlSize clone() => ControlSize()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlSize copyWith(void Function(ControlSize) updates) => super.copyWith((message) => updates(message as ControlSize)) as ControlSize; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ControlSize create() => ControlSize._();
  ControlSize createEmptyInstance() => create();
  static $pb.PbList<ControlSize> createRepeated() => $pb.PbList<ControlSize>();
  @$core.pragma('dart2js:noInline')
  static ControlSize getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ControlSize>(create);
  static ControlSize? _defaultInstance;

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
}

class ControlDecorations extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ControlDecorations', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasColor')
    ..aOM<Color>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: Color.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasImage')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'image', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ControlDecorations._() : super();
  factory ControlDecorations({
    $core.bool? hasColor,
    Color? color_2,
    $core.bool? hasImage,
    $core.List<$core.int>? image_4,
  }) {
    final _result = create();
    if (hasColor != null) {
      _result.hasColor = hasColor;
    }
    if (color_2 != null) {
      _result.color_2 = color_2;
    }
    if (hasImage != null) {
      _result.hasImage = hasImage;
    }
    if (image_4 != null) {
      _result.image_4 = image_4;
    }
    return _result;
  }
  factory ControlDecorations.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlDecorations.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlDecorations clone() => ControlDecorations()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlDecorations copyWith(void Function(ControlDecorations) updates) => super.copyWith((message) => updates(message as ControlDecorations)) as ControlDecorations; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ControlDecorations create() => ControlDecorations._();
  ControlDecorations createEmptyInstance() => create();
  static $pb.PbList<ControlDecorations> createRepeated() => $pb.PbList<ControlDecorations>();
  @$core.pragma('dart2js:noInline')
  static ControlDecorations getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ControlDecorations>(create);
  static ControlDecorations? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasColor => $_getBF(0);
  @$pb.TagNumber(1)
  set hasColor($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHasColor() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasColor() => clearField(1);

  @$pb.TagNumber(2)
  Color get color_2 => $_getN(1);
  @$pb.TagNumber(2)
  set color_2(Color v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasColor_2() => $_has(1);
  @$pb.TagNumber(2)
  void clearColor_2() => clearField(2);
  @$pb.TagNumber(2)
  Color ensureColor_2() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get hasImage => $_getBF(2);
  @$pb.TagNumber(3)
  set hasImage($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasImage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get image_4 => $_getN(3);
  @$pb.TagNumber(4)
  set image_4($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImage_4() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage_4() => clearField(4);
}

class Color extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Color', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'red', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'green', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Color._() : super();
  factory Color({
    $core.double? red,
    $core.double? green,
    $core.double? blue,
  }) {
    final _result = create();
    if (red != null) {
      _result.red = red;
    }
    if (green != null) {
      _result.green = green;
    }
    if (blue != null) {
      _result.blue = blue;
    }
    return _result;
  }
  factory Color.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Color.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Color clone() => Color()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Color copyWith(void Function(Color) updates) => super.copyWith((message) => updates(message as Color)) as Color; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Color create() => Color._();
  Color createEmptyInstance() => create();
  static $pb.PbList<Color> createRepeated() => $pb.PbList<Color>();
  @$core.pragma('dart2js:noInline')
  static Color getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Color>(create);
  static Color? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get red => $_getN(0);
  @$pb.TagNumber(1)
  set red($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRed() => $_has(0);
  @$pb.TagNumber(1)
  void clearRed() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get green => $_getN(1);
  @$pb.TagNumber(2)
  set green($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGreen() => $_has(1);
  @$pb.TagNumber(2)
  void clearGreen() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get blue => $_getN(2);
  @$pb.TagNumber(3)
  set blue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBlue() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlue() => clearField(3);
}

class ControlBehavior extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ControlBehavior', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOM<SequencerControlBehavior>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequencer', subBuilder: SequencerControlBehavior.create)
    ..hasRequiredFields = false
  ;

  ControlBehavior._() : super();
  factory ControlBehavior({
    SequencerControlBehavior? sequencer,
  }) {
    final _result = create();
    if (sequencer != null) {
      _result.sequencer = sequencer;
    }
    return _result;
  }
  factory ControlBehavior.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlBehavior.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlBehavior clone() => ControlBehavior()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlBehavior copyWith(void Function(ControlBehavior) updates) => super.copyWith((message) => updates(message as ControlBehavior)) as ControlBehavior; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ControlBehavior create() => ControlBehavior._();
  ControlBehavior createEmptyInstance() => create();
  static $pb.PbList<ControlBehavior> createRepeated() => $pb.PbList<ControlBehavior>();
  @$core.pragma('dart2js:noInline')
  static ControlBehavior getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ControlBehavior>(create);
  static ControlBehavior? _defaultInstance;

  @$pb.TagNumber(1)
  SequencerControlBehavior get sequencer => $_getN(0);
  @$pb.TagNumber(1)
  set sequencer(SequencerControlBehavior v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequencer() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequencer() => clearField(1);
  @$pb.TagNumber(1)
  SequencerControlBehavior ensureSequencer() => $_ensure(0);
}

class SequencerControlBehavior extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequencerControlBehavior', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..e<SequencerControlBehavior_ClickBehavior>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clickBehavior', $pb.PbFieldType.OE, defaultOrMaker: SequencerControlBehavior_ClickBehavior.GO_FORWARD, valueOf: SequencerControlBehavior_ClickBehavior.valueOf, enumValues: SequencerControlBehavior_ClickBehavior.values)
    ..hasRequiredFields = false
  ;

  SequencerControlBehavior._() : super();
  factory SequencerControlBehavior({
    SequencerControlBehavior_ClickBehavior? clickBehavior,
  }) {
    final _result = create();
    if (clickBehavior != null) {
      _result.clickBehavior = clickBehavior;
    }
    return _result;
  }
  factory SequencerControlBehavior.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequencerControlBehavior.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequencerControlBehavior clone() => SequencerControlBehavior()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequencerControlBehavior copyWith(void Function(SequencerControlBehavior) updates) => super.copyWith((message) => updates(message as SequencerControlBehavior)) as SequencerControlBehavior; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SequencerControlBehavior create() => SequencerControlBehavior._();
  SequencerControlBehavior createEmptyInstance() => create();
  static $pb.PbList<SequencerControlBehavior> createRepeated() => $pb.PbList<SequencerControlBehavior>();
  @$core.pragma('dart2js:noInline')
  static SequencerControlBehavior getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequencerControlBehavior>(create);
  static SequencerControlBehavior? _defaultInstance;

  @$pb.TagNumber(1)
  SequencerControlBehavior_ClickBehavior get clickBehavior => $_getN(0);
  @$pb.TagNumber(1)
  set clickBehavior(SequencerControlBehavior_ClickBehavior v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClickBehavior() => $_has(0);
  @$pb.TagNumber(1)
  void clearClickBehavior() => clearField(1);
}

class ReadFaderValueRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReadFaderValueRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'node')
    ..hasRequiredFields = false
  ;

  ReadFaderValueRequest._() : super();
  factory ReadFaderValueRequest({
    $core.String? node,
  }) {
    final _result = create();
    if (node != null) {
      _result.node = node;
    }
    return _result;
  }
  factory ReadFaderValueRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadFaderValueRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadFaderValueRequest clone() => ReadFaderValueRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadFaderValueRequest copyWith(void Function(ReadFaderValueRequest) updates) => super.copyWith((message) => updates(message as ReadFaderValueRequest)) as ReadFaderValueRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReadFaderValueRequest create() => ReadFaderValueRequest._();
  ReadFaderValueRequest createEmptyInstance() => create();
  static $pb.PbList<ReadFaderValueRequest> createRepeated() => $pb.PbList<ReadFaderValueRequest>();
  @$core.pragma('dart2js:noInline')
  static ReadFaderValueRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadFaderValueRequest>(create);
  static ReadFaderValueRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get node => $_getSZ(0);
  @$pb.TagNumber(1)
  set node($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearNode() => clearField(1);
}

class FaderValueResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FaderValueResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  FaderValueResponse._() : super();
  factory FaderValueResponse({
    $core.double? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory FaderValueResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FaderValueResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FaderValueResponse clone() => FaderValueResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FaderValueResponse copyWith(void Function(FaderValueResponse) updates) => super.copyWith((message) => updates(message as FaderValueResponse)) as FaderValueResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FaderValueResponse create() => FaderValueResponse._();
  FaderValueResponse createEmptyInstance() => create();
  static $pb.PbList<FaderValueResponse> createRepeated() => $pb.PbList<FaderValueResponse>();
  @$core.pragma('dart2js:noInline')
  static FaderValueResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FaderValueResponse>(create);
  static FaderValueResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

