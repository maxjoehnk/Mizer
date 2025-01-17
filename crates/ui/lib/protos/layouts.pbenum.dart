///
//  Generated code. Do not modify.
//  source: layouts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ControlType extends $pb.ProtobufEnum {
  static const ControlType NONE = ControlType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NONE');
  static const ControlType BUTTON = ControlType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUTTON');
  static const ControlType FADER = ControlType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FADER');
  static const ControlType DIAL = ControlType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DIAL');
  static const ControlType LABEL = ControlType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LABEL');
  static const ControlType TIMECODE = ControlType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TIMECODE');

  static const $core.List<ControlType> values = <ControlType> [
    NONE,
    BUTTON,
    FADER,
    DIAL,
    LABEL,
    TIMECODE,
  ];

  static final $core.Map<$core.int, ControlType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ControlType? valueOf($core.int value) => _byValue[value];

  const ControlType._($core.int v, $core.String n) : super(v, n);
}

class SequencerControlBehavior_ClickBehavior extends $pb.ProtobufEnum {
  static const SequencerControlBehavior_ClickBehavior GO_FORWARD = SequencerControlBehavior_ClickBehavior._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GO_FORWARD');
  static const SequencerControlBehavior_ClickBehavior TOGGLE = SequencerControlBehavior_ClickBehavior._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOGGLE');

  static const $core.List<SequencerControlBehavior_ClickBehavior> values = <SequencerControlBehavior_ClickBehavior> [
    GO_FORWARD,
    TOGGLE,
  ];

  static final $core.Map<$core.int, SequencerControlBehavior_ClickBehavior> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SequencerControlBehavior_ClickBehavior? valueOf($core.int value) => _byValue[value];

  const SequencerControlBehavior_ClickBehavior._($core.int v, $core.String n) : super(v, n);
}

