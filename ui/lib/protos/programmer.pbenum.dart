///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ProgrammerChannel_ColorChannel extends $pb.ProtobufEnum {
  static const ProgrammerChannel_ColorChannel Red = ProgrammerChannel_ColorChannel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Red');
  static const ProgrammerChannel_ColorChannel Green = ProgrammerChannel_ColorChannel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Green');
  static const ProgrammerChannel_ColorChannel Blue = ProgrammerChannel_ColorChannel._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Blue');

  static const $core.List<ProgrammerChannel_ColorChannel> values = <ProgrammerChannel_ColorChannel> [
    Red,
    Green,
    Blue,
  ];

  static final $core.Map<$core.int, ProgrammerChannel_ColorChannel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProgrammerChannel_ColorChannel? valueOf($core.int value) => _byValue[value];

  const ProgrammerChannel_ColorChannel._($core.int v, $core.String n) : super(v, n);
}

class StoreRequest_Mode extends $pb.ProtobufEnum {
  static const StoreRequest_Mode Overwrite = StoreRequest_Mode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Overwrite');
  static const StoreRequest_Mode Merge = StoreRequest_Mode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Merge');
  static const StoreRequest_Mode AddCue = StoreRequest_Mode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AddCue');

  static const $core.List<StoreRequest_Mode> values = <StoreRequest_Mode> [
    Overwrite,
    Merge,
    AddCue,
  ];

  static final $core.Map<$core.int, StoreRequest_Mode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StoreRequest_Mode? valueOf($core.int value) => _byValue[value];

  const StoreRequest_Mode._($core.int v, $core.String n) : super(v, n);
}

class PresetId_PresetType extends $pb.ProtobufEnum {
  static const PresetId_PresetType Intensity = PresetId_PresetType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Intensity');
  static const PresetId_PresetType Shutter = PresetId_PresetType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Shutter');
  static const PresetId_PresetType Color = PresetId_PresetType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Color');
  static const PresetId_PresetType Position = PresetId_PresetType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Position');

  static const $core.List<PresetId_PresetType> values = <PresetId_PresetType> [
    Intensity,
    Shutter,
    Color,
    Position,
  ];

  static final $core.Map<$core.int, PresetId_PresetType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PresetId_PresetType? valueOf($core.int value) => _byValue[value];

  const PresetId_PresetType._($core.int v, $core.String n) : super(v, n);
}

