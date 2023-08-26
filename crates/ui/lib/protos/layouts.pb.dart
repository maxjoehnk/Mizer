//
//  Generated code. Do not modify.
//  source: layouts.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'layouts.pbenum.dart';
import 'programmer.pb.dart' as $1;

export 'layouts.pbenum.dart';

class AddLayoutRequest extends $pb.GeneratedMessage {
  factory AddLayoutRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  AddLayoutRequest._() : super();
  factory AddLayoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddLayoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddLayoutRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddLayoutRequest clone() => AddLayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddLayoutRequest copyWith(void Function(AddLayoutRequest) updates) => super.copyWith((message) => updates(message as AddLayoutRequest)) as AddLayoutRequest;

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
  factory RemoveLayoutRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  RemoveLayoutRequest._() : super();
  factory RemoveLayoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveLayoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveLayoutRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveLayoutRequest clone() => RemoveLayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveLayoutRequest copyWith(void Function(RemoveLayoutRequest) updates) => super.copyWith((message) => updates(message as RemoveLayoutRequest)) as RemoveLayoutRequest;

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
  factory RenameLayoutRequest({
    $core.String? id,
    $core.String? name,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  RenameLayoutRequest._() : super();
  factory RenameLayoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameLayoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RenameLayoutRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameLayoutRequest clone() => RenameLayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameLayoutRequest copyWith(void Function(RenameLayoutRequest) updates) => super.copyWith((message) => updates(message as RenameLayoutRequest)) as RenameLayoutRequest;

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
  factory RenameControlRequest({
    $core.String? layoutId,
    $core.String? controlId,
    $core.String? name,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (controlId != null) {
      $result.controlId = controlId;
    }
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  RenameControlRequest._() : super();
  factory RenameControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RenameControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..aOS(2, _omitFieldNames ? '' : 'controlId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameControlRequest clone() => RenameControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameControlRequest copyWith(void Function(RenameControlRequest) updates) => super.copyWith((message) => updates(message as RenameControlRequest)) as RenameControlRequest;

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
  factory MoveControlRequest({
    $core.String? layoutId,
    $core.String? controlId,
    ControlPosition? position,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (controlId != null) {
      $result.controlId = controlId;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  MoveControlRequest._() : super();
  factory MoveControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MoveControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MoveControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..aOS(2, _omitFieldNames ? '' : 'controlId')
    ..aOM<ControlPosition>(3, _omitFieldNames ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MoveControlRequest clone() => MoveControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MoveControlRequest copyWith(void Function(MoveControlRequest) updates) => super.copyWith((message) => updates(message as MoveControlRequest)) as MoveControlRequest;

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

class ResizeControlRequest extends $pb.GeneratedMessage {
  factory ResizeControlRequest({
    $core.String? layoutId,
    $core.String? controlId,
    ControlSize? size,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (controlId != null) {
      $result.controlId = controlId;
    }
    if (size != null) {
      $result.size = size;
    }
    return $result;
  }
  ResizeControlRequest._() : super();
  factory ResizeControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResizeControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResizeControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..aOS(2, _omitFieldNames ? '' : 'controlId')
    ..aOM<ControlSize>(3, _omitFieldNames ? '' : 'size', subBuilder: ControlSize.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResizeControlRequest clone() => ResizeControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResizeControlRequest copyWith(void Function(ResizeControlRequest) updates) => super.copyWith((message) => updates(message as ResizeControlRequest)) as ResizeControlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResizeControlRequest create() => ResizeControlRequest._();
  ResizeControlRequest createEmptyInstance() => create();
  static $pb.PbList<ResizeControlRequest> createRepeated() => $pb.PbList<ResizeControlRequest>();
  @$core.pragma('dart2js:noInline')
  static ResizeControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResizeControlRequest>(create);
  static ResizeControlRequest? _defaultInstance;

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
  ControlSize get size => $_getN(2);
  @$pb.TagNumber(3)
  set size(ControlSize v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearSize() => clearField(3);
  @$pb.TagNumber(3)
  ControlSize ensureSize() => $_ensure(2);
}

class UpdateControlDecorationRequest extends $pb.GeneratedMessage {
  factory UpdateControlDecorationRequest({
    $core.String? layoutId,
    $core.String? controlId,
    ControlDecorations? decorations,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (controlId != null) {
      $result.controlId = controlId;
    }
    if (decorations != null) {
      $result.decorations = decorations;
    }
    return $result;
  }
  UpdateControlDecorationRequest._() : super();
  factory UpdateControlDecorationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateControlDecorationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateControlDecorationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..aOS(2, _omitFieldNames ? '' : 'controlId')
    ..aOM<ControlDecorations>(3, _omitFieldNames ? '' : 'decorations', subBuilder: ControlDecorations.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateControlDecorationRequest clone() => UpdateControlDecorationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateControlDecorationRequest copyWith(void Function(UpdateControlDecorationRequest) updates) => super.copyWith((message) => updates(message as UpdateControlDecorationRequest)) as UpdateControlDecorationRequest;

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
  factory UpdateControlBehaviorRequest({
    $core.String? layoutId,
    $core.String? controlId,
    ControlBehavior? behavior,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (controlId != null) {
      $result.controlId = controlId;
    }
    if (behavior != null) {
      $result.behavior = behavior;
    }
    return $result;
  }
  UpdateControlBehaviorRequest._() : super();
  factory UpdateControlBehaviorRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateControlBehaviorRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateControlBehaviorRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..aOS(2, _omitFieldNames ? '' : 'controlId')
    ..aOM<ControlBehavior>(3, _omitFieldNames ? '' : 'behavior', subBuilder: ControlBehavior.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateControlBehaviorRequest clone() => UpdateControlBehaviorRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateControlBehaviorRequest copyWith(void Function(UpdateControlBehaviorRequest) updates) => super.copyWith((message) => updates(message as UpdateControlBehaviorRequest)) as UpdateControlBehaviorRequest;

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
  factory RemoveControlRequest({
    $core.String? layoutId,
    $core.String? controlId,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (controlId != null) {
      $result.controlId = controlId;
    }
    return $result;
  }
  RemoveControlRequest._() : super();
  factory RemoveControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..aOS(2, _omitFieldNames ? '' : 'controlId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveControlRequest clone() => RemoveControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveControlRequest copyWith(void Function(RemoveControlRequest) updates) => super.copyWith((message) => updates(message as RemoveControlRequest)) as RemoveControlRequest;

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
  factory AddControlRequest({
    $core.String? layoutId,
    ControlType? controlType,
    ControlPosition? position,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (controlType != null) {
      $result.controlType = controlType;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  AddControlRequest._() : super();
  factory AddControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..e<ControlType>(2, _omitFieldNames ? '' : 'controlType', $pb.PbFieldType.OE, defaultOrMaker: ControlType.BUTTON, valueOf: ControlType.valueOf, enumValues: ControlType.values)
    ..aOM<ControlPosition>(3, _omitFieldNames ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddControlRequest clone() => AddControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddControlRequest copyWith(void Function(AddControlRequest) updates) => super.copyWith((message) => updates(message as AddControlRequest)) as AddControlRequest;

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
  ControlType get controlType => $_getN(1);
  @$pb.TagNumber(2)
  set controlType(ControlType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasControlType() => $_has(1);
  @$pb.TagNumber(2)
  void clearControlType() => clearField(2);

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
  factory AddExistingControlRequest({
    $core.String? layoutId,
    $core.String? node,
    ControlPosition? position,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (node != null) {
      $result.node = node;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  AddExistingControlRequest._() : super();
  factory AddExistingControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddExistingControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddExistingControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..aOS(2, _omitFieldNames ? '' : 'node')
    ..aOM<ControlPosition>(3, _omitFieldNames ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddExistingControlRequest clone() => AddExistingControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddExistingControlRequest copyWith(void Function(AddExistingControlRequest) updates) => super.copyWith((message) => updates(message as AddExistingControlRequest)) as AddExistingControlRequest;

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

class AddSequenceControlRequest extends $pb.GeneratedMessage {
  factory AddSequenceControlRequest({
    $core.String? layoutId,
    $core.int? sequenceId,
    ControlPosition? position,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (sequenceId != null) {
      $result.sequenceId = sequenceId;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  AddSequenceControlRequest._() : super();
  factory AddSequenceControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddSequenceControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddSequenceControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'sequenceId', $pb.PbFieldType.OU3)
    ..aOM<ControlPosition>(3, _omitFieldNames ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddSequenceControlRequest clone() => AddSequenceControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddSequenceControlRequest copyWith(void Function(AddSequenceControlRequest) updates) => super.copyWith((message) => updates(message as AddSequenceControlRequest)) as AddSequenceControlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddSequenceControlRequest create() => AddSequenceControlRequest._();
  AddSequenceControlRequest createEmptyInstance() => create();
  static $pb.PbList<AddSequenceControlRequest> createRepeated() => $pb.PbList<AddSequenceControlRequest>();
  @$core.pragma('dart2js:noInline')
  static AddSequenceControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddSequenceControlRequest>(create);
  static AddSequenceControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get sequenceId => $_getIZ(1);
  @$pb.TagNumber(2)
  set sequenceId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSequenceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSequenceId() => clearField(2);

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

class AddGroupControlRequest extends $pb.GeneratedMessage {
  factory AddGroupControlRequest({
    $core.String? layoutId,
    $core.int? groupId,
    ControlPosition? position,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  AddGroupControlRequest._() : super();
  factory AddGroupControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddGroupControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddGroupControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'groupId', $pb.PbFieldType.OU3)
    ..aOM<ControlPosition>(3, _omitFieldNames ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddGroupControlRequest clone() => AddGroupControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddGroupControlRequest copyWith(void Function(AddGroupControlRequest) updates) => super.copyWith((message) => updates(message as AddGroupControlRequest)) as AddGroupControlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddGroupControlRequest create() => AddGroupControlRequest._();
  AddGroupControlRequest createEmptyInstance() => create();
  static $pb.PbList<AddGroupControlRequest> createRepeated() => $pb.PbList<AddGroupControlRequest>();
  @$core.pragma('dart2js:noInline')
  static AddGroupControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddGroupControlRequest>(create);
  static AddGroupControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get groupId => $_getIZ(1);
  @$pb.TagNumber(2)
  set groupId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => clearField(2);

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

class AddPresetControlRequest extends $pb.GeneratedMessage {
  factory AddPresetControlRequest({
    $core.String? layoutId,
    $1.PresetId? presetId,
    ControlPosition? position,
  }) {
    final $result = create();
    if (layoutId != null) {
      $result.layoutId = layoutId;
    }
    if (presetId != null) {
      $result.presetId = presetId;
    }
    if (position != null) {
      $result.position = position;
    }
    return $result;
  }
  AddPresetControlRequest._() : super();
  factory AddPresetControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddPresetControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddPresetControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'layoutId')
    ..aOM<$1.PresetId>(2, _omitFieldNames ? '' : 'presetId', subBuilder: $1.PresetId.create)
    ..aOM<ControlPosition>(3, _omitFieldNames ? '' : 'position', subBuilder: ControlPosition.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddPresetControlRequest clone() => AddPresetControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddPresetControlRequest copyWith(void Function(AddPresetControlRequest) updates) => super.copyWith((message) => updates(message as AddPresetControlRequest)) as AddPresetControlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddPresetControlRequest create() => AddPresetControlRequest._();
  AddPresetControlRequest createEmptyInstance() => create();
  static $pb.PbList<AddPresetControlRequest> createRepeated() => $pb.PbList<AddPresetControlRequest>();
  @$core.pragma('dart2js:noInline')
  static AddPresetControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddPresetControlRequest>(create);
  static AddPresetControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get layoutId => $_getSZ(0);
  @$pb.TagNumber(1)
  set layoutId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLayoutId() => $_has(0);
  @$pb.TagNumber(1)
  void clearLayoutId() => clearField(1);

  @$pb.TagNumber(2)
  $1.PresetId get presetId => $_getN(1);
  @$pb.TagNumber(2)
  set presetId($1.PresetId v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPresetId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPresetId() => clearField(2);
  @$pb.TagNumber(2)
  $1.PresetId ensurePresetId() => $_ensure(1);

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
  factory Layouts({
    $core.Iterable<Layout>? layouts,
  }) {
    final $result = create();
    if (layouts != null) {
      $result.layouts.addAll(layouts);
    }
    return $result;
  }
  Layouts._() : super();
  factory Layouts.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Layouts.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Layouts', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..pc<Layout>(1, _omitFieldNames ? '' : 'layouts', $pb.PbFieldType.PM, subBuilder: Layout.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Layouts clone() => Layouts()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Layouts copyWith(void Function(Layouts) updates) => super.copyWith((message) => updates(message as Layouts)) as Layouts;

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
  factory Layout({
    $core.String? id,
    $core.Iterable<LayoutControl>? controls,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (controls != null) {
      $result.controls.addAll(controls);
    }
    return $result;
  }
  Layout._() : super();
  factory Layout.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Layout.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Layout', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..pc<LayoutControl>(2, _omitFieldNames ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: LayoutControl.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Layout clone() => Layout()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Layout copyWith(void Function(Layout) updates) => super.copyWith((message) => updates(message as Layout)) as Layout;

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

class LayoutControl_NodeControlType extends $pb.GeneratedMessage {
  factory LayoutControl_NodeControlType({
    $core.String? path,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  LayoutControl_NodeControlType._() : super();
  factory LayoutControl_NodeControlType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LayoutControl_NodeControlType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LayoutControl.NodeControlType', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LayoutControl_NodeControlType clone() => LayoutControl_NodeControlType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LayoutControl_NodeControlType copyWith(void Function(LayoutControl_NodeControlType) updates) => super.copyWith((message) => updates(message as LayoutControl_NodeControlType)) as LayoutControl_NodeControlType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LayoutControl_NodeControlType create() => LayoutControl_NodeControlType._();
  LayoutControl_NodeControlType createEmptyInstance() => create();
  static $pb.PbList<LayoutControl_NodeControlType> createRepeated() => $pb.PbList<LayoutControl_NodeControlType>();
  @$core.pragma('dart2js:noInline')
  static LayoutControl_NodeControlType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LayoutControl_NodeControlType>(create);
  static LayoutControl_NodeControlType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class LayoutControl_SequencerControlType extends $pb.GeneratedMessage {
  factory LayoutControl_SequencerControlType({
    $core.int? sequenceId,
  }) {
    final $result = create();
    if (sequenceId != null) {
      $result.sequenceId = sequenceId;
    }
    return $result;
  }
  LayoutControl_SequencerControlType._() : super();
  factory LayoutControl_SequencerControlType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LayoutControl_SequencerControlType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LayoutControl.SequencerControlType', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'sequenceId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LayoutControl_SequencerControlType clone() => LayoutControl_SequencerControlType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LayoutControl_SequencerControlType copyWith(void Function(LayoutControl_SequencerControlType) updates) => super.copyWith((message) => updates(message as LayoutControl_SequencerControlType)) as LayoutControl_SequencerControlType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LayoutControl_SequencerControlType create() => LayoutControl_SequencerControlType._();
  LayoutControl_SequencerControlType createEmptyInstance() => create();
  static $pb.PbList<LayoutControl_SequencerControlType> createRepeated() => $pb.PbList<LayoutControl_SequencerControlType>();
  @$core.pragma('dart2js:noInline')
  static LayoutControl_SequencerControlType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LayoutControl_SequencerControlType>(create);
  static LayoutControl_SequencerControlType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get sequenceId => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequenceId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequenceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequenceId() => clearField(1);
}

class LayoutControl_GroupControlType extends $pb.GeneratedMessage {
  factory LayoutControl_GroupControlType({
    $core.int? groupId,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    return $result;
  }
  LayoutControl_GroupControlType._() : super();
  factory LayoutControl_GroupControlType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LayoutControl_GroupControlType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LayoutControl.GroupControlType', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'groupId', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LayoutControl_GroupControlType clone() => LayoutControl_GroupControlType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LayoutControl_GroupControlType copyWith(void Function(LayoutControl_GroupControlType) updates) => super.copyWith((message) => updates(message as LayoutControl_GroupControlType)) as LayoutControl_GroupControlType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LayoutControl_GroupControlType create() => LayoutControl_GroupControlType._();
  LayoutControl_GroupControlType createEmptyInstance() => create();
  static $pb.PbList<LayoutControl_GroupControlType> createRepeated() => $pb.PbList<LayoutControl_GroupControlType>();
  @$core.pragma('dart2js:noInline')
  static LayoutControl_GroupControlType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LayoutControl_GroupControlType>(create);
  static LayoutControl_GroupControlType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get groupId => $_getIZ(0);
  @$pb.TagNumber(1)
  set groupId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);
}

class LayoutControl_PresetControlType extends $pb.GeneratedMessage {
  factory LayoutControl_PresetControlType({
    $1.PresetId? presetId,
  }) {
    final $result = create();
    if (presetId != null) {
      $result.presetId = presetId;
    }
    return $result;
  }
  LayoutControl_PresetControlType._() : super();
  factory LayoutControl_PresetControlType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LayoutControl_PresetControlType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LayoutControl.PresetControlType', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOM<$1.PresetId>(1, _omitFieldNames ? '' : 'presetId', subBuilder: $1.PresetId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LayoutControl_PresetControlType clone() => LayoutControl_PresetControlType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LayoutControl_PresetControlType copyWith(void Function(LayoutControl_PresetControlType) updates) => super.copyWith((message) => updates(message as LayoutControl_PresetControlType)) as LayoutControl_PresetControlType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LayoutControl_PresetControlType create() => LayoutControl_PresetControlType._();
  LayoutControl_PresetControlType createEmptyInstance() => create();
  static $pb.PbList<LayoutControl_PresetControlType> createRepeated() => $pb.PbList<LayoutControl_PresetControlType>();
  @$core.pragma('dart2js:noInline')
  static LayoutControl_PresetControlType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LayoutControl_PresetControlType>(create);
  static LayoutControl_PresetControlType? _defaultInstance;

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

enum LayoutControl_ControlType {
  node, 
  sequencer, 
  group, 
  preset, 
  notSet
}

class LayoutControl extends $pb.GeneratedMessage {
  factory LayoutControl({
    $core.String? id,
    ControlPosition? position,
    ControlSize? size,
    $core.String? label,
    ControlDecorations? decoration,
    ControlBehavior? behavior,
    LayoutControl_NodeControlType? node,
    LayoutControl_SequencerControlType? sequencer,
    LayoutControl_GroupControlType? group,
    LayoutControl_PresetControlType? preset,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (position != null) {
      $result.position = position;
    }
    if (size != null) {
      $result.size = size;
    }
    if (label != null) {
      $result.label = label;
    }
    if (decoration != null) {
      $result.decoration = decoration;
    }
    if (behavior != null) {
      $result.behavior = behavior;
    }
    if (node != null) {
      $result.node = node;
    }
    if (sequencer != null) {
      $result.sequencer = sequencer;
    }
    if (group != null) {
      $result.group = group;
    }
    if (preset != null) {
      $result.preset = preset;
    }
    return $result;
  }
  LayoutControl._() : super();
  factory LayoutControl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LayoutControl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, LayoutControl_ControlType> _LayoutControl_ControlTypeByTag = {
    7 : LayoutControl_ControlType.node,
    8 : LayoutControl_ControlType.sequencer,
    9 : LayoutControl_ControlType.group,
    10 : LayoutControl_ControlType.preset,
    0 : LayoutControl_ControlType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LayoutControl', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..oo(0, [7, 8, 9, 10])
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<ControlPosition>(2, _omitFieldNames ? '' : 'position', subBuilder: ControlPosition.create)
    ..aOM<ControlSize>(3, _omitFieldNames ? '' : 'size', subBuilder: ControlSize.create)
    ..aOS(4, _omitFieldNames ? '' : 'label')
    ..aOM<ControlDecorations>(5, _omitFieldNames ? '' : 'decoration', subBuilder: ControlDecorations.create)
    ..aOM<ControlBehavior>(6, _omitFieldNames ? '' : 'behavior', subBuilder: ControlBehavior.create)
    ..aOM<LayoutControl_NodeControlType>(7, _omitFieldNames ? '' : 'node', subBuilder: LayoutControl_NodeControlType.create)
    ..aOM<LayoutControl_SequencerControlType>(8, _omitFieldNames ? '' : 'sequencer', subBuilder: LayoutControl_SequencerControlType.create)
    ..aOM<LayoutControl_GroupControlType>(9, _omitFieldNames ? '' : 'group', subBuilder: LayoutControl_GroupControlType.create)
    ..aOM<LayoutControl_PresetControlType>(10, _omitFieldNames ? '' : 'preset', subBuilder: LayoutControl_PresetControlType.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LayoutControl clone() => LayoutControl()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LayoutControl copyWith(void Function(LayoutControl) updates) => super.copyWith((message) => updates(message as LayoutControl)) as LayoutControl;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LayoutControl create() => LayoutControl._();
  LayoutControl createEmptyInstance() => create();
  static $pb.PbList<LayoutControl> createRepeated() => $pb.PbList<LayoutControl>();
  @$core.pragma('dart2js:noInline')
  static LayoutControl getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LayoutControl>(create);
  static LayoutControl? _defaultInstance;

  LayoutControl_ControlType whichControlType() => _LayoutControl_ControlTypeByTag[$_whichOneof(0)]!;
  void clearControlType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

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

  @$pb.TagNumber(7)
  LayoutControl_NodeControlType get node => $_getN(6);
  @$pb.TagNumber(7)
  set node(LayoutControl_NodeControlType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasNode() => $_has(6);
  @$pb.TagNumber(7)
  void clearNode() => clearField(7);
  @$pb.TagNumber(7)
  LayoutControl_NodeControlType ensureNode() => $_ensure(6);

  @$pb.TagNumber(8)
  LayoutControl_SequencerControlType get sequencer => $_getN(7);
  @$pb.TagNumber(8)
  set sequencer(LayoutControl_SequencerControlType v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasSequencer() => $_has(7);
  @$pb.TagNumber(8)
  void clearSequencer() => clearField(8);
  @$pb.TagNumber(8)
  LayoutControl_SequencerControlType ensureSequencer() => $_ensure(7);

  @$pb.TagNumber(9)
  LayoutControl_GroupControlType get group => $_getN(8);
  @$pb.TagNumber(9)
  set group(LayoutControl_GroupControlType v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasGroup() => $_has(8);
  @$pb.TagNumber(9)
  void clearGroup() => clearField(9);
  @$pb.TagNumber(9)
  LayoutControl_GroupControlType ensureGroup() => $_ensure(8);

  @$pb.TagNumber(10)
  LayoutControl_PresetControlType get preset => $_getN(9);
  @$pb.TagNumber(10)
  set preset(LayoutControl_PresetControlType v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasPreset() => $_has(9);
  @$pb.TagNumber(10)
  void clearPreset() => clearField(10);
  @$pb.TagNumber(10)
  LayoutControl_PresetControlType ensurePreset() => $_ensure(9);
}

class ControlPosition extends $pb.GeneratedMessage {
  factory ControlPosition({
    $fixnum.Int64? x,
    $fixnum.Int64? y,
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
  ControlPosition._() : super();
  factory ControlPosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlPosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ControlPosition', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlPosition clone() => ControlPosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlPosition copyWith(void Function(ControlPosition) updates) => super.copyWith((message) => updates(message as ControlPosition)) as ControlPosition;

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
  factory ControlSize({
    $fixnum.Int64? width,
    $fixnum.Int64? height,
  }) {
    final $result = create();
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  ControlSize._() : super();
  factory ControlSize.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlSize.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ControlSize', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlSize clone() => ControlSize()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlSize copyWith(void Function(ControlSize) updates) => super.copyWith((message) => updates(message as ControlSize)) as ControlSize;

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
  factory ControlDecorations({
    $core.bool? hasColor,
    Color? color_2,
    $core.bool? hasImage,
    $core.List<$core.int>? image_4,
  }) {
    final $result = create();
    if (hasColor != null) {
      $result.hasColor = hasColor;
    }
    if (color_2 != null) {
      $result.color_2 = color_2;
    }
    if (hasImage != null) {
      $result.hasImage = hasImage;
    }
    if (image_4 != null) {
      $result.image_4 = image_4;
    }
    return $result;
  }
  ControlDecorations._() : super();
  factory ControlDecorations.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlDecorations.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ControlDecorations', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'hasColor')
    ..aOM<Color>(2, _omitFieldNames ? '' : 'color', subBuilder: Color.create)
    ..aOB(3, _omitFieldNames ? '' : 'hasImage')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlDecorations clone() => ControlDecorations()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlDecorations copyWith(void Function(ControlDecorations) updates) => super.copyWith((message) => updates(message as ControlDecorations)) as ControlDecorations;

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
  factory Color({
    $core.double? red,
    $core.double? green,
    $core.double? blue,
  }) {
    final $result = create();
    if (red != null) {
      $result.red = red;
    }
    if (green != null) {
      $result.green = green;
    }
    if (blue != null) {
      $result.blue = blue;
    }
    return $result;
  }
  Color._() : super();
  factory Color.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Color.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Color', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'red', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'green', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'blue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Color clone() => Color()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Color copyWith(void Function(Color) updates) => super.copyWith((message) => updates(message as Color)) as Color;

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
  factory ControlBehavior({
    SequencerControlBehavior? sequencer,
  }) {
    final $result = create();
    if (sequencer != null) {
      $result.sequencer = sequencer;
    }
    return $result;
  }
  ControlBehavior._() : super();
  factory ControlBehavior.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlBehavior.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ControlBehavior', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOM<SequencerControlBehavior>(1, _omitFieldNames ? '' : 'sequencer', subBuilder: SequencerControlBehavior.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlBehavior clone() => ControlBehavior()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlBehavior copyWith(void Function(ControlBehavior) updates) => super.copyWith((message) => updates(message as ControlBehavior)) as ControlBehavior;

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
  factory SequencerControlBehavior({
    SequencerControlBehavior_ClickBehavior? clickBehavior,
  }) {
    final $result = create();
    if (clickBehavior != null) {
      $result.clickBehavior = clickBehavior;
    }
    return $result;
  }
  SequencerControlBehavior._() : super();
  factory SequencerControlBehavior.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequencerControlBehavior.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SequencerControlBehavior', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..e<SequencerControlBehavior_ClickBehavior>(1, _omitFieldNames ? '' : 'clickBehavior', $pb.PbFieldType.OE, defaultOrMaker: SequencerControlBehavior_ClickBehavior.GO_FORWARD, valueOf: SequencerControlBehavior_ClickBehavior.valueOf, enumValues: SequencerControlBehavior_ClickBehavior.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequencerControlBehavior clone() => SequencerControlBehavior()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequencerControlBehavior copyWith(void Function(SequencerControlBehavior) updates) => super.copyWith((message) => updates(message as SequencerControlBehavior)) as SequencerControlBehavior;

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
  factory ReadFaderValueRequest({
    $core.String? node,
  }) {
    final $result = create();
    if (node != null) {
      $result.node = node;
    }
    return $result;
  }
  ReadFaderValueRequest._() : super();
  factory ReadFaderValueRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadFaderValueRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReadFaderValueRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'node')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadFaderValueRequest clone() => ReadFaderValueRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadFaderValueRequest copyWith(void Function(ReadFaderValueRequest) updates) => super.copyWith((message) => updates(message as ReadFaderValueRequest)) as ReadFaderValueRequest;

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
  factory FaderValueResponse({
    $core.double? value,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  FaderValueResponse._() : super();
  factory FaderValueResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FaderValueResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FaderValueResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.layouts'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FaderValueResponse clone() => FaderValueResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FaderValueResponse copyWith(void Function(FaderValueResponse) updates) => super.copyWith((message) => updates(message as FaderValueResponse)) as FaderValueResponse;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
