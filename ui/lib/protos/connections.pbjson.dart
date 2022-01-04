///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use monitorDmxRequestDescriptor instead')
const MonitorDmxRequest$json = const {
  '1': 'MonitorDmxRequest',
  '2': const [
    const {'1': 'outputId', '3': 1, '4': 1, '5': 9, '10': 'outputId'},
  ],
};

/// Descriptor for `MonitorDmxRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxRequestDescriptor = $convert.base64Decode('ChFNb25pdG9yRG14UmVxdWVzdBIaCghvdXRwdXRJZBgBIAEoCVIIb3V0cHV0SWQ=');
@$core.Deprecated('Use monitorDmxResponseDescriptor instead')
const MonitorDmxResponse$json = const {
  '1': 'MonitorDmxResponse',
  '2': const [
    const {'1': 'universes', '3': 1, '4': 3, '5': 11, '6': '.mizer.MonitorDmxUniverse', '10': 'universes'},
  ],
};

/// Descriptor for `MonitorDmxResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxResponseDescriptor = $convert.base64Decode('ChJNb25pdG9yRG14UmVzcG9uc2USNwoJdW5pdmVyc2VzGAEgAygLMhkubWl6ZXIuTW9uaXRvckRteFVuaXZlcnNlUgl1bml2ZXJzZXM=');
@$core.Deprecated('Use monitorDmxUniverseDescriptor instead')
const MonitorDmxUniverse$json = const {
  '1': 'MonitorDmxUniverse',
  '2': const [
    const {'1': 'universe', '3': 1, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'channels', '3': 2, '4': 1, '5': 12, '10': 'channels'},
  ],
};

/// Descriptor for `MonitorDmxUniverse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxUniverseDescriptor = $convert.base64Decode('ChJNb25pdG9yRG14VW5pdmVyc2USGgoIdW5pdmVyc2UYASABKA1SCHVuaXZlcnNlEhoKCGNoYW5uZWxzGAIgASgMUghjaGFubmVscw==');
@$core.Deprecated('Use getConnectionsRequestDescriptor instead')
const GetConnectionsRequest$json = const {
  '1': 'GetConnectionsRequest',
};

/// Descriptor for `GetConnectionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConnectionsRequestDescriptor = $convert.base64Decode('ChVHZXRDb25uZWN0aW9uc1JlcXVlc3Q=');
@$core.Deprecated('Use getDeviceProfilesRequestDescriptor instead')
const GetDeviceProfilesRequest$json = const {
  '1': 'GetDeviceProfilesRequest',
};

/// Descriptor for `GetDeviceProfilesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeviceProfilesRequestDescriptor = $convert.base64Decode('ChhHZXREZXZpY2VQcm9maWxlc1JlcXVlc3Q=');
@$core.Deprecated('Use addArtnetRequestDescriptor instead')
const AddArtnetRequest$json = const {
  '1': 'AddArtnetRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'host', '3': 2, '4': 1, '5': 9, '10': 'host'},
    const {'1': 'port', '3': 3, '4': 1, '5': 13, '10': 'port'},
  ],
};

/// Descriptor for `AddArtnetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addArtnetRequestDescriptor = $convert.base64Decode('ChBBZGRBcnRuZXRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWUSEgoEaG9zdBgCIAEoCVIEaG9zdBISCgRwb3J0GAMgASgNUgRwb3J0');
@$core.Deprecated('Use addSacnRequestDescriptor instead')
const AddSacnRequest$json = const {
  '1': 'AddSacnRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddSacnRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addSacnRequestDescriptor = $convert.base64Decode('Cg5BZGRTYWNuUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');
@$core.Deprecated('Use connectionsDescriptor instead')
const Connections$json = const {
  '1': 'Connections',
  '2': const [
    const {'1': 'connections', '3': 1, '4': 3, '5': 11, '6': '.mizer.Connection', '10': 'connections'},
  ],
};

/// Descriptor for `Connections`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionsDescriptor = $convert.base64Decode('CgtDb25uZWN0aW9ucxIzCgtjb25uZWN0aW9ucxgBIAMoCzIRLm1pemVyLkNvbm5lY3Rpb25SC2Nvbm5lY3Rpb25z');
@$core.Deprecated('Use connectionDescriptor instead')
const Connection$json = const {
  '1': 'Connection',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'dmx', '3': 10, '4': 1, '5': 11, '6': '.mizer.DmxConnection', '9': 0, '10': 'dmx'},
    const {'1': 'midi', '3': 11, '4': 1, '5': 11, '6': '.mizer.MidiConnection', '9': 0, '10': 'midi'},
    const {'1': 'osc', '3': 12, '4': 1, '5': 11, '6': '.mizer.OscConnection', '9': 0, '10': 'osc'},
    const {'1': 'proDJLink', '3': 13, '4': 1, '5': 11, '6': '.mizer.ProDjLinkConnection', '9': 0, '10': 'proDJLink'},
    const {'1': 'helios', '3': 14, '4': 1, '5': 11, '6': '.mizer.HeliosConnection', '9': 0, '10': 'helios'},
  ],
  '8': const [
    const {'1': 'connection'},
  ],
};

