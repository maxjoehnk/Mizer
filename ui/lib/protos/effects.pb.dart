///
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'sequencer.pb.dart' as $1;

import 'fixtures.pbenum.dart' as $0;

class GetEffectsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEffectsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetEffectsRequest._() : super();
  factory GetEffectsRequest() => create();
  factory GetEffectsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEffectsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEffectsRequest clone() => GetEffectsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEffectsRequest copyWith(void Function(GetEffectsRequest) updates) => super.copyWith((message) => updates(message as GetEffectsRequest)) as GetEffectsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEffectsRequest create() => GetEffectsRequest._();
  GetEffectsRequest createEmptyInstance() => create();
  static $pb.PbList<GetEffectsRequest> createRepeated() => $pb.PbList<GetEffectsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEffectsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEffectsRequest>(create);
  static GetEffectsRequest? _defaultInstance;
}

class Effects extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Effects', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..pc<Effect>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effects', $pb.PbFieldType.PM, subBuilder: Effect.create)
    ..hasRequiredFields = false
  ;

  Effects._() : super();
  factory Effects({
    $core.Iterable<Effect>? effects,
  }) {
    final _result = create();
    if (effects != null) {
      _result.effects.addAll(effects);
    }
    return _result;
  }
  factory Effects.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Effects.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Effects clone() => Effects()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Effects copyWith(void Function(Effects) updates) => super.copyWith((message) => updates(message as Effects)) as Effects; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Effects create() => Effects._();
  Effects createEmptyInstance() => create();
  static $pb.PbList<Effects> createRepeated() => $pb.PbList<Effects>();
  @$core.pragma('dart2js:noInline')
  static Effects getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Effects>(create);
  static Effects? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Effect> get effects => $_getList(0);
}

class Effect extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Effect', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<EffectStep>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: EffectStep.create)
    ..hasRequiredFields = false
  ;

  Effect._() : super();
  factory Effect({
    $core.int? id,
    $core.String? name,
    $core.Iterable<EffectStep>? steps,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    return _result;
  }
  factory Effect.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Effect.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Effect clone() => Effect()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Effect copyWith(void Function(Effect) updates) => super.copyWith((message) => updates(message as Effect)) as Effect; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Effect create() => Effect._();
  Effect createEmptyInstance() => create();
  static $pb.PbList<Effect> createRepeated() => $pb.PbList<Effect>();
  @$core.pragma('dart2js:noInline')
  static Effect getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Effect>(create);
  static Effect? _defaultInstance;

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
  $core.List<EffectStep> get steps => $_getList(2);
}

class EffectStep extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EffectStep', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..pc<EffectChannel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: EffectChannel.create)
    ..hasRequiredFields = false
  ;

  EffectStep._() : super();
  factory EffectStep({
    $core.Iterable<EffectChannel>? channels,
  }) {
    final _result = create();
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    return _result;
  }
  factory EffectStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EffectStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EffectStep clone() => EffectStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EffectStep copyWith(void Function(EffectStep) updates) => super.copyWith((message) => updates(message as EffectStep)) as EffectStep; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EffectStep create() => EffectStep._();
  EffectStep createEmptyInstance() => create();
  static $pb.PbList<EffectStep> createRepeated() => $pb.PbList<EffectStep>();
  @$core.pragma('dart2js:noInline')
  static EffectStep getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EffectStep>(create);
  static EffectStep? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<EffectChannel> get channels => $_getList(0);
}

enum EffectChannel_ControlPoint {
  simple, 
  quadratic, 
  cubic, 
  notSet
}

