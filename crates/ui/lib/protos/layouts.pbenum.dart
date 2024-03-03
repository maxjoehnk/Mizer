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

import 'package:protobuf/protobuf.dart' as $pb;

class ControlType extends $pb.ProtobufEnum {
  static const ControlType NONE = ControlType._(0, _omitEnumNames ? '' : 'NONE');
  static const ControlType BUTTON = ControlType._(1, _omitEnumNames ? '' : 'BUTTON');
  static const ControlType FADER = ControlType._(2, _omitEnumNames ? '' : 'FADER');
  static const ControlType DIAL = ControlType._(3, _omitEnumNames ? '' : 'DIAL');
  static const ControlType LABEL = ControlType._(4, _omitEnumNames ? '' : 'LABEL');

  static const $core.List<ControlType> values = <ControlType> [
    NONE,
    BUTTON,
    FADER,
    DIAL,
    LABEL,
  ];

  static final $core.Map<$core.int, ControlType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ControlType? valueOf($core.int value) => _byValue[value];

  const ControlType._($core.int v, $core.String n) : super(v, n);
}

class SequencerControlBehavior_ClickBehavior extends $pb.ProtobufEnum {
  static const SequencerControlBehavior_ClickBehavior GO_FORWARD = SequencerControlBehavior_ClickBehavior._(0, _omitEnumNames ? '' : 'GO_FORWARD');
  static const SequencerControlBehavior_ClickBehavior TOGGLE = SequencerControlBehavior_ClickBehavior._(1, _omitEnumNames ? '' : 'TOGGLE');

  static const $core.List<SequencerControlBehavior_ClickBehavior> values = <SequencerControlBehavior_ClickBehavior> [
    GO_FORWARD,
    TOGGLE,
  ];

  static final $core.Map<$core.int, SequencerControlBehavior_ClickBehavior> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SequencerControlBehavior_ClickBehavior? valueOf($core.int value) => _byValue[value];

  const SequencerControlBehavior_ClickBehavior._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