/// Descriptor for `Connection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionDescriptor = $convert.base64Decode('CgpDb25uZWN0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSKAoDZG14GAogASgLMhQubWl6ZXIuRG14Q29ubmVjdGlvbkgAUgNkbXgSKwoEbWlkaRgLIAEoCzIVLm1pemVyLk1pZGlDb25uZWN0aW9uSABSBG1pZGkSKAoDb3NjGAwgASgLMhQubWl6ZXIuT3NjQ29ubmVjdGlvbkgAUgNvc2MSOgoJcHJvREpMaW5rGA0gASgLMhoubWl6ZXIuUHJvRGpMaW5rQ29ubmVjdGlvbkgAUglwcm9ESkxpbmsSMQoGaGVsaW9zGA4gASgLMhcubWl6ZXIuSGVsaW9zQ29ubmVjdGlvbkgAUgZoZWxpb3NCDAoKY29ubmVjdGlvbg==');
@$core.Deprecated('Use dmxConnectionDescriptor instead')
const DmxConnection$json = const {
  '1': 'DmxConnection',
  '2': const [
    const {'1': 'outputId', '3': 1, '4': 1, '5': 9, '10': 'outputId'},
  ],
};

/// Descriptor for `DmxConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dmxConnectionDescriptor = $convert.base64Decode('Cg1EbXhDb25uZWN0aW9uEhoKCG91dHB1dElkGAEgASgJUghvdXRwdXRJZA==');
@$core.Deprecated('Use heliosConnectionDescriptor instead')
const HeliosConnection$json = const {
  '1': 'HeliosConnection',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'firmware', '3': 2, '4': 1, '5': 9, '10': 'firmware'},
  ],
};

/// Descriptor for `HeliosConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heliosConnectionDescriptor = $convert.base64Decode('ChBIZWxpb3NDb25uZWN0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSGgoIZmlybXdhcmUYAiABKAlSCGZpcm13YXJl');
@$core.Deprecated('Use midiConnectionDescriptor instead')
const MidiConnection$json = const {
  '1': 'MidiConnection',
  '2': const [
    const {'1': 'device_profile', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'deviceProfile', '17': true},
  ],
  '8': const [
    const {'1': '_device_profile'},
  ],
};

/// Descriptor for `MidiConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiConnectionDescriptor = $convert.base64Decode('Cg5NaWRpQ29ubmVjdGlvbhIqCg5kZXZpY2VfcHJvZmlsZRgBIAEoCUgAUg1kZXZpY2VQcm9maWxliAEBQhEKD19kZXZpY2VfcHJvZmlsZQ==');
@$core.Deprecated('Use midiDeviceProfilesDescriptor instead')
const MidiDeviceProfiles$json = const {
  '1': 'MidiDeviceProfiles',
  '2': const [
    const {'1': 'profiles', '3': 1, '4': 3, '5': 11, '6': '.mizer.MidiDeviceProfile', '10': 'profiles'},
  ],
};