class EffectChannel extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, EffectChannel_ControlPoint> _EffectChannel_ControlPointByTag = {
    3 : EffectChannel_ControlPoint.simple,
    4 : EffectChannel_ControlPoint.quadratic,
    5 : EffectChannel_ControlPoint.cubic,
    0 : EffectChannel_ControlPoint.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EffectChannel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..e<$0.FixtureControl>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'control', $pb.PbFieldType.OE, defaultOrMaker: $0.FixtureControl.INTENSITY, valueOf: $0.FixtureControl.valueOf, enumValues: $0.FixtureControl.values)
    ..aOM<$1.CueValue>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', subBuilder: $1.CueValue.create)
    ..aOM<SimpleControlPoint>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'simple', subBuilder: SimpleControlPoint.create)
    ..aOM<QuadraticControlPoint>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quadratic', subBuilder: QuadraticControlPoint.create)
    ..aOM<CubicControlPoint>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cubic', subBuilder: CubicControlPoint.create)
    ..hasRequiredFields = false
  ;

  EffectChannel._() : super();
  factory EffectChannel({
    $0.FixtureControl? control,
    $1.CueValue? value,
    SimpleControlPoint? simple,
    QuadraticControlPoint? quadratic,
    CubicControlPoint? cubic,
  }) {
    final _result = create();
    if (control != null) {
      _result.control = control;
    }
    if (value != null) {
      _result.value = value;
    }
    if (simple != null) {
      _result.simple = simple;
    }
    if (quadratic != null) {
      _result.quadratic = quadratic;
    }
    if (cubic != null) {
      _result.cubic = cubic;
    }
    return _result;
  }
  factory EffectChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EffectChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EffectChannel clone() => EffectChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EffectChannel copyWith(void Function(EffectChannel) updates) => super.copyWith((message) => updates(message as EffectChannel)) as EffectChannel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EffectChannel create() => EffectChannel._();
  EffectChannel createEmptyInstance() => create();
  static $pb.PbList<EffectChannel> createRepeated() => $pb.PbList<EffectChannel>();
  @$core.pragma('dart2js:noInline')
  static EffectChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EffectChannel>(create);
  static EffectChannel? _defaultInstance;

  EffectChannel_ControlPoint whichControlPoint() => _EffectChannel_ControlPointByTag[$_whichOneof(0)]!;
  void clearControlPoint() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.FixtureControl get control => $_getN(0);
  @$pb.TagNumber(1)
  set control($0.FixtureControl v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasControl() => $_has(0);
  @$pb.TagNumber(1)
  void clearControl() => clearField(1);

  @$pb.TagNumber(2)
  $1.CueValue get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($1.CueValue v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  $1.CueValue ensureValue() => $_ensure(1);

  @$pb.TagNumber(3)
  SimpleControlPoint get simple => $_getN(2);
  @$pb.TagNumber(3)
  set simple(SimpleControlPoint v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSimple() => $_has(2);
  @$pb.TagNumber(3)
  void clearSimple() => clearField(3);
  @$pb.TagNumber(3)
  SimpleControlPoint ensureSimple() => $_ensure(2);

  @$pb.TagNumber(4)
  QuadraticControlPoint get quadratic => $_getN(3);
  @$pb.TagNumber(4)
  set quadratic(QuadraticControlPoint v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasQuadratic() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuadratic() => clearField(4);
  @$pb.TagNumber(4)
  QuadraticControlPoint ensureQuadratic() => $_ensure(3);

  @$pb.TagNumber(5)
  CubicControlPoint get cubic => $_getN(4);
  @$pb.TagNumber(5)
  set cubic(CubicControlPoint v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCubic() => $_has(4);
  @$pb.TagNumber(5)
  void clearCubic() => clearField(5);
  @$pb.TagNumber(5)
  CubicControlPoint ensureCubic() => $_ensure(4);
}

class SimpleControlPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SimpleControlPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SimpleControlPoint._() : super();
  factory SimpleControlPoint() => create();
  factory SimpleControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SimpleControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SimpleControlPoint clone() => SimpleControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SimpleControlPoint copyWith(void Function(SimpleControlPoint) updates) => super.copyWith((message) => updates(message as SimpleControlPoint)) as SimpleControlPoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SimpleControlPoint create() => SimpleControlPoint._();
  SimpleControlPoint createEmptyInstance() => create();
  static $pb.PbList<SimpleControlPoint> createRepeated() => $pb.PbList<SimpleControlPoint>();
  @$core.pragma('dart2js:noInline')
  static SimpleControlPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SimpleControlPoint>(create);
  static SimpleControlPoint? _defaultInstance;
}

class QuadraticControlPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QuadraticControlPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  QuadraticControlPoint._() : super();
  factory QuadraticControlPoint({
    $core.double? c0a,
    $core.double? c0b,
  }) {
    final _result = create();
    if (c0a != null) {
      _result.c0a = c0a;
    }
    if (c0b != null) {
      _result.c0b = c0b;
    }
    return _result;
  }
  factory QuadraticControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuadraticControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuadraticControlPoint clone() => QuadraticControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuadraticControlPoint copyWith(void Function(QuadraticControlPoint) updates) => super.copyWith((message) => updates(message as QuadraticControlPoint)) as QuadraticControlPoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuadraticControlPoint create() => QuadraticControlPoint._();
  QuadraticControlPoint createEmptyInstance() => create();
  static $pb.PbList<QuadraticControlPoint> createRepeated() => $pb.PbList<QuadraticControlPoint>();
  @$core.pragma('dart2js:noInline')
  static QuadraticControlPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuadraticControlPoint>(create);
  static QuadraticControlPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get c0a => $_getN(0);
  @$pb.TagNumber(1)
  set c0a($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasC0a() => $_has(0);
  @$pb.TagNumber(1)
  void clearC0a() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get c0b => $_getN(1);
  @$pb.TagNumber(2)
  set c0b($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasC0b() => $_has(1);
  @$pb.TagNumber(2)
  void clearC0b() => clearField(2);
}

class CubicControlPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CubicControlPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.effects'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0b', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1a', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CubicControlPoint._() : super();
  factory CubicControlPoint({
    $core.double? c0a,
    $core.double? c0b,
    $core.double? c1a,
    $core.double? c1b,
  }) {
    final _result = create();
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
  factory CubicControlPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CubicControlPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CubicControlPoint clone() => CubicControlPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CubicControlPoint copyWith(void Function(CubicControlPoint) updates) => super.copyWith((message) => updates(message as CubicControlPoint)) as CubicControlPoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CubicControlPoint create() => CubicControlPoint._();
  CubicControlPoint createEmptyInstance() => create();
  static $pb.PbList<CubicControlPoint> createRepeated() => $pb.PbList<CubicControlPoint>();
  @$core.pragma('dart2js:noInline')
  static CubicControlPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CubicControlPoint>(create);
  static CubicControlPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get c0a => $_getN(0);
  @$pb.TagNumber(1)
  set c0a($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasC0a() => $_has(0);
  @$pb.TagNumber(1)
  void clearC0a() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get c0b => $_getN(1);
  @$pb.TagNumber(2)
  set c0b($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasC0b() => $_has(1);
  @$pb.TagNumber(2)
  void clearC0b() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get c1a => $_getN(2);
  @$pb.TagNumber(3)
  set c1a($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasC1a() => $_has(2);
  @$pb.TagNumber(3)
  void clearC1a() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get c1b => $_getN(3);
  @$pb.TagNumber(4)
  set c1b($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasC1b() => $_has(3);
  @$pb.TagNumber(4)
  void clearC1b() => clearField(4);
}

