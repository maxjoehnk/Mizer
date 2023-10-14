//
//  Generated code. Do not modify.
//  source: surfaces.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Surface extends $pb.GeneratedMessage {
  factory Surface({
    $core.String? id,
    $core.String? name,
    $core.Iterable<SurfaceSection>? sections,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (sections != null) {
      $result.sections.addAll(sections);
    }
    return $result;
  }
  Surface._() : super();
  factory Surface.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Surface.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Surface', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.surfaces'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pc<SurfaceSection>(3, _omitFieldNames ? '' : 'sections', $pb.PbFieldType.PM, subBuilder: SurfaceSection.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Surface clone() => Surface()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Surface copyWith(void Function(Surface) updates) => super.copyWith((message) => updates(message as Surface)) as Surface;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Surface create() => Surface._();
  Surface createEmptyInstance() => create();
  static $pb.PbList<Surface> createRepeated() => $pb.PbList<Surface>();
  @$core.pragma('dart2js:noInline')
  static Surface getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Surface>(create);
  static Surface? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.List<SurfaceSection> get sections => $_getList(2);
}

class Surfaces extends $pb.GeneratedMessage {
  factory Surfaces({
    $core.Iterable<Surface>? surfaces,
  }) {
    final $result = create();
    if (surfaces != null) {
      $result.surfaces.addAll(surfaces);
    }
    return $result;
  }
  Surfaces._() : super();
  factory Surfaces.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Surfaces.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Surfaces', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.surfaces'), createEmptyInstance: create)
    ..pc<Surface>(1, _omitFieldNames ? '' : 'surfaces', $pb.PbFieldType.PM, subBuilder: Surface.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Surfaces clone() => Surfaces()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Surfaces copyWith(void Function(Surfaces) updates) => super.copyWith((message) => updates(message as Surfaces)) as Surfaces;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Surfaces create() => Surfaces._();
  Surfaces createEmptyInstance() => create();
  static $pb.PbList<Surfaces> createRepeated() => $pb.PbList<Surfaces>();
  @$core.pragma('dart2js:noInline')
  static Surfaces getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Surfaces>(create);
  static Surfaces? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Surface> get surfaces => $_getList(0);
}

