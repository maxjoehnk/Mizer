///
//  Generated code. Do not modify.
//  source: timecode.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AddTimecodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddTimecodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  AddTimecodeRequest._() : super();
  factory AddTimecodeRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory AddTimecodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTimecodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTimecodeRequest clone() => AddTimecodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTimecodeRequest copyWith(void Function(AddTimecodeRequest) updates) => super.copyWith((message) => updates(message as AddTimecodeRequest)) as AddTimecodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddTimecodeRequest create() => AddTimecodeRequest._();
  AddTimecodeRequest createEmptyInstance() => create();
  static $pb.PbList<AddTimecodeRequest> createRepeated() => $pb.PbList<AddTimecodeRequest>();
  @$core.pragma('dart2js:noInline')
  static AddTimecodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddTimecodeRequest>(create);
  static AddTimecodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class RenameTimecodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenameTimecodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  RenameTimecodeRequest._() : super();
  factory RenameTimecodeRequest({
    $core.int? id,
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
  factory RenameTimecodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameTimecodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameTimecodeRequest clone() => RenameTimecodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameTimecodeRequest copyWith(void Function(RenameTimecodeRequest) updates) => super.copyWith((message) => updates(message as RenameTimecodeRequest)) as RenameTimecodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenameTimecodeRequest create() => RenameTimecodeRequest._();
  RenameTimecodeRequest createEmptyInstance() => create();
  static $pb.PbList<RenameTimecodeRequest> createRepeated() => $pb.PbList<RenameTimecodeRequest>();
  @$core.pragma('dart2js:noInline')
  static RenameTimecodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameTimecodeRequest>(create);
  static RenameTimecodeRequest? _defaultInstance;

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
}

class DeleteTimecodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteTimecodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DeleteTimecodeRequest._() : super();
  factory DeleteTimecodeRequest({
    $core.int? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory DeleteTimecodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteTimecodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteTimecodeRequest clone() => DeleteTimecodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteTimecodeRequest copyWith(void Function(DeleteTimecodeRequest) updates) => super.copyWith((message) => updates(message as DeleteTimecodeRequest)) as DeleteTimecodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteTimecodeRequest create() => DeleteTimecodeRequest._();
  DeleteTimecodeRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteTimecodeRequest> createRepeated() => $pb.PbList<DeleteTimecodeRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteTimecodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteTimecodeRequest>(create);
  static DeleteTimecodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class AddTimecodeControlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddTimecodeControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  AddTimecodeControlRequest._() : super();
  factory AddTimecodeControlRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory AddTimecodeControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddTimecodeControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddTimecodeControlRequest clone() => AddTimecodeControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddTimecodeControlRequest copyWith(void Function(AddTimecodeControlRequest) updates) => super.copyWith((message) => updates(message as AddTimecodeControlRequest)) as AddTimecodeControlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddTimecodeControlRequest create() => AddTimecodeControlRequest._();
  AddTimecodeControlRequest createEmptyInstance() => create();
  static $pb.PbList<AddTimecodeControlRequest> createRepeated() => $pb.PbList<AddTimecodeControlRequest>();
  @$core.pragma('dart2js:noInline')
  static AddTimecodeControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddTimecodeControlRequest>(create);
  static AddTimecodeControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class RenameTimecodeControlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RenameTimecodeControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  RenameTimecodeControlRequest._() : super();
  factory RenameTimecodeControlRequest({
    $core.int? id,
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
  factory RenameTimecodeControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RenameTimecodeControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RenameTimecodeControlRequest clone() => RenameTimecodeControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RenameTimecodeControlRequest copyWith(void Function(RenameTimecodeControlRequest) updates) => super.copyWith((message) => updates(message as RenameTimecodeControlRequest)) as RenameTimecodeControlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RenameTimecodeControlRequest create() => RenameTimecodeControlRequest._();
  RenameTimecodeControlRequest createEmptyInstance() => create();
  static $pb.PbList<RenameTimecodeControlRequest> createRepeated() => $pb.PbList<RenameTimecodeControlRequest>();
  @$core.pragma('dart2js:noInline')
  static RenameTimecodeControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RenameTimecodeControlRequest>(create);
  static RenameTimecodeControlRequest? _defaultInstance;

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
}

class DeleteTimecodeControlRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteTimecodeControlRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DeleteTimecodeControlRequest._() : super();
  factory DeleteTimecodeControlRequest({
    $core.int? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory DeleteTimecodeControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteTimecodeControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteTimecodeControlRequest clone() => DeleteTimecodeControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteTimecodeControlRequest copyWith(void Function(DeleteTimecodeControlRequest) updates) => super.copyWith((message) => updates(message as DeleteTimecodeControlRequest)) as DeleteTimecodeControlRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteTimecodeControlRequest create() => DeleteTimecodeControlRequest._();
  DeleteTimecodeControlRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteTimecodeControlRequest> createRepeated() => $pb.PbList<DeleteTimecodeControlRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteTimecodeControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteTimecodeControlRequest>(create);
  static DeleteTimecodeControlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class AllTimecodes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AllTimecodes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..pc<Timecode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timecodes', $pb.PbFieldType.PM, subBuilder: Timecode.create)
    ..pc<TimecodeControl>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: TimecodeControl.create)
    ..hasRequiredFields = false
  ;

  AllTimecodes._() : super();
  factory AllTimecodes({
    $core.Iterable<Timecode>? timecodes,
    $core.Iterable<TimecodeControl>? controls,
  }) {
    final _result = create();
    if (timecodes != null) {
      _result.timecodes.addAll(timecodes);
    }
    if (controls != null) {
      _result.controls.addAll(controls);
    }
    return _result;
  }
  factory AllTimecodes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AllTimecodes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AllTimecodes clone() => AllTimecodes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AllTimecodes copyWith(void Function(AllTimecodes) updates) => super.copyWith((message) => updates(message as AllTimecodes)) as AllTimecodes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AllTimecodes create() => AllTimecodes._();
  AllTimecodes createEmptyInstance() => create();
  static $pb.PbList<AllTimecodes> createRepeated() => $pb.PbList<AllTimecodes>();
  @$core.pragma('dart2js:noInline')
  static AllTimecodes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AllTimecodes>(create);
  static AllTimecodes? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Timecode> get timecodes => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<TimecodeControl> get controls => $_getList(1);
}

class Timecode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Timecode', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<TimecodeControlValues>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controls', $pb.PbFieldType.PM, subBuilder: TimecodeControlValues.create)
    ..hasRequiredFields = false
  ;

  Timecode._() : super();
  factory Timecode({
    $core.int? id,
    $core.String? name,
    $core.Iterable<TimecodeControlValues>? controls,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (controls != null) {
      _result.controls.addAll(controls);
    }
    return _result;
  }
  factory Timecode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Timecode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Timecode clone() => Timecode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Timecode copyWith(void Function(Timecode) updates) => super.copyWith((message) => updates(message as Timecode)) as Timecode; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Timecode create() => Timecode._();
  Timecode createEmptyInstance() => create();
  static $pb.PbList<Timecode> createRepeated() => $pb.PbList<Timecode>();
  @$core.pragma('dart2js:noInline')
  static Timecode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Timecode>(create);
  static Timecode? _defaultInstance;

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
  $core.List<TimecodeControlValues> get controls => $_getList(2);
}

class TimecodeControl extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TimecodeControl', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  TimecodeControl._() : super();
  factory TimecodeControl({
    $core.int? id,
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
  factory TimecodeControl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimecodeControl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimecodeControl clone() => TimecodeControl()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimecodeControl copyWith(void Function(TimecodeControl) updates) => super.copyWith((message) => updates(message as TimecodeControl)) as TimecodeControl; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TimecodeControl create() => TimecodeControl._();
  TimecodeControl createEmptyInstance() => create();
  static $pb.PbList<TimecodeControl> createRepeated() => $pb.PbList<TimecodeControl>();
  @$core.pragma('dart2js:noInline')
  static TimecodeControl getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimecodeControl>(create);
  static TimecodeControl? _defaultInstance;

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
}

class TimecodeControlValues_Step extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TimecodeControlValues.Step', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0a', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c0b', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1a', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'c1b', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TimecodeControlValues_Step._() : super();
  factory TimecodeControlValues_Step({
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
  factory TimecodeControlValues_Step.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimecodeControlValues_Step.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimecodeControlValues_Step clone() => TimecodeControlValues_Step()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimecodeControlValues_Step copyWith(void Function(TimecodeControlValues_Step) updates) => super.copyWith((message) => updates(message as TimecodeControlValues_Step)) as TimecodeControlValues_Step; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TimecodeControlValues_Step create() => TimecodeControlValues_Step._();
  TimecodeControlValues_Step createEmptyInstance() => create();
  static $pb.PbList<TimecodeControlValues_Step> createRepeated() => $pb.PbList<TimecodeControlValues_Step>();
  @$core.pragma('dart2js:noInline')
  static TimecodeControlValues_Step getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimecodeControlValues_Step>(create);
  static TimecodeControlValues_Step? _defaultInstance;

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

class TimecodeControlValues extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TimecodeControlValues', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer.timecode'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'controlId', $pb.PbFieldType.OU3)
    ..pc<TimecodeControlValues_Step>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: TimecodeControlValues_Step.create)
    ..hasRequiredFields = false
  ;

  TimecodeControlValues._() : super();
  factory TimecodeControlValues({
    $core.int? controlId,
    $core.Iterable<TimecodeControlValues_Step>? steps,
  }) {
    final _result = create();
    if (controlId != null) {
      _result.controlId = controlId;
    }
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    return _result;
  }
  factory TimecodeControlValues.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimecodeControlValues.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimecodeControlValues clone() => TimecodeControlValues()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimecodeControlValues copyWith(void Function(TimecodeControlValues) updates) => super.copyWith((message) => updates(message as TimecodeControlValues)) as TimecodeControlValues; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TimecodeControlValues create() => TimecodeControlValues._();
  TimecodeControlValues createEmptyInstance() => create();
  static $pb.PbList<TimecodeControlValues> createRepeated() => $pb.PbList<TimecodeControlValues>();
  @$core.pragma('dart2js:noInline')
  static TimecodeControlValues getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimecodeControlValues>(create);
  static TimecodeControlValues? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get controlId => $_getIZ(0);
  @$pb.TagNumber(1)
  set controlId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasControlId() => $_has(0);
  @$pb.TagNumber(1)
  void clearControlId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<TimecodeControlValues_Step> get steps => $_getList(1);
}

