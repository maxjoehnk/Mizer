//
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use monitorDmxRequestDescriptor instead')
const MonitorDmxRequest$json = {
  '1': 'MonitorDmxRequest',
  '2': [
    {'1': 'output_id', '3': 1, '4': 1, '5': 9, '10': 'outputId'},
  ],
};

/// Descriptor for `MonitorDmxRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxRequestDescriptor = $convert.base64Decode(
    'ChFNb25pdG9yRG14UmVxdWVzdBIbCglvdXRwdXRfaWQYASABKAlSCG91dHB1dElk');

@$core.Deprecated('Use monitorDmxResponseDescriptor instead')
const MonitorDmxResponse$json = {
  '1': 'MonitorDmxResponse',
  '2': [
    {'1': 'universes', '3': 1, '4': 3, '5': 11, '6': '.mizer.connections.MonitorDmxUniverse', '10': 'universes'},
  ],
};

/// Descriptor for `MonitorDmxResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxResponseDescriptor = $convert.base64Decode(
    'ChJNb25pdG9yRG14UmVzcG9uc2USQwoJdW5pdmVyc2VzGAEgAygLMiUubWl6ZXIuY29ubmVjdG'
    'lvbnMuTW9uaXRvckRteFVuaXZlcnNlUgl1bml2ZXJzZXM=');

@$core.Deprecated('Use monitorDmxUniverseDescriptor instead')
const MonitorDmxUniverse$json = {
  '1': 'MonitorDmxUniverse',
  '2': [
    {'1': 'universe', '3': 1, '4': 1, '5': 13, '10': 'universe'},
    {'1': 'channels', '3': 2, '4': 1, '5': 12, '10': 'channels'},
  ],
};

/// Descriptor for `MonitorDmxUniverse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxUniverseDescriptor = $convert.base64Decode(
    'ChJNb25pdG9yRG14VW5pdmVyc2USGgoIdW5pdmVyc2UYASABKA1SCHVuaXZlcnNlEhoKCGNoYW'
    '5uZWxzGAIgASgMUghjaGFubmVscw==');

@$core.Deprecated('Use monitorMidiRequestDescriptor instead')
const MonitorMidiRequest$json = {
  '1': 'MonitorMidiRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MonitorMidiRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorMidiRequestDescriptor = $convert.base64Decode(
    'ChJNb25pdG9yTWlkaVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use monitorMidiResponseDescriptor instead')
const MonitorMidiResponse$json = {
  '1': 'MonitorMidiResponse',
  '2': [
    {'1': 'timestamp', '3': 2, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'cc', '3': 3, '4': 1, '5': 11, '6': '.mizer.connections.MonitorMidiResponse.NoteMsg', '9': 0, '10': 'cc'},
    {'1': 'note_off', '3': 4, '4': 1, '5': 11, '6': '.mizer.connections.MonitorMidiResponse.NoteMsg', '9': 0, '10': 'noteOff'},
    {'1': 'note_on', '3': 5, '4': 1, '5': 11, '6': '.mizer.connections.MonitorMidiResponse.NoteMsg', '9': 0, '10': 'noteOn'},
    {'1': 'sys_ex', '3': 6, '4': 1, '5': 11, '6': '.mizer.connections.MonitorMidiResponse.SysEx', '9': 0, '10': 'sysEx'},
    {'1': 'unknown', '3': 7, '4': 1, '5': 12, '9': 0, '10': 'unknown'},
  ],
  '3': [MonitorMidiResponse_NoteMsg$json, MonitorMidiResponse_SysEx$json],
  '8': [
    {'1': 'message'},
  ],
};

@$core.Deprecated('Use monitorMidiResponseDescriptor instead')
const MonitorMidiResponse_NoteMsg$json = {
  '1': 'NoteMsg',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 13, '10': 'channel'},
    {'1': 'note', '3': 2, '4': 1, '5': 13, '10': 'note'},
    {'1': 'value', '3': 3, '4': 1, '5': 13, '10': 'value'},
  ],
};

