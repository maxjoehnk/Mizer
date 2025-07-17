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

@$core.Deprecated('Use viewDescriptor instead')
const View$json = {
  '1': 'View',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'icon', '3': 2, '4': 1, '5': 9, '10': 'icon'},
    {'1': 'child', '3': 3, '4': 1, '5': 11, '6': '.mizer.ui.ViewChild', '10': 'child'},
  ],
};

/// Descriptor for `View`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewDescriptor = $convert.base64Decode(
    'CgRWaWV3EhQKBXRpdGxlGAEgASgJUgV0aXRsZRISCgRpY29uGAIgASgJUgRpY29uEikKBWNoaW'
    'xkGAMgASgLMhMubWl6ZXIudWkuVmlld0NoaWxkUgVjaGlsZA==');

@$core.Deprecated('Use viewChildDescriptor instead')
const ViewChild$json = {
  '1': 'ViewChild',
  '2': [
    {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.mizer.ui.PanelGroup', '9': 0, '10': 'group'},
    {'1': 'panel', '3': 2, '4': 1, '5': 11, '6': '.mizer.ui.Panel', '9': 0, '10': 'panel'},
    {'1': 'width', '3': 3, '4': 1, '5': 11, '6': '.mizer.ui.Size', '9': 1, '10': 'width', '17': true},
    {'1': 'height', '3': 4, '4': 1, '5': 11, '6': '.mizer.ui.Size', '9': 2, '10': 'height', '17': true},
  ],
  '8': [
    {'1': 'child'},
    {'1': '_width'},
    {'1': '_height'},
  ],
};

/// Descriptor for `ViewChild`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List viewChildDescriptor = $convert.base64Decode(
    'CglWaWV3Q2hpbGQSLAoFZ3JvdXAYASABKAsyFC5taXplci51aS5QYW5lbEdyb3VwSABSBWdyb3'
    'VwEicKBXBhbmVsGAIgASgLMg8ubWl6ZXIudWkuUGFuZWxIAFIFcGFuZWwSKQoFd2lkdGgYAyAB'
    'KAsyDi5taXplci51aS5TaXplSAFSBXdpZHRoiAEBEisKBmhlaWdodBgEIAEoCzIOLm1pemVyLn'
    'VpLlNpemVIAlIGaGVpZ2h0iAEBQgcKBWNoaWxkQggKBl93aWR0aEIJCgdfaGVpZ2h0');

@$core.Deprecated('Use panelGroupDescriptor instead')
const PanelGroup$json = {
  '1': 'PanelGroup',
  '2': [
    {'1': 'direction', '3': 1, '4': 1, '5': 14, '6': '.mizer.ui.PanelGroup.Direction', '10': 'direction'},
    {'1': 'children', '3': 2, '4': 3, '5': 11, '6': '.mizer.ui.ViewChild', '10': 'children'},
  ],
  '4': [PanelGroup_Direction$json],
};

@$core.Deprecated('Use panelGroupDescriptor instead')
const PanelGroup_Direction$json = {
  '1': 'Direction',
  '2': [
    {'1': 'DIRECTION_HORIZONTAL', '2': 0},
    {'1': 'DIRECTION_VERTICAL', '2': 1},
  ],
};

/// Descriptor for `PanelGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List panelGroupDescriptor = $convert.base64Decode(
    'CgpQYW5lbEdyb3VwEjwKCWRpcmVjdGlvbhgBIAEoDjIeLm1pemVyLnVpLlBhbmVsR3JvdXAuRG'
    'lyZWN0aW9uUglkaXJlY3Rpb24SLwoIY2hpbGRyZW4YAiADKAsyEy5taXplci51aS5WaWV3Q2hp'
    'bGRSCGNoaWxkcmVuIj0KCURpcmVjdGlvbhIYChRESVJFQ1RJT05fSE9SSVpPTlRBTBAAEhYKEk'
    'RJUkVDVElPTl9WRVJUSUNBTBAB');

@$core.Deprecated('Use sizeDescriptor instead')
const Size$json = {
  '1': 'Size',
  '2': [
    {'1': 'fill', '3': 1, '4': 1, '5': 11, '6': '.mizer.ui.Fill', '9': 0, '10': 'fill'},
    {'1': 'flex', '3': 2, '4': 1, '5': 11, '6': '.mizer.ui.Flex', '9': 0, '10': 'flex'},
    {'1': 'gridItems', '3': 3, '4': 1, '5': 11, '6': '.mizer.ui.GridItems', '9': 0, '10': 'gridItems'},
    {'1': 'pixels', '3': 4, '4': 1, '5': 11, '6': '.mizer.ui.Pixels', '9': 0, '10': 'pixels'},
  ],
  '8': [
    {'1': 'size'},
  ],
};

/// Descriptor for `Size`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sizeDescriptor = $convert.base64Decode(
    'CgRTaXplEiQKBGZpbGwYASABKAsyDi5taXplci51aS5GaWxsSABSBGZpbGwSJAoEZmxleBgCIA'
    'EoCzIOLm1pemVyLnVpLkZsZXhIAFIEZmxleBIzCglncmlkSXRlbXMYAyABKAsyEy5taXplci51'
    'aS5HcmlkSXRlbXNIAFIJZ3JpZEl0ZW1zEioKBnBpeGVscxgEIAEoCzIQLm1pemVyLnVpLlBpeG'
    'Vsc0gAUgZwaXhlbHNCBgoEc2l6ZQ==');

@$core.Deprecated('Use fillDescriptor instead')
const Fill$json = {
  '1': 'Fill',
};

/// Descriptor for `Fill`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fillDescriptor = $convert.base64Decode(
    'CgRGaWxs');

@$core.Deprecated('Use flexDescriptor instead')
const Flex$json = {
  '1': 'Flex',
  '2': [
    {'1': 'flex', '3': 1, '4': 1, '5': 13, '10': 'flex'},
  ],
};

/// Descriptor for `Flex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List flexDescriptor = $convert.base64Decode(
    'CgRGbGV4EhIKBGZsZXgYASABKA1SBGZsZXg=');

@$core.Deprecated('Use gridItemsDescriptor instead')
const GridItems$json = {
  '1': 'GridItems',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 2, '10': 'count'},
  ],
};

/// Descriptor for `GridItems`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gridItemsDescriptor = $convert.base64Decode(
    'CglHcmlkSXRlbXMSFAoFY291bnQYASABKAJSBWNvdW50');

@$core.Deprecated('Use pixelsDescriptor instead')
const Pixels$json = {
  '1': 'Pixels',
  '2': [
    {'1': 'pixels', '3': 1, '4': 1, '5': 13, '10': 'pixels'},
  ],
};

/// Descriptor for `Pixels`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pixelsDescriptor = $convert.base64Decode(
    'CgZQaXhlbHMSFgoGcGl4ZWxzGAEgASgNUgZwaXhlbHM=');

@$core.Deprecated('Use panelDescriptor instead')
const Panel$json = {
  '1': 'Panel',
  '2': [
    {'1': 'panelType', '3': 1, '4': 1, '5': 9, '10': 'panelType'},
  ],
};

/// Descriptor for `Panel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List panelDescriptor = $convert.base64Decode(
    'CgVQYW5lbBIcCglwYW5lbFR5cGUYASABKAlSCXBhbmVsVHlwZQ==');