/// Descriptor for `MidiDeviceProfiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfilesDescriptor = $convert.base64Decode('ChJNaWRpRGV2aWNlUHJvZmlsZXMSNAoIcHJvZmlsZXMYASADKAsyGC5taXplci5NaWRpRGV2aWNlUHJvZmlsZVIIcHJvZmlsZXM=');
@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile$json = const {
  '1': 'MidiDeviceProfile',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'manufacturer', '3': 2, '4': 1, '5': 9, '10': 'manufacturer'},
    const {'1': 'model', '3': 3, '4': 1, '5': 9, '10': 'model'},
    const {'1': 'layout', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'layout', '17': true},
    const {'1': 'pages', '3': 5, '4': 3, '5': 11, '6': '.mizer.MidiDeviceProfile.Page', '10': 'pages'},
  ],
  '3': const [MidiDeviceProfile_Page$json, MidiDeviceProfile_Group$json, MidiDeviceProfile_Control$json],
  '4': const [MidiDeviceProfile_ControlType$json],
  '8': const [
    const {'1': '_layout'},
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Page$json = const {
  '1': 'Page',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'groups', '3': 2, '4': 3, '5': 11, '6': '.mizer.MidiDeviceProfile.Group', '10': 'groups'},
    const {'1': 'controls', '3': 3, '4': 3, '5': 11, '6': '.mizer.MidiDeviceProfile.Control', '10': 'controls'},
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Group$json = const {
  '1': 'Group',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'controls', '3': 2, '4': 3, '5': 11, '6': '.mizer.MidiDeviceProfile.Control', '10': 'controls'},
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Control$json = const {
  '1': 'Control',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'channel', '3': 3, '4': 1, '5': 13, '10': 'channel'},
    const {'1': 'note', '3': 4, '4': 1, '5': 13, '10': 'note'},
    const {'1': 'control_type', '3': 5, '4': 1, '5': 14, '6': '.mizer.MidiDeviceProfile.ControlType', '10': 'controlType'},
    const {'1': 'has_output', '3': 6, '4': 1, '5': 8, '10': 'hasOutput'},
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_ControlType$json = const {
  '1': 'ControlType',
  '2': const [
    const {'1': 'Note', '2': 0},
    const {'1': 'CC', '2': 1},
  ],
};

/// Descriptor for `MidiDeviceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfileDescriptor = $convert.base64Decode('ChFNaWRpRGV2aWNlUHJvZmlsZRIOCgJpZBgBIAEoCVICaWQSIgoMbWFudWZhY3R1cmVyGAIgASgJUgxtYW51ZmFjdHVyZXISFAoFbW9kZWwYAyABKAlSBW1vZGVsEhsKBmxheW91dBgEIAEoCUgAUgZsYXlvdXSIAQESMwoFcGFnZXMYBSADKAsyHS5taXplci5NaWRpRGV2aWNlUHJvZmlsZS5QYWdlUgVwYWdlcxqQAQoEUGFnZRISCgRuYW1lGAEgASgJUgRuYW1lEjYKBmdyb3VwcxgCIAMoCzIeLm1pemVyLk1pZGlEZXZpY2VQcm9maWxlLkdyb3VwUgZncm91cHMSPAoIY29udHJvbHMYAyADKAsyIC5taXplci5NaWRpRGV2aWNlUHJvZmlsZS5Db250cm9sUghjb250cm9scxpZCgVHcm91cBISCgRuYW1lGAEgASgJUgRuYW1lEjwKCGNvbnRyb2xzGAIgAygLMiAubWl6ZXIuTWlkaURldmljZVByb2ZpbGUuQ29udHJvbFIIY29udHJvbHMawwEKB0NvbnRyb2wSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGAoHY2hhbm5lbBgDIAEoDVIHY2hhbm5lbBISCgRub3RlGAQgASgNUgRub3RlEkcKDGNvbnRyb2xfdHlwZRgFIAEoDjIkLm1pemVyLk1pZGlEZXZpY2VQcm9maWxlLkNvbnRyb2xUeXBlUgtjb250cm9sVHlwZRIdCgpoYXNfb3V0cHV0GAYgASgIUgloYXNPdXRwdXQiHwoLQ29udHJvbFR5cGUSCAoETm90ZRAAEgYKAkNDEAFCCQoHX2xheW91dA==');
@$core.Deprecated('Use oscConnectionDescriptor instead')
const OscConnection$json = const {
  '1': 'OscConnection',
  '2': const [
    const {'1': 'input_port', '3': 1, '4': 1, '5': 13, '10': 'inputPort'},
    const {'1': 'output_port', '3': 2, '4': 1, '5': 13, '10': 'outputPort'},
    const {'1': 'output_address', '3': 3, '4': 1, '5': 9, '10': 'outputAddress'},
  ],
};

/// Descriptor for `OscConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oscConnectionDescriptor = $convert.base64Decode('Cg1Pc2NDb25uZWN0aW9uEh0KCmlucHV0X3BvcnQYASABKA1SCWlucHV0UG9ydBIfCgtvdXRwdXRfcG9ydBgCIAEoDVIKb3V0cHV0UG9ydBIlCg5vdXRwdXRfYWRkcmVzcxgDIAEoCVINb3V0cHV0QWRkcmVzcw==');
@$core.Deprecated('Use proDjLinkConnectionDescriptor instead')
const ProDjLinkConnection$json = const {
  '1': 'ProDjLinkConnection',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'model', '3': 2, '4': 1, '5': 9, '10': 'model'},
    const {'1': 'playerNumber', '3': 3, '4': 1, '5': 13, '10': 'playerNumber'},
    const {'1': 'playback', '3': 5, '4': 1, '5': 11, '6': '.mizer.CdjPlayback', '10': 'playback'},
  ],
};

