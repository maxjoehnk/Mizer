///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

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