@$core.Deprecated('Use monitorMidiResponseDescriptor instead')
const MonitorMidiResponse_SysEx$json = {
  '1': 'SysEx',
  '2': [
    {'1': 'manufacturer1', '3': 1, '4': 1, '5': 13, '10': 'manufacturer1'},
    {'1': 'manufacturer2', '3': 2, '4': 1, '5': 13, '10': 'manufacturer2'},
    {'1': 'manufacturer3', '3': 3, '4': 1, '5': 13, '10': 'manufacturer3'},
    {'1': 'model', '3': 4, '4': 1, '5': 13, '10': 'model'},
    {'1': 'data', '3': 5, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `MonitorMidiResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorMidiResponseDescriptor = $convert.base64Decode(
    'ChNNb25pdG9yTWlkaVJlc3BvbnNlEhwKCXRpbWVzdGFtcBgCIAEoBFIJdGltZXN0YW1wEkAKAm'
    'NjGAMgASgLMi4ubWl6ZXIuY29ubmVjdGlvbnMuTW9uaXRvck1pZGlSZXNwb25zZS5Ob3RlTXNn'
    'SABSAmNjEksKCG5vdGVfb2ZmGAQgASgLMi4ubWl6ZXIuY29ubmVjdGlvbnMuTW9uaXRvck1pZG'
    'lSZXNwb25zZS5Ob3RlTXNnSABSB25vdGVPZmYSSQoHbm90ZV9vbhgFIAEoCzIuLm1pemVyLmNv'
    'bm5lY3Rpb25zLk1vbml0b3JNaWRpUmVzcG9uc2UuTm90ZU1zZ0gAUgZub3RlT24SRQoGc3lzX2'
    'V4GAYgASgLMiwubWl6ZXIuY29ubmVjdGlvbnMuTW9uaXRvck1pZGlSZXNwb25zZS5TeXNFeEgA'
    'UgVzeXNFeBIaCgd1bmtub3duGAcgASgMSABSB3Vua25vd24aTQoHTm90ZU1zZxIYCgdjaGFubm'
    'VsGAEgASgNUgdjaGFubmVsEhIKBG5vdGUYAiABKA1SBG5vdGUSFAoFdmFsdWUYAyABKA1SBXZh'
    'bHVlGqMBCgVTeXNFeBIkCg1tYW51ZmFjdHVyZXIxGAEgASgNUg1tYW51ZmFjdHVyZXIxEiQKDW'
    '1hbnVmYWN0dXJlcjIYAiABKA1SDW1hbnVmYWN0dXJlcjISJAoNbWFudWZhY3R1cmVyMxgDIAEo'
    'DVINbWFudWZhY3R1cmVyMxIUCgVtb2RlbBgEIAEoDVIFbW9kZWwSEgoEZGF0YRgFIAEoDFIEZG'
    'F0YUIJCgdtZXNzYWdl');

@$core.Deprecated('Use monitorOscRequestDescriptor instead')
const MonitorOscRequest$json = {
  '1': 'MonitorOscRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MonitorOscRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorOscRequestDescriptor = $convert.base64Decode(
    'ChFNb25pdG9yT3NjUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use monitorOscResponseDescriptor instead')
const MonitorOscResponse$json = {
  '1': 'MonitorOscResponse',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    {'1': 'args', '3': 3, '4': 3, '5': 11, '6': '.mizer.connections.MonitorOscResponse.OscArgument', '10': 'args'},
  ],
  '3': [MonitorOscResponse_OscArgument$json],
};

@$core.Deprecated('Use monitorOscResponseDescriptor instead')
const MonitorOscResponse_OscArgument$json = {
  '1': 'OscArgument',
  '2': [
    {'1': 'int', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'int'},
    {'1': 'float', '3': 2, '4': 1, '5': 2, '9': 0, '10': 'float'},
    {'1': 'long', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'long'},
    {'1': 'double', '3': 4, '4': 1, '5': 1, '9': 0, '10': 'double'},
    {'1': 'bool', '3': 5, '4': 1, '5': 8, '9': 0, '10': 'bool'},
    {'1': 'color', '3': 6, '4': 1, '5': 11, '6': '.mizer.connections.MonitorOscResponse.OscArgument.OscColor', '9': 0, '10': 'color'},
  ],
  '3': [MonitorOscResponse_OscArgument_OscColor$json],
  '8': [
    {'1': 'argument'},
  ],
};

@$core.Deprecated('Use monitorOscResponseDescriptor instead')
const MonitorOscResponse_OscArgument_OscColor$json = {
  '1': 'OscColor',
  '2': [
    {'1': 'red', '3': 1, '4': 1, '5': 13, '10': 'red'},
    {'1': 'green', '3': 2, '4': 1, '5': 13, '10': 'green'},
    {'1': 'blue', '3': 3, '4': 1, '5': 13, '10': 'blue'},
    {'1': 'alpha', '3': 4, '4': 1, '5': 13, '10': 'alpha'},
  ],
};

/// Descriptor for `MonitorOscResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorOscResponseDescriptor = $convert.base64Decode(
    'ChJNb25pdG9yT3NjUmVzcG9uc2USHAoJdGltZXN0YW1wGAEgASgEUgl0aW1lc3RhbXASEgoEcG'
    'F0aBgCIAEoCVIEcGF0aBJFCgRhcmdzGAMgAygLMjEubWl6ZXIuY29ubmVjdGlvbnMuTW9uaXRv'
    'ck9zY1Jlc3BvbnNlLk9zY0FyZ3VtZW50UgRhcmdzGr0CCgtPc2NBcmd1bWVudBISCgNpbnQYAS'
    'ABKAVIAFIDaW50EhYKBWZsb2F0GAIgASgCSABSBWZsb2F0EhQKBGxvbmcYAyABKANIAFIEbG9u'
    'ZxIYCgZkb3VibGUYBCABKAFIAFIGZG91YmxlEhQKBGJvb2wYBSABKAhIAFIEYm9vbBJSCgVjb2'
    'xvchgGIAEoCzI6Lm1pemVyLmNvbm5lY3Rpb25zLk1vbml0b3JPc2NSZXNwb25zZS5Pc2NBcmd1'
    'bWVudC5Pc2NDb2xvckgAUgVjb2xvchpcCghPc2NDb2xvchIQCgNyZWQYASABKA1SA3JlZBIUCg'
    'VncmVlbhgCIAEoDVIFZ3JlZW4SEgoEYmx1ZRgDIAEoDVIEYmx1ZRIUCgVhbHBoYRgEIAEoDVIF'
    'YWxwaGFCCgoIYXJndW1lbnQ=');

@$core.Deprecated('Use getConnectionsRequestDescriptor instead')
const GetConnectionsRequest$json = {
  '1': 'GetConnectionsRequest',
};

/// Descriptor for `GetConnectionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConnectionsRequestDescriptor = $convert.base64Decode(
    'ChVHZXRDb25uZWN0aW9uc1JlcXVlc3Q=');

@$core.Deprecated('Use getDeviceProfilesRequestDescriptor instead')
const GetDeviceProfilesRequest$json = {
  '1': 'GetDeviceProfilesRequest',
};

/// Descriptor for `GetDeviceProfilesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeviceProfilesRequestDescriptor = $convert.base64Decode(
    'ChhHZXREZXZpY2VQcm9maWxlc1JlcXVlc3Q=');

@$core.Deprecated('Use artnetOutputConfigDescriptor instead')
const ArtnetOutputConfig$json = {
  '1': 'ArtnetOutputConfig',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'host', '3': 2, '4': 1, '5': 9, '10': 'host'},
    {'1': 'port', '3': 3, '4': 1, '5': 13, '10': 'port'},
  ],
};

