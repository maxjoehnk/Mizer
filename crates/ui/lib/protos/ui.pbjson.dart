//
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use showDialogDescriptor instead')
const ShowDialog$json = {
  '1': 'ShowDialog',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'elements', '3': 2, '4': 3, '5': 11, '6': '.mizer.ui.DialogElement', '10': 'elements'},
  ],
};

/// Descriptor for `ShowDialog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List showDialogDescriptor = $convert.base64Decode(
    'CgpTaG93RGlhbG9nEhQKBXRpdGxlGAEgASgJUgV0aXRsZRIzCghlbGVtZW50cxgCIAMoCzIXLm'
    '1pemVyLnVpLkRpYWxvZ0VsZW1lbnRSCGVsZW1lbnRz');

@$core.Deprecated('Use dialogElementDescriptor instead')
const DialogElement$json = {
  '1': 'DialogElement',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'text'},
  ],
  '8': [
    {'1': 'element'},
  ],
};

/// Descriptor for `DialogElement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dialogElementDescriptor = $convert.base64Decode(
    'Cg1EaWFsb2dFbGVtZW50EhQKBHRleHQYASABKAlIAFIEdGV4dEIJCgdlbGVtZW50');

@$core.Deprecated('Use tabularDataDescriptor instead')
const TabularData$json = {
  '1': 'TabularData',
  '2': [
    {'1': 'columns', '3': 1, '4': 3, '5': 9, '10': 'columns'},
    {'1': 'rows', '3': 2, '4': 3, '5': 11, '6': '.mizer.ui.Row', '10': 'rows'},
  ],
};

/// Descriptor for `TabularData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tabularDataDescriptor = $convert.base64Decode(
    'CgtUYWJ1bGFyRGF0YRIYCgdjb2x1bW5zGAEgAygJUgdjb2x1bW5zEiEKBHJvd3MYAiADKAsyDS'
    '5taXplci51aS5Sb3dSBHJvd3M=');

@$core.Deprecated('Use rowDescriptor instead')
const Row$json = {
  '1': 'Row',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'cells', '3': 2, '4': 3, '5': 9, '10': 'cells'},
    {'1': 'children', '3': 3, '4': 3, '5': 11, '6': '.mizer.ui.Row', '10': 'children'},
  ],
};

/// Descriptor for `Row`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rowDescriptor = $convert.base64Decode(
    'CgNSb3cSDgoCaWQYASABKAlSAmlkEhQKBWNlbGxzGAIgAygJUgVjZWxscxIpCghjaGlsZHJlbh'
    'gDIAMoCzINLm1pemVyLnVpLlJvd1IIY2hpbGRyZW4=');