/// Descriptor for `ProDjLinkConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List proDjLinkConnectionDescriptor = $convert.base64Decode('ChNQcm9EakxpbmtDb25uZWN0aW9uEhgKB2FkZHJlc3MYASABKAlSB2FkZHJlc3MSFAoFbW9kZWwYAiABKAlSBW1vZGVsEiIKDHBsYXllck51bWJlchgDIAEoDVIMcGxheWVyTnVtYmVyEi4KCHBsYXliYWNrGAUgASgLMhIubWl6ZXIuQ2RqUGxheWJhY2tSCHBsYXliYWNr');
@$core.Deprecated('Use cdjPlaybackDescriptor instead')
const CdjPlayback$json = const {
  '1': 'CdjPlayback',
  '2': const [
    const {'1': 'live', '3': 1, '4': 1, '5': 8, '10': 'live'},
    const {'1': 'bpm', '3': 2, '4': 1, '5': 1, '10': 'bpm'},
    const {'1': 'frame', '3': 3, '4': 1, '5': 13, '10': 'frame'},
    const {'1': 'playback', '3': 4, '4': 1, '5': 14, '6': '.mizer.CdjPlayback.State', '10': 'playback'},
    const {'1': 'track', '3': 5, '4': 1, '5': 11, '6': '.mizer.CdjPlayback.Track', '10': 'track'},
  ],
  '3': const [CdjPlayback_Track$json],
  '4': const [CdjPlayback_State$json],
};

@$core.Deprecated('Use cdjPlaybackDescriptor instead')
const CdjPlayback_Track$json = const {
  '1': 'Track',
  '2': const [
    const {'1': 'artist', '3': 1, '4': 1, '5': 9, '10': 'artist'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
  ],
};

@$core.Deprecated('Use cdjPlaybackDescriptor instead')
const CdjPlayback_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'Loading', '2': 0},
    const {'1': 'Playing', '2': 1},
    const {'1': 'Cued', '2': 2},
    const {'1': 'Cueing', '2': 3},
  ],
};

/// Descriptor for `CdjPlayback`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cdjPlaybackDescriptor = $convert.base64Decode('CgtDZGpQbGF5YmFjaxISCgRsaXZlGAEgASgIUgRsaXZlEhAKA2JwbRgCIAEoAVIDYnBtEhQKBWZyYW1lGAMgASgNUgVmcmFtZRI0CghwbGF5YmFjaxgEIAEoDjIYLm1pemVyLkNkalBsYXliYWNrLlN0YXRlUghwbGF5YmFjaxIuCgV0cmFjaxgFIAEoCzIYLm1pemVyLkNkalBsYXliYWNrLlRyYWNrUgV0cmFjaxo1CgVUcmFjaxIWCgZhcnRpc3QYASABKAlSBmFydGlzdBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUiNwoFU3RhdGUSCwoHTG9hZGluZxAAEgsKB1BsYXlpbmcQARIICgRDdWVkEAISCgoGQ3VlaW5nEAM=');