/// Descriptor for `ArtnetOutputConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List artnetOutputConfigDescriptor = $convert.base64Decode(
    'ChJBcnRuZXRPdXRwdXRDb25maWcSEgoEbmFtZRgBIAEoCVIEbmFtZRISCgRob3N0GAIgASgJUg'
    'Rob3N0EhIKBHBvcnQYAyABKA1SBHBvcnQ=');

@$core.Deprecated('Use artnetInputConfigDescriptor instead')
const ArtnetInputConfig$json = {
  '1': 'ArtnetInputConfig',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'host', '3': 2, '4': 1, '5': 9, '10': 'host'},
    {'1': 'port', '3': 3, '4': 1, '5': 13, '10': 'port'},
  ],
};

/// Descriptor for `ArtnetInputConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List artnetInputConfigDescriptor = $convert.base64Decode(
    'ChFBcnRuZXRJbnB1dENvbmZpZxISCgRuYW1lGAEgASgJUgRuYW1lEhIKBGhvc3QYAiABKAlSBG'
    'hvc3QSEgoEcG9ydBgDIAEoDVIEcG9ydA==');

@$core.Deprecated('Use sacnConfigDescriptor instead')
const SacnConfig$json = {
  '1': 'SacnConfig',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'priority', '3': 2, '4': 1, '5': 13, '10': 'priority'},
  ],
};

/// Descriptor for `SacnConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sacnConfigDescriptor = $convert.base64Decode(
    'CgpTYWNuQ29uZmlnEhIKBG5hbWUYASABKAlSBG5hbWUSGgoIcHJpb3JpdHkYAiABKA1SCHByaW'
    '9yaXR5');

@$core.Deprecated('Use connectionsDescriptor instead')
const Connections$json = {
  '1': 'Connections',
  '2': [
    {'1': 'connections', '3': 1, '4': 3, '5': 11, '6': '.mizer.connections.Connection', '10': 'connections'},
  ],
};

/// Descriptor for `Connections`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionsDescriptor = $convert.base64Decode(
    'CgtDb25uZWN0aW9ucxI/Cgtjb25uZWN0aW9ucxgBIAMoCzIdLm1pemVyLmNvbm5lY3Rpb25zLk'
    'Nvbm5lY3Rpb25SC2Nvbm5lY3Rpb25z');

