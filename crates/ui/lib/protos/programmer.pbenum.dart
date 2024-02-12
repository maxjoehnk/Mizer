//
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ProgrammerChannel_ColorChannel extends $pb.ProtobufEnum {
  static const ProgrammerChannel_ColorChannel RED = ProgrammerChannel_ColorChannel._(0, _omitEnumNames ? '' : 'RED');
  static const ProgrammerChannel_ColorChannel GREEN = ProgrammerChannel_ColorChannel._(1, _omitEnumNames ? '' : 'GREEN');
  static const ProgrammerChannel_ColorChannel BLUE = ProgrammerChannel_ColorChannel._(2, _omitEnumNames ? '' : 'BLUE');

  static const $core.List<ProgrammerChannel_ColorChannel> values = <ProgrammerChannel_ColorChannel> [
    RED,
    GREEN,
    BLUE,
  ];

  static final $core.Map<$core.int, ProgrammerChannel_ColorChannel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProgrammerChannel_ColorChannel? valueOf($core.int value) => _byValue[value];

  const ProgrammerChannel_ColorChannel._($core.int v, $core.String n) : super(v, n);
}

class StoreRequest_Mode extends $pb.ProtobufEnum {
  static const StoreRequest_Mode OVERWRITE = StoreRequest_Mode._(0, _omitEnumNames ? '' : 'OVERWRITE');
  static const StoreRequest_Mode MERGE = StoreRequest_Mode._(1, _omitEnumNames ? '' : 'MERGE');
  static const StoreRequest_Mode ADD_CUE = StoreRequest_Mode._(2, _omitEnumNames ? '' : 'ADD_CUE');

  static const $core.List<StoreRequest_Mode> values = <StoreRequest_Mode> [
    OVERWRITE,
    MERGE,
    ADD_CUE,
  ];

  static final $core.Map<$core.int, StoreRequest_Mode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StoreRequest_Mode? valueOf($core.int value) => _byValue[value];

  const StoreRequest_Mode._($core.int v, $core.String n) : super(v, n);
}

class PresetId_PresetType extends $pb.ProtobufEnum {
  static const PresetId_PresetType INTENSITY = PresetId_PresetType._(0, _omitEnumNames ? '' : 'INTENSITY');
  static const PresetId_PresetType SHUTTER = PresetId_PresetType._(1, _omitEnumNames ? '' : 'SHUTTER');
  static const PresetId_PresetType COLOR = PresetId_PresetType._(2, _omitEnumNames ? '' : 'COLOR');
  static const PresetId_PresetType POSITION = PresetId_PresetType._(3, _omitEnumNames ? '' : 'POSITION');

  static const $core.List<PresetId_PresetType> values = <PresetId_PresetType> [
    INTENSITY,
    SHUTTER,
    COLOR,
    POSITION,
  ];

  static final $core.Map<$core.int, PresetId_PresetType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PresetId_PresetType? valueOf($core.int value) => _byValue[value];

  const PresetId_PresetType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
