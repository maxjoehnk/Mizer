///
//  Generated code. Do not modify.
//  source: ports.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use nodePortsDescriptor instead')
const NodePorts$json = const {
  '1': 'NodePorts',
  '2': const [
    const {'1': 'ports', '3': 1, '4': 3, '5': 11, '6': '.mizer.ports.NodePort', '10': 'ports'},
  ],
};

/// Descriptor for `NodePorts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodePortsDescriptor = $convert.base64Decode('CglOb2RlUG9ydHMSKwoFcG9ydHMYASADKAsyFS5taXplci5wb3J0cy5Ob2RlUG9ydFIFcG9ydHM=');
@$core.Deprecated('Use nodePortDescriptor instead')
const NodePort$json = const {
  '1': 'NodePort',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `NodePort`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodePortDescriptor = $convert.base64Decode('CghOb2RlUG9ydBIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