@$core.Deprecated('Use connectionDescriptor instead')
const Connection$json = {
  '1': 'Connection',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'dmx_output', '3': 10, '4': 1, '5': 11, '6': '.mizer.connections.DmxOutputConnection', '9': 0, '10': 'dmxOutput'},
    {'1': 'dmx_input', '3': 11, '4': 1, '5': 11, '6': '.mizer.connections.DmxInputConnection', '9': 0, '10': 'dmxInput'},
    {'1': 'midi', '3': 12, '4': 1, '5': 11, '6': '.mizer.connections.MidiConnection', '9': 0, '10': 'midi'},
    {'1': 'osc', '3': 13, '4': 1, '5': 11, '6': '.mizer.connections.OscConnection', '9': 0, '10': 'osc'},
    {'1': 'helios', '3': 14, '4': 1, '5': 11, '6': '.mizer.connections.HeliosConnection', '9': 0, '10': 'helios'},
    {'1': 'ether_dream', '3': 15, '4': 1, '5': 11, '6': '.mizer.connections.EtherDreamConnection', '9': 0, '10': 'etherDream'},
    {'1': 'gamepad', '3': 16, '4': 1, '5': 11, '6': '.mizer.connections.GamepadConnection', '9': 0, '10': 'gamepad'},
    {'1': 'mqtt', '3': 17, '4': 1, '5': 11, '6': '.mizer.connections.MqttConnection', '9': 0, '10': 'mqtt'},
    {'1': 'g13', '3': 18, '4': 1, '5': 11, '6': '.mizer.connections.G13Connection', '9': 0, '10': 'g13'},
    {'1': 'webcam', '3': 19, '4': 1, '5': 11, '6': '.mizer.connections.WebcamConnection', '9': 0, '10': 'webcam'},
    {'1': 'cdj', '3': 20, '4': 1, '5': 11, '6': '.mizer.connections.PioneerCdjConnection', '9': 0, '10': 'cdj'},
    {'1': 'djm', '3': 21, '4': 1, '5': 11, '6': '.mizer.connections.PioneerDjmConnection', '9': 0, '10': 'djm'},
    {'1': 'ndi_source', '3': 22, '4': 1, '5': 11, '6': '.mizer.connections.NdiSourceConnection', '9': 0, '10': 'ndiSource'},
  ],
  '8': [
    {'1': 'connection'},
  ],
};

/// Descriptor for `Connection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionDescriptor = $convert.base64Decode(
    'CgpDb25uZWN0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSRwoKZG14X291dHB1dBgKIAEoCzImLm'
    '1pemVyLmNvbm5lY3Rpb25zLkRteE91dHB1dENvbm5lY3Rpb25IAFIJZG14T3V0cHV0EkQKCWRt'
    'eF9pbnB1dBgLIAEoCzIlLm1pemVyLmNvbm5lY3Rpb25zLkRteElucHV0Q29ubmVjdGlvbkgAUg'
    'hkbXhJbnB1dBI3CgRtaWRpGAwgASgLMiEubWl6ZXIuY29ubmVjdGlvbnMuTWlkaUNvbm5lY3Rp'
    'b25IAFIEbWlkaRI0CgNvc2MYDSABKAsyIC5taXplci5jb25uZWN0aW9ucy5Pc2NDb25uZWN0aW'
    '9uSABSA29zYxI9CgZoZWxpb3MYDiABKAsyIy5taXplci5jb25uZWN0aW9ucy5IZWxpb3NDb25u'
    'ZWN0aW9uSABSBmhlbGlvcxJKCgtldGhlcl9kcmVhbRgPIAEoCzInLm1pemVyLmNvbm5lY3Rpb2'
    '5zLkV0aGVyRHJlYW1Db25uZWN0aW9uSABSCmV0aGVyRHJlYW0SQAoHZ2FtZXBhZBgQIAEoCzIk'
    'Lm1pemVyLmNvbm5lY3Rpb25zLkdhbWVwYWRDb25uZWN0aW9uSABSB2dhbWVwYWQSNwoEbXF0dB'
    'gRIAEoCzIhLm1pemVyLmNvbm5lY3Rpb25zLk1xdHRDb25uZWN0aW9uSABSBG1xdHQSNAoDZzEz'
    'GBIgASgLMiAubWl6ZXIuY29ubmVjdGlvbnMuRzEzQ29ubmVjdGlvbkgAUgNnMTMSPQoGd2ViY2'
    'FtGBMgASgLMiMubWl6ZXIuY29ubmVjdGlvbnMuV2ViY2FtQ29ubmVjdGlvbkgAUgZ3ZWJjYW0S'
    'OwoDY2RqGBQgASgLMicubWl6ZXIuY29ubmVjdGlvbnMuUGlvbmVlckNkakNvbm5lY3Rpb25IAF'
    'IDY2RqEjsKA2RqbRgVIAEoCzInLm1pemVyLmNvbm5lY3Rpb25zLlBpb25lZXJEam1Db25uZWN0'
    'aW9uSABSA2RqbRJHCgpuZGlfc291cmNlGBYgASgLMiYubWl6ZXIuY29ubmVjdGlvbnMuTmRpU2'
    '91cmNlQ29ubmVjdGlvbkgAUgluZGlTb3VyY2VCDAoKY29ubmVjdGlvbg==');

