///
//  Generated code. Do not modify.
//  source: appearance.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use appearanceDescriptor instead')
const Appearance$json = const {
  '1': 'Appearance',
  '2': const [
    const {'1': 'icon', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'icon', '17': true},
    const {'1': 'color', '3': 2, '4': 1, '5': 11, '6': '.mizer.appearance.Color', '9': 1, '10': 'color', '17': true},
    const {'1': 'background', '3': 3, '4': 1, '5': 11, '6': '.mizer.appearance.Color', '9': 2, '10': 'background', '17': true},
  ],
  '8': const [
    const {'1': '_icon'},
    const {'1': '_color'},
    const {'1': '_background'},
  ],
};

/// Descriptor for `Appearance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appearanceDescriptor = $convert.base64Decode('CgpBcHBlYXJhbmNlEhcKBGljb24YASABKAlIAFIEaWNvbogBARIyCgVjb2xvchgCIAEoCzIXLm1pemVyLmFwcGVhcmFuY2UuQ29sb3JIAVIFY29sb3KIAQESPAoKYmFja2dyb3VuZBgDIAEoCzIXLm1pemVyLmFwcGVhcmFuY2UuQ29sb3JIAlIKYmFja2dyb3VuZIgBAUIHCgVfaWNvbkIICgZfY29sb3JCDQoLX2JhY2tncm91bmQ=');
@$core.Deprecated('Use colorDescriptor instead')
const Color$json = const {
  '1': 'Color',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 2, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 2, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 2, '10': 'blue'},
    const {'1': 'alpha', '3': 4, '4': 1, '5': 2, '10': 'alpha'},
  ],
};

/// Descriptor for `Color`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorDescriptor = $convert.base64Decode('CgVDb2xvchIQCgNyZWQYASABKAJSA3JlZBIUCgVncmVlbhgCIAEoAlIFZ3JlZW4SEgoEYmx1ZRgDIAEoAlIEYmx1ZRIUCgVhbHBoYRgEIAEoAlIFYWxwaGE=');
