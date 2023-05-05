///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MidiDeviceProfile_ControlType extends $pb.ProtobufEnum {
  static const MidiDeviceProfile_ControlType NOTE = MidiDeviceProfile_ControlType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOTE');
  static const MidiDeviceProfile_ControlType CC = MidiDeviceProfile_ControlType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CC');

  static const $core.List<MidiDeviceProfile_ControlType> values = <MidiDeviceProfile_ControlType> [
    NOTE,
    CC,
  ];

  static final $core.Map<$core.int, MidiDeviceProfile_ControlType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MidiDeviceProfile_ControlType? valueOf($core.int value) => _byValue[value];

  const MidiDeviceProfile_ControlType._($core.int v, $core.String n) : super(v, n);
}

class CdjPlayback_State extends $pb.ProtobufEnum {
  static const CdjPlayback_State LOADING = CdjPlayback_State._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LOADING');
  static const CdjPlayback_State PLAYING = CdjPlayback_State._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PLAYING');
  static const CdjPlayback_State CUED = CdjPlayback_State._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUED');
  static const CdjPlayback_State CUEING = CdjPlayback_State._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUEING');

  static const $core.List<CdjPlayback_State> values = <CdjPlayback_State> [
    LOADING,
    PLAYING,
    CUED,
    CUEING,
  ];

  static final $core.Map<$core.int, CdjPlayback_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CdjPlayback_State? valueOf($core.int value) => _byValue[value];

  const CdjPlayback_State._($core.int v, $core.String n) : super(v, n);
}