@$core.Deprecated('Use dmxOutputConnectionDescriptor instead')
const DmxOutputConnection$json = {
  '1': 'DmxOutputConnection',
  '2': [
    {'1': 'output_id', '3': 1, '4': 1, '5': 9, '10': 'outputId'},
    {'1': 'artnet', '3': 3, '4': 1, '5': 11, '6': '.mizer.connections.ArtnetOutputConfig', '9': 0, '10': 'artnet'},
    {'1': 'sacn', '3': 4, '4': 1, '5': 11, '6': '.mizer.connections.SacnConfig', '9': 0, '10': 'sacn'},
  ],
  '8': [
    {'1': 'config'},
  ],
};

/// Descriptor for `DmxOutputConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dmxOutputConnectionDescriptor = $convert.base64Decode(
    'ChNEbXhPdXRwdXRDb25uZWN0aW9uEhsKCW91dHB1dF9pZBgBIAEoCVIIb3V0cHV0SWQSPwoGYX'
    'J0bmV0GAMgASgLMiUubWl6ZXIuY29ubmVjdGlvbnMuQXJ0bmV0T3V0cHV0Q29uZmlnSABSBmFy'
    'dG5ldBIzCgRzYWNuGAQgASgLMh0ubWl6ZXIuY29ubmVjdGlvbnMuU2FjbkNvbmZpZ0gAUgRzYW'
    'NuQggKBmNvbmZpZw==');

@$core.Deprecated('Use dmxInputConnectionDescriptor instead')
const DmxInputConnection$json = {
  '1': 'DmxInputConnection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'artnet', '3': 2, '4': 1, '5': 11, '6': '.mizer.connections.ArtnetInputConfig', '9': 0, '10': 'artnet'},
  ],
  '8': [
    {'1': 'config'},
  ],
};

/// Descriptor for `DmxInputConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dmxInputConnectionDescriptor = $convert.base64Decode(
    'ChJEbXhJbnB1dENvbm5lY3Rpb24SDgoCaWQYASABKAlSAmlkEj4KBmFydG5ldBgCIAEoCzIkLm'
    '1pemVyLmNvbm5lY3Rpb25zLkFydG5ldElucHV0Q29uZmlnSABSBmFydG5ldEIICgZjb25maWc=');

@$core.Deprecated('Use heliosConnectionDescriptor instead')
const HeliosConnection$json = {
  '1': 'HeliosConnection',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'firmware', '3': 2, '4': 1, '5': 13, '10': 'firmware'},
  ],
};

/// Descriptor for `HeliosConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heliosConnectionDescriptor = $convert.base64Decode(
    'ChBIZWxpb3NDb25uZWN0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSGgoIZmlybXdhcmUYAiABKA'
    '1SCGZpcm13YXJl');

@$core.Deprecated('Use etherDreamConnectionDescriptor instead')
const EtherDreamConnection$json = {
  '1': 'EtherDreamConnection',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `EtherDreamConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List etherDreamConnectionDescriptor = $convert.base64Decode(
    'ChRFdGhlckRyZWFtQ29ubmVjdGlvbhISCgRuYW1lGAEgASgJUgRuYW1l');

@$core.Deprecated('Use gamepadConnectionDescriptor instead')
const GamepadConnection$json = {
  '1': 'GamepadConnection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GamepadConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gamepadConnectionDescriptor = $convert.base64Decode(
    'ChFHYW1lcGFkQ29ubmVjdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ'
    '==');

@$core.Deprecated('Use g13ConnectionDescriptor instead')
const G13Connection$json = {
  '1': 'G13Connection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `G13Connection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List g13ConnectionDescriptor = $convert.base64Decode(
    'Cg1HMTNDb25uZWN0aW9uEg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use webcamConnectionDescriptor instead')
const WebcamConnection$json = {
  '1': 'WebcamConnection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `WebcamConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webcamConnectionDescriptor = $convert.base64Decode(
    'ChBXZWJjYW1Db25uZWN0aW9uEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');

@$core.Deprecated('Use ndiSourceConnectionDescriptor instead')
const NdiSourceConnection$json = {
  '1': 'NdiSourceConnection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `NdiSourceConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ndiSourceConnectionDescriptor = $convert.base64Decode(
    'ChNOZGlTb3VyY2VDb25uZWN0aW9uEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW'
    '1l');

@$core.Deprecated('Use midiConnectionDescriptor instead')
const MidiConnection$json = {
  '1': 'MidiConnection',
  '2': [
    {'1': 'device_profile', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'deviceProfile', '17': true},
  ],
  '8': [
    {'1': '_device_profile'},
  ],
};

/// Descriptor for `MidiConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiConnectionDescriptor = $convert.base64Decode(
    'Cg5NaWRpQ29ubmVjdGlvbhIqCg5kZXZpY2VfcHJvZmlsZRgBIAEoCUgAUg1kZXZpY2VQcm9maW'
    'xliAEBQhEKD19kZXZpY2VfcHJvZmlsZQ==');

