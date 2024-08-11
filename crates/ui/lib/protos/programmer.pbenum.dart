///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class StoreGroupMode extends $pb.ProtobufEnum {
  static const StoreGroupMode STORE_GROUP_MODE_OVERWRITE = StoreGroupMode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STORE_GROUP_MODE_OVERWRITE');
  static const StoreGroupMode STORE_GROUP_MODE_MERGE = StoreGroupMode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STORE_GROUP_MODE_MERGE');
  static const StoreGroupMode STORE_GROUP_MODE_SUBTRACT = StoreGroupMode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STORE_GROUP_MODE_SUBTRACT');

  static const $core.List<StoreGroupMode> values = <StoreGroupMode> [
    STORE_GROUP_MODE_OVERWRITE,
    STORE_GROUP_MODE_MERGE,
    STORE_GROUP_MODE_SUBTRACT,
  ];

  static final $core.Map<$core.int, StoreGroupMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StoreGroupMode? valueOf($core.int value) => _byValue[value];

  const StoreGroupMode._($core.int v, $core.String n) : super(v, n);
}

class ProgrammerChannel_ColorChannel extends $pb.ProtobufEnum {
  static const ProgrammerChannel_ColorChannel RED = ProgrammerChannel_ColorChannel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RED');
  static const ProgrammerChannel_ColorChannel GREEN = ProgrammerChannel_ColorChannel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GREEN');
  static const ProgrammerChannel_ColorChannel BLUE = ProgrammerChannel_ColorChannel._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BLUE');

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
  static const StoreRequest_Mode OVERWRITE = StoreRequest_Mode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OVERWRITE');
  static const StoreRequest_Mode MERGE = StoreRequest_Mode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MERGE');
  static const StoreRequest_Mode ADD_CUE = StoreRequest_Mode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADD_CUE');

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
  static const PresetId_PresetType INTENSITY = PresetId_PresetType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INTENSITY');
  static const PresetId_PresetType SHUTTER = PresetId_PresetType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SHUTTER');
  static const PresetId_PresetType COLOR = PresetId_PresetType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLOR');
  static const PresetId_PresetType POSITION = PresetId_PresetType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'POSITION');

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