class SurfaceSection extends $pb.GeneratedMessage {
  factory SurfaceSection({
    $core.int? id,
    $core.String? name,
    SurfaceTransform? input,
    SurfaceTransform? output,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (input != null) {
      $result.input = input;
    }
    if (output != null) {
      $result.output = output;
    }
    return $result;
  }
  SurfaceSection._() : super();
  factory SurfaceSection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SurfaceSection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SurfaceSection', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.surfaces'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOM<SurfaceTransform>(3, _omitFieldNames ? '' : 'input', subBuilder: SurfaceTransform.create)
    ..aOM<SurfaceTransform>(4, _omitFieldNames ? '' : 'output', subBuilder: SurfaceTransform.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SurfaceSection clone() => SurfaceSection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SurfaceSection copyWith(void Function(SurfaceSection) updates) => super.copyWith((message) => updates(message as SurfaceSection)) as SurfaceSection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SurfaceSection create() => SurfaceSection._();
  SurfaceSection createEmptyInstance() => create();
  static $pb.PbList<SurfaceSection> createRepeated() => $pb.PbList<SurfaceSection>();
  @$core.pragma('dart2js:noInline')
  static SurfaceSection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SurfaceSection>(create);
  static SurfaceSection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
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

  @$pb.TagNumber(3)
  SurfaceTransform get input => $_getN(2);
  @$pb.TagNumber(3)
  set input(SurfaceTransform v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasInput() => $_has(2);
  @$pb.TagNumber(3)
  void clearInput() => clearField(3);
  @$pb.TagNumber(3)
  SurfaceTransform ensureInput() => $_ensure(2);

  @$pb.TagNumber(4)
  SurfaceTransform get output => $_getN(3);
  @$pb.TagNumber(4)
  set output(SurfaceTransform v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutput() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutput() => clearField(4);
  @$pb.TagNumber(4)
  SurfaceTransform ensureOutput() => $_ensure(3);
}

class SurfaceTransform extends $pb.GeneratedMessage {
  factory SurfaceTransform({
    SurfaceTransformPoint? topLeft,
    SurfaceTransformPoint? topRight,
    SurfaceTransformPoint? bottomLeft,
    SurfaceTransformPoint? bottomRight,
  }) {
    final $result = create();
    if (topLeft != null) {
      $result.topLeft = topLeft;
    }
    if (topRight != null) {
      $result.topRight = topRight;
    }
    if (bottomLeft != null) {
      $result.bottomLeft = bottomLeft;
    }
    if (bottomRight != null) {
      $result.bottomRight = bottomRight;
    }
    return $result;
  }
  SurfaceTransform._() : super();
  factory SurfaceTransform.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SurfaceTransform.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SurfaceTransform', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.surfaces'), createEmptyInstance: create)
    ..aOM<SurfaceTransformPoint>(1, _omitFieldNames ? '' : 'topLeft', subBuilder: SurfaceTransformPoint.create)
    ..aOM<SurfaceTransformPoint>(2, _omitFieldNames ? '' : 'topRight', subBuilder: SurfaceTransformPoint.create)
    ..aOM<SurfaceTransformPoint>(3, _omitFieldNames ? '' : 'bottomLeft', subBuilder: SurfaceTransformPoint.create)
    ..aOM<SurfaceTransformPoint>(4, _omitFieldNames ? '' : 'bottomRight', subBuilder: SurfaceTransformPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SurfaceTransform clone() => SurfaceTransform()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SurfaceTransform copyWith(void Function(SurfaceTransform) updates) => super.copyWith((message) => updates(message as SurfaceTransform)) as SurfaceTransform;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SurfaceTransform create() => SurfaceTransform._();
  SurfaceTransform createEmptyInstance() => create();
  static $pb.PbList<SurfaceTransform> createRepeated() => $pb.PbList<SurfaceTransform>();
  @$core.pragma('dart2js:noInline')
  static SurfaceTransform getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SurfaceTransform>(create);
  static SurfaceTransform? _defaultInstance;

  @$pb.TagNumber(1)
  SurfaceTransformPoint get topLeft => $_getN(0);
  @$pb.TagNumber(1)
  set topLeft(SurfaceTransformPoint v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTopLeft() => $_has(0);
  @$pb.TagNumber(1)
  void clearTopLeft() => clearField(1);
  @$pb.TagNumber(1)
  SurfaceTransformPoint ensureTopLeft() => $_ensure(0);

  @$pb.TagNumber(2)
  SurfaceTransformPoint get topRight => $_getN(1);
  @$pb.TagNumber(2)
  set topRight(SurfaceTransformPoint v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTopRight() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopRight() => clearField(2);
  @$pb.TagNumber(2)
  SurfaceTransformPoint ensureTopRight() => $_ensure(1);

  @$pb.TagNumber(3)
  SurfaceTransformPoint get bottomLeft => $_getN(2);
  @$pb.TagNumber(3)
  set bottomLeft(SurfaceTransformPoint v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBottomLeft() => $_has(2);
  @$pb.TagNumber(3)
  void clearBottomLeft() => clearField(3);
  @$pb.TagNumber(3)
  SurfaceTransformPoint ensureBottomLeft() => $_ensure(2);

  @$pb.TagNumber(4)
  SurfaceTransformPoint get bottomRight => $_getN(3);
  @$pb.TagNumber(4)
  set bottomRight(SurfaceTransformPoint v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBottomRight() => $_has(3);
  @$pb.TagNumber(4)
  void clearBottomRight() => clearField(4);
  @$pb.TagNumber(4)
  SurfaceTransformPoint ensureBottomRight() => $_ensure(3);
}

class SurfaceTransformPoint extends $pb.GeneratedMessage {
  factory SurfaceTransformPoint({
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
  SurfaceTransformPoint._() : super();
  factory SurfaceTransformPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SurfaceTransformPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SurfaceTransformPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.surfaces'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SurfaceTransformPoint clone() => SurfaceTransformPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SurfaceTransformPoint copyWith(void Function(SurfaceTransformPoint) updates) => super.copyWith((message) => updates(message as SurfaceTransformPoint)) as SurfaceTransformPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SurfaceTransformPoint create() => SurfaceTransformPoint._();
  SurfaceTransformPoint createEmptyInstance() => create();
  static $pb.PbList<SurfaceTransformPoint> createRepeated() => $pb.PbList<SurfaceTransformPoint>();
  @$core.pragma('dart2js:noInline')
  static SurfaceTransformPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SurfaceTransformPoint>(create);
  static SurfaceTransformPoint? _defaultInstance;

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

class UpdateSectionTransform extends $pb.GeneratedMessage {
  factory UpdateSectionTransform({
    $core.String? surfaceId,
    $core.int? sectionId,
    SurfaceTransform? transform,
  }) {
    final $result = create();
    if (surfaceId != null) {
      $result.surfaceId = surfaceId;
    }
    if (sectionId != null) {
      $result.sectionId = sectionId;
    }
    if (transform != null) {
      $result.transform = transform;
    }
    return $result;
  }
  UpdateSectionTransform._() : super();
  factory UpdateSectionTransform.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSectionTransform.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSectionTransform', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.surfaces'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'surfaceId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'sectionId', $pb.PbFieldType.OU3)
    ..aOM<SurfaceTransform>(3, _omitFieldNames ? '' : 'transform', subBuilder: SurfaceTransform.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSectionTransform clone() => UpdateSectionTransform()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSectionTransform copyWith(void Function(UpdateSectionTransform) updates) => super.copyWith((message) => updates(message as UpdateSectionTransform)) as UpdateSectionTransform;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSectionTransform create() => UpdateSectionTransform._();
  UpdateSectionTransform createEmptyInstance() => create();
  static $pb.PbList<UpdateSectionTransform> createRepeated() => $pb.PbList<UpdateSectionTransform>();
  @$core.pragma('dart2js:noInline')
  static UpdateSectionTransform getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSectionTransform>(create);
  static UpdateSectionTransform? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get surfaceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set surfaceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSurfaceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSurfaceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get sectionId => $_getIZ(1);
  @$pb.TagNumber(2)
  set sectionId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSectionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSectionId() => clearField(2);

  @$pb.TagNumber(3)
  SurfaceTransform get transform => $_getN(2);
  @$pb.TagNumber(3)
  set transform(SurfaceTransform v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransform() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransform() => clearField(3);
  @$pb.TagNumber(3)
  SurfaceTransform ensureTransform() => $_ensure(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