@$core.Deprecated('Use midiDeviceProfilesDescriptor instead')
const MidiDeviceProfiles$json = {
  '1': 'MidiDeviceProfiles',
  '2': [
    {'1': 'profiles', '3': 1, '4': 3, '5': 11, '6': '.mizer.connections.MidiDeviceProfile', '10': 'profiles'},
  ],
};

/// Descriptor for `MidiDeviceProfiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfilesDescriptor = $convert.base64Decode(
    'ChJNaWRpRGV2aWNlUHJvZmlsZXMSQAoIcHJvZmlsZXMYASADKAsyJC5taXplci5jb25uZWN0aW'
    '9ucy5NaWRpRGV2aWNlUHJvZmlsZVIIcHJvZmlsZXM=');

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile$json = {
  '1': 'MidiDeviceProfile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'manufacturer', '3': 2, '4': 1, '5': 9, '10': 'manufacturer'},
    {'1': 'model', '3': 3, '4': 1, '5': 9, '10': 'model'},
    {'1': 'layout', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'layout', '17': true},
    {'1': 'pages', '3': 5, '4': 3, '5': 11, '6': '.mizer.connections.MidiDeviceProfile.Page', '10': 'pages'},
  ],
  '3': [MidiDeviceProfile_Page$json, MidiDeviceProfile_Group$json, MidiDeviceProfile_Control$json],
  '8': [
    {'1': '_layout'},
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Page$json = {
  '1': 'Page',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'groups', '3': 2, '4': 3, '5': 11, '6': '.mizer.connections.MidiDeviceProfile.Group', '10': 'groups'},
    {'1': 'controls', '3': 3, '4': 3, '5': 11, '6': '.mizer.connections.MidiDeviceProfile.Control', '10': 'controls'},
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Group$json = {
  '1': 'Group',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'controls', '3': 2, '4': 3, '5': 11, '6': '.mizer.connections.MidiDeviceProfile.Control', '10': 'controls'},
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Control$json = {
  '1': 'Control',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'has_input', '3': 3, '4': 1, '5': 8, '10': 'hasInput'},
    {'1': 'has_output', '3': 4, '4': 1, '5': 8, '10': 'hasOutput'},
  ],
};

/// Descriptor for `MidiDeviceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfileDescriptor = $convert.base64Decode(
    'ChFNaWRpRGV2aWNlUHJvZmlsZRIOCgJpZBgBIAEoCVICaWQSIgoMbWFudWZhY3R1cmVyGAIgAS'
    'gJUgxtYW51ZmFjdHVyZXISFAoFbW9kZWwYAyABKAlSBW1vZGVsEhsKBmxheW91dBgEIAEoCUgA'
    'UgZsYXlvdXSIAQESPwoFcGFnZXMYBSADKAsyKS5taXplci5jb25uZWN0aW9ucy5NaWRpRGV2aW'
    'NlUHJvZmlsZS5QYWdlUgVwYWdlcxqoAQoEUGFnZRISCgRuYW1lGAEgASgJUgRuYW1lEkIKBmdy'
    'b3VwcxgCIAMoCzIqLm1pemVyLmNvbm5lY3Rpb25zLk1pZGlEZXZpY2VQcm9maWxlLkdyb3VwUg'
    'Zncm91cHMSSAoIY29udHJvbHMYAyADKAsyLC5taXplci5jb25uZWN0aW9ucy5NaWRpRGV2aWNl'
    'UHJvZmlsZS5Db250cm9sUghjb250cm9scxplCgVHcm91cBISCgRuYW1lGAEgASgJUgRuYW1lEk'
    'gKCGNvbnRyb2xzGAIgAygLMiwubWl6ZXIuY29ubmVjdGlvbnMuTWlkaURldmljZVByb2ZpbGUu'
    'Q29udHJvbFIIY29udHJvbHMaaQoHQ29udHJvbBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIA'
    'EoCVIEbmFtZRIbCgloYXNfaW5wdXQYAyABKAhSCGhhc0lucHV0Eh0KCmhhc19vdXRwdXQYBCAB'
    'KAhSCWhhc091dHB1dEIJCgdfbGF5b3V0');

