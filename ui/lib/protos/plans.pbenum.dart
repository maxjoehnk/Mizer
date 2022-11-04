///
//  Generated code. Do not modify.
//  source: plans.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class AlignFixturesRequest_AlignDirection extends $pb.ProtobufEnum {
  static const AlignFixturesRequest_AlignDirection LeftToRight = AlignFixturesRequest_AlignDirection._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LeftToRight');
  static const AlignFixturesRequest_AlignDirection TopToBottom = AlignFixturesRequest_AlignDirection._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TopToBottom');

  static const $core.List<AlignFixturesRequest_AlignDirection> values = <AlignFixturesRequest_AlignDirection> [
    LeftToRight,
    TopToBottom,
  ];

  static final $core.Map<$core.int, AlignFixturesRequest_AlignDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AlignFixturesRequest_AlignDirection? valueOf($core.int value) => _byValue[value];

  const AlignFixturesRequest_AlignDirection._($core.int v, $core.String n) : super(v, n);
}

