//
//  Generated code. Do not modify.
//  source: console.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'console.pbenum.dart';

export 'console.pbenum.dart';

class ConsoleHistory extends $pb.GeneratedMessage {
  factory ConsoleHistory({
    $core.Iterable<ConsoleMessage>? messages,
  }) {
    final $result = create();
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    return $result;
  }
  ConsoleHistory._() : super();
  factory ConsoleHistory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConsoleHistory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConsoleHistory', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.console'), createEmptyInstance: create)
    ..pc<ConsoleMessage>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: ConsoleMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConsoleHistory clone() => ConsoleHistory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConsoleHistory copyWith(void Function(ConsoleHistory) updates) => super.copyWith((message) => updates(message as ConsoleHistory)) as ConsoleHistory;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConsoleHistory create() => ConsoleHistory._();
  ConsoleHistory createEmptyInstance() => create();
  static $pb.PbList<ConsoleHistory> createRepeated() => $pb.PbList<ConsoleHistory>();
  @$core.pragma('dart2js:noInline')
  static ConsoleHistory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConsoleHistory>(create);
  static ConsoleHistory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ConsoleMessage> get messages => $_getList(0);
}

class ConsoleMessage extends $pb.GeneratedMessage {
  factory ConsoleMessage({
    ConsoleLevel? level,
    ConsoleCategory? category,
    $core.String? message,
    $fixnum.Int64? timestamp,
  }) {
    final $result = create();
    if (level != null) {
      $result.level = level;
    }
    if (category != null) {
      $result.category = category;
    }
    if (message != null) {
      $result.message = message;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  ConsoleMessage._() : super();
  factory ConsoleMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConsoleMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConsoleMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.console'), createEmptyInstance: create)
    ..e<ConsoleLevel>(1, _omitFieldNames ? '' : 'level', $pb.PbFieldType.OE, defaultOrMaker: ConsoleLevel.ERROR, valueOf: ConsoleLevel.valueOf, enumValues: ConsoleLevel.values)
    ..e<ConsoleCategory>(2, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: ConsoleCategory.CONNECTIONS, valueOf: ConsoleCategory.valueOf, enumValues: ConsoleCategory.values)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConsoleMessage clone() => ConsoleMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConsoleMessage copyWith(void Function(ConsoleMessage) updates) => super.copyWith((message) => updates(message as ConsoleMessage)) as ConsoleMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConsoleMessage create() => ConsoleMessage._();
  ConsoleMessage createEmptyInstance() => create();
  static $pb.PbList<ConsoleMessage> createRepeated() => $pb.PbList<ConsoleMessage>();
  @$core.pragma('dart2js:noInline')
  static ConsoleMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConsoleMessage>(create);
  static ConsoleMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ConsoleLevel get level => $_getN(0);
  @$pb.TagNumber(1)
  set level(ConsoleLevel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => clearField(1);

  @$pb.TagNumber(2)
  ConsoleCategory get category => $_getN(1);
  @$pb.TagNumber(2)
  set category(ConsoleCategory v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
