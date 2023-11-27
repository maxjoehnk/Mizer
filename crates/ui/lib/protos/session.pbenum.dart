///
//  Generated code. Do not modify.
//  source: session.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ClientRole extends $pb.ProtobufEnum {
  static const ClientRole ORCHESTRATOR = ClientRole._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORCHESTRATOR');
  static const ClientRole MOBILE = ClientRole._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOBILE');
  static const ClientRole REMOTE = ClientRole._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REMOTE');

  static const $core.List<ClientRole> values = <ClientRole> [
    ORCHESTRATOR,
    MOBILE,
    REMOTE,
  ];

  static final $core.Map<$core.int, ClientRole> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ClientRole? valueOf($core.int value) => _byValue[value];

  const ClientRole._($core.int v, $core.String n) : super(v, n);
}