@$core.Deprecated('Use oscConnectionDescriptor instead')
const OscConnection$json = {
  '1': 'OscConnection',
  '2': [
    {'1': 'connection_id', '3': 1, '4': 1, '5': 9, '10': 'connectionId'},
    {'1': 'input_port', '3': 2, '4': 1, '5': 13, '10': 'inputPort'},
    {'1': 'output_port', '3': 3, '4': 1, '5': 13, '10': 'outputPort'},
    {'1': 'output_address', '3': 4, '4': 1, '5': 9, '10': 'outputAddress'},
  ],
};

/// Descriptor for `OscConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oscConnectionDescriptor = $convert.base64Decode(
    'Cg1Pc2NDb25uZWN0aW9uEiMKDWNvbm5lY3Rpb25faWQYASABKAlSDGNvbm5lY3Rpb25JZBIdCg'
    'ppbnB1dF9wb3J0GAIgASgNUglpbnB1dFBvcnQSHwoLb3V0cHV0X3BvcnQYAyABKA1SCm91dHB1'
    'dFBvcnQSJQoOb3V0cHV0X2FkZHJlc3MYBCABKAlSDW91dHB1dEFkZHJlc3M=');

@$core.Deprecated('Use pioneerCdjConnectionDescriptor instead')
const PioneerCdjConnection$json = {
  '1': 'PioneerCdjConnection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'model', '3': 3, '4': 1, '5': 9, '10': 'model'},
    {'1': 'player_number', '3': 4, '4': 1, '5': 13, '10': 'playerNumber'},
    {'1': 'playback', '3': 5, '4': 1, '5': 11, '6': '.mizer.connections.CdjPlayback', '10': 'playback'},
  ],
};

/// Descriptor for `PioneerCdjConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pioneerCdjConnectionDescriptor = $convert.base64Decode(
    'ChRQaW9uZWVyQ2RqQ29ubmVjdGlvbhIOCgJpZBgBIAEoCVICaWQSGAoHYWRkcmVzcxgCIAEoCV'
    'IHYWRkcmVzcxIUCgVtb2RlbBgDIAEoCVIFbW9kZWwSIwoNcGxheWVyX251bWJlchgEIAEoDVIM'
    'cGxheWVyTnVtYmVyEjoKCHBsYXliYWNrGAUgASgLMh4ubWl6ZXIuY29ubmVjdGlvbnMuQ2RqUG'
    'xheWJhY2tSCHBsYXliYWNr');

@$core.Deprecated('Use pioneerDjmConnectionDescriptor instead')
const PioneerDjmConnection$json = {
  '1': 'PioneerDjmConnection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'model', '3': 3, '4': 1, '5': 9, '10': 'model'},
    {'1': 'player_number', '3': 4, '4': 1, '5': 13, '10': 'playerNumber'},
  ],
};

/// Descriptor for `PioneerDjmConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pioneerDjmConnectionDescriptor = $convert.base64Decode(
    'ChRQaW9uZWVyRGptQ29ubmVjdGlvbhIOCgJpZBgBIAEoCVICaWQSGAoHYWRkcmVzcxgCIAEoCV'
    'IHYWRkcmVzcxIUCgVtb2RlbBgDIAEoCVIFbW9kZWwSIwoNcGxheWVyX251bWJlchgEIAEoDVIM'
    'cGxheWVyTnVtYmVy');

@$core.Deprecated('Use cdjPlaybackDescriptor instead')
const CdjPlayback$json = {
  '1': 'CdjPlayback',
  '2': [
    {'1': 'live', '3': 1, '4': 1, '5': 8, '10': 'live'},
    {'1': 'bpm', '3': 2, '4': 1, '5': 1, '10': 'bpm'},
    {'1': 'frame', '3': 3, '4': 1, '5': 13, '10': 'frame'},
    {'1': 'playback', '3': 4, '4': 1, '5': 14, '6': '.mizer.connections.CdjPlayback.State', '10': 'playback'},
    {'1': 'track', '3': 5, '4': 1, '5': 11, '6': '.mizer.connections.CdjPlayback.Track', '10': 'track'},
  ],
  '3': [CdjPlayback_Track$json],
  '4': [CdjPlayback_State$json],
};

