///
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use showDialogDescriptor instead')
const ShowDialog$json = const {
  '1': 'ShowDialog',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'elements', '3': 2, '4': 3, '5': 11, '6': '.mizer.ui.DialogElement', '10': 'elements'},
  ],
};

/// Descriptor for `ShowDialog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List showDialogDescriptor = $convert.base64Decode('CgpTaG93RGlhbG9nEhQKBXRpdGxlGAEgASgJUgV0aXRsZRIzCghlbGVtZW50cxgCIAMoCzIXLm1pemVyLnVpLkRpYWxvZ0VsZW1lbnRSCGVsZW1lbnRz');
@$core.Deprecated('Use dialogElementDescriptor instead')
const DialogElement$json = const {
  '1': 'DialogElement',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'text'},
  ],
  '8': const [
    const {'1': 'element'},
  ],
};

/// Descriptor for `DialogElement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dialogElementDescriptor = $convert.base64Decode('Cg1EaWFsb2dFbGVtZW50EhQKBHRleHQYASABKAlIAFIEdGV4dEIJCgdlbGVtZW50');
@$core.Deprecated('Use tabularDataDescriptor instead')
const TabularData$json = const {
  '1': 'TabularData',
  '2': const [
    const {'1': 'columns', '3': 1, '4': 3, '5': 9, '10': 'columns'},
    const {'1': 'rows', '3': 2, '4': 3, '5': 11, '6': '.mizer.ui.Row', '10': 'rows'},
  ],
};

/// Descriptor for `TabularData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tabularDataDescriptor = $convert.base64Decode('CgtUYWJ1bGFyRGF0YRIYCgdjb2x1bW5zGAEgAygJUgdjb2x1bW5zEiEKBHJvd3MYAiADKAsyDS5taXplci51aS5Sb3dSBHJvd3M=');
@$core.Deprecated('Use rowDescriptor instead')
const Row$json = const {
  '1': 'Row',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'cells', '3': 2, '4': 3, '5': 9, '10': 'cells'},
    const {'1': 'children', '3': 3, '4': 3, '5': 11, '6': '.mizer.ui.Row', '10': 'children'},
  ],
};

/// Descriptor for `Row`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rowDescriptor = $convert.base64Decode('CgNSb3cSDgoCaWQYASABKAlSAmlkEhQKBWNlbGxzGAIgAygJUgVjZWxscxIpCghjaGlsZHJlbhgDIAMoCzINLm1pemVyLnVpLlJvd1IIY2hpbGRyZW4=');