@$core.Deprecated('Use cdjPlaybackDescriptor instead')
const CdjPlayback_Track$json = {
  '1': 'Track',
  '2': [
    {'1': 'artist', '3': 1, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
  ],
};

@$core.Deprecated('Use cdjPlaybackDescriptor instead')
const CdjPlayback_State$json = {
  '1': 'State',
  '2': [
    {'1': 'LOADING', '2': 0},
    {'1': 'PLAYING', '2': 1},
    {'1': 'CUED', '2': 2},
    {'1': 'CUEING', '2': 3},
  ],
};

/// Descriptor for `CdjPlayback`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cdjPlaybackDescriptor = $convert.base64Decode(
    'CgtDZGpQbGF5YmFjaxISCgRsaXZlGAEgASgIUgRsaXZlEhAKA2JwbRgCIAEoAVIDYnBtEhQKBW'
    'ZyYW1lGAMgASgNUgVmcmFtZRJACghwbGF5YmFjaxgEIAEoDjIkLm1pemVyLmNvbm5lY3Rpb25z'
    'LkNkalBsYXliYWNrLlN0YXRlUghwbGF5YmFjaxI6CgV0cmFjaxgFIAEoCzIkLm1pemVyLmNvbm'
    '5lY3Rpb25zLkNkalBsYXliYWNrLlRyYWNrUgV0cmFjaxo1CgVUcmFjaxIWCgZhcnRpc3QYASAB'
    'KAlSBmFydGlzdBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUiNwoFU3RhdGUSCwoHTE9BRElORxAAEg'
    'sKB1BMQVlJTkcQARIICgRDVUVEEAISCgoGQ1VFSU5HEAM=');

@$core.Deprecated('Use mqttConnectionDescriptor instead')
const MqttConnection$json = {
  '1': 'MqttConnection',
  '2': [
    {'1': 'connection_id', '3': 1, '4': 1, '5': 9, '10': 'connectionId'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'username', '17': true},
    {'1': 'password', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'password', '17': true},
  ],
  '8': [
    {'1': '_username'},
    {'1': '_password'},
  ],
};

/// Descriptor for `MqttConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mqttConnectionDescriptor = $convert.base64Decode(
    'Cg5NcXR0Q29ubmVjdGlvbhIjCg1jb25uZWN0aW9uX2lkGAEgASgJUgxjb25uZWN0aW9uSWQSEA'
    'oDdXJsGAIgASgJUgN1cmwSHwoIdXNlcm5hbWUYAyABKAlIAFIIdXNlcm5hbWWIAQESHwoIcGFz'
    'c3dvcmQYBCABKAlIAVIIcGFzc3dvcmSIAQFCCwoJX3VzZXJuYW1lQgsKCV9wYXNzd29yZA==');

@$core.Deprecated('Use configureConnectionRequestDescriptor instead')
const ConfigureConnectionRequest$json = {
  '1': 'ConfigureConnectionRequest',
  '2': [
    {'1': 'dmx_output', '3': 1, '4': 1, '5': 11, '6': '.mizer.connections.DmxOutputConnection', '9': 0, '10': 'dmxOutput'},
    {'1': 'mqtt', '3': 2, '4': 1, '5': 11, '6': '.mizer.connections.MqttConnection', '9': 0, '10': 'mqtt'},
    {'1': 'osc', '3': 3, '4': 1, '5': 11, '6': '.mizer.connections.OscConnection', '9': 0, '10': 'osc'},
    {'1': 'dmx_input', '3': 4, '4': 1, '5': 11, '6': '.mizer.connections.DmxInputConnection', '9': 0, '10': 'dmxInput'},
  ],
  '8': [
    {'1': 'config'},
  ],
};

/// Descriptor for `ConfigureConnectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List configureConnectionRequestDescriptor = $convert.base64Decode(
    'ChpDb25maWd1cmVDb25uZWN0aW9uUmVxdWVzdBJHCgpkbXhfb3V0cHV0GAEgASgLMiYubWl6ZX'
    'IuY29ubmVjdGlvbnMuRG14T3V0cHV0Q29ubmVjdGlvbkgAUglkbXhPdXRwdXQSNwoEbXF0dBgC'
    'IAEoCzIhLm1pemVyLmNvbm5lY3Rpb25zLk1xdHRDb25uZWN0aW9uSABSBG1xdHQSNAoDb3NjGA'
    'MgASgLMiAubWl6ZXIuY29ubmVjdGlvbnMuT3NjQ29ubmVjdGlvbkgAUgNvc2MSRAoJZG14X2lu'
    'cHV0GAQgASgLMiUubWl6ZXIuY29ubmVjdGlvbnMuRG14SW5wdXRDb25uZWN0aW9uSABSCGRteE'
    'lucHV0QggKBmNvbmZpZw==');

