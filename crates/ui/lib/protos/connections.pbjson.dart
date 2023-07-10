///
import 'dart:convert' as $convert;
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use monitorDmxRequestDescriptor instead')
const MonitorDmxRequest$json = const {
  '1': 'MonitorDmxRequest',
  '2': const [
    const {'1': 'output_id', '3': 1, '4': 1, '5': 9, '10': 'outputId'},
  ],
};

/// Descriptor for `MonitorDmxRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxRequestDescriptor =
    $convert.base64Decode('ChFNb25pdG9yRG14UmVxdWVzdBIbCglvdXRwdXRfaWQYASABKAlSCG91dHB1dElk');
@$core.Deprecated('Use monitorDmxResponseDescriptor instead')
const MonitorDmxResponse$json = const {
  '1': 'MonitorDmxResponse',
  '2': const [
    const {
      '1': 'universes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mizer.MonitorDmxUniverse',
      '10': 'universes'
    },
  ],
};

/// Descriptor for `MonitorDmxResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxResponseDescriptor = $convert.base64Decode(
    'ChJNb25pdG9yRG14UmVzcG9uc2USNwoJdW5pdmVyc2VzGAEgAygLMhkubWl6ZXIuTW9uaXRvckRteFVuaXZlcnNlUgl1bml2ZXJzZXM=');
@$core.Deprecated('Use monitorDmxUniverseDescriptor instead')
const MonitorDmxUniverse$json = const {
  '1': 'MonitorDmxUniverse',
  '2': const [
    const {'1': 'universe', '3': 1, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'channels', '3': 2, '4': 1, '5': 12, '10': 'channels'},
  ],
};

/// Descriptor for `MonitorDmxUniverse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorDmxUniverseDescriptor = $convert.base64Decode(
    'ChJNb25pdG9yRG14VW5pdmVyc2USGgoIdW5pdmVyc2UYASABKA1SCHVuaXZlcnNlEhoKCGNoYW5uZWxzGAIgASgMUghjaGFubmVscw==');
@$core.Deprecated('Use monitorMidiRequestDescriptor instead')
const MonitorMidiRequest$json = const {
  '1': 'MonitorMidiRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MonitorMidiRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorMidiRequestDescriptor =
    $convert.base64Decode('ChJNb25pdG9yTWlkaVJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use monitorMidiResponseDescriptor instead')
const MonitorMidiResponse$json = const {
  '1': 'MonitorMidiResponse',
  '2': const [
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 4, '10': 'timestamp'},
    const {
      '1': 'cc',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.mizer.MonitorMidiResponse.NoteMsg',
      '9': 0,
      '10': 'cc'
    },
    const {
      '1': 'note_off',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.mizer.MonitorMidiResponse.NoteMsg',
      '9': 0,
      '10': 'noteOff'
    },
    const {
      '1': 'note_on',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.mizer.MonitorMidiResponse.NoteMsg',
      '9': 0,
      '10': 'noteOn'
    },
    const {
      '1': 'sys_ex',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.mizer.MonitorMidiResponse.SysEx',
      '9': 0,
      '10': 'sysEx'
    },
    const {'1': 'unknown', '3': 7, '4': 1, '5': 12, '9': 0, '10': 'unknown'},
  ],
  '3': const [MonitorMidiResponse_NoteMsg$json, MonitorMidiResponse_SysEx$json],
  '8': const [
    const {'1': 'message'},
  ],
};

@$core.Deprecated('Use monitorMidiResponseDescriptor instead')
const MonitorMidiResponse_NoteMsg$json = const {
  '1': 'NoteMsg',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 13, '10': 'channel'},
    const {'1': 'note', '3': 2, '4': 1, '5': 13, '10': 'note'},
    const {'1': 'value', '3': 3, '4': 1, '5': 13, '10': 'value'},
  ],
};

@$core.Deprecated('Use monitorMidiResponseDescriptor instead')
const MonitorMidiResponse_SysEx$json = const {
  '1': 'SysEx',
  '2': const [
    const {'1': 'manufacturer1', '3': 1, '4': 1, '5': 13, '10': 'manufacturer1'},
    const {'1': 'manufacturer2', '3': 2, '4': 1, '5': 13, '10': 'manufacturer2'},
    const {'1': 'manufacturer3', '3': 3, '4': 1, '5': 13, '10': 'manufacturer3'},
    const {'1': 'model', '3': 4, '4': 1, '5': 13, '10': 'model'},
    const {'1': 'data', '3': 5, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `MonitorMidiResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorMidiResponseDescriptor = $convert.base64Decode(
    'ChNNb25pdG9yTWlkaVJlc3BvbnNlEhwKCXRpbWVzdGFtcBgCIAEoBFIJdGltZXN0YW1wEjQKAmNjGAMgASgLMiIubWl6ZXIuTW9uaXRvck1pZGlSZXNwb25zZS5Ob3RlTXNnSABSAmNjEj8KCG5vdGVfb2ZmGAQgASgLMiIubWl6ZXIuTW9uaXRvck1pZGlSZXNwb25zZS5Ob3RlTXNnSABSB25vdGVPZmYSPQoHbm90ZV9vbhgFIAEoCzIiLm1pemVyLk1vbml0b3JNaWRpUmVzcG9uc2UuTm90ZU1zZ0gAUgZub3RlT24SOQoGc3lzX2V4GAYgASgLMiAubWl6ZXIuTW9uaXRvck1pZGlSZXNwb25zZS5TeXNFeEgAUgVzeXNFeBIaCgd1bmtub3duGAcgASgMSABSB3Vua25vd24aTQoHTm90ZU1zZxIYCgdjaGFubmVsGAEgASgNUgdjaGFubmVsEhIKBG5vdGUYAiABKA1SBG5vdGUSFAoFdmFsdWUYAyABKA1SBXZhbHVlGqMBCgVTeXNFeBIkCg1tYW51ZmFjdHVyZXIxGAEgASgNUg1tYW51ZmFjdHVyZXIxEiQKDW1hbnVmYWN0dXJlcjIYAiABKA1SDW1hbnVmYWN0dXJlcjISJAoNbWFudWZhY3R1cmVyMxgDIAEoDVINbWFudWZhY3R1cmVyMxIUCgVtb2RlbBgEIAEoDVIFbW9kZWwSEgoEZGF0YRgFIAEoDFIEZGF0YUIJCgdtZXNzYWdl');
@$core.Deprecated('Use monitorOscRequestDescriptor instead')
const MonitorOscRequest$json = const {
  '1': 'MonitorOscRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MonitorOscRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorOscRequestDescriptor =
    $convert.base64Decode('ChFNb25pdG9yT3NjUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');
@$core.Deprecated('Use monitorOscResponseDescriptor instead')
const MonitorOscResponse$json = const {
  '1': 'MonitorOscResponse',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 4, '10': 'timestamp'},
    const {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
    const {
      '1': 'args',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.mizer.MonitorOscResponse.OscArgument',
      '10': 'args'
    },
  ],
  '3': const [MonitorOscResponse_OscArgument$json],
};

@$core.Deprecated('Use monitorOscResponseDescriptor instead')
const MonitorOscResponse_OscArgument$json = const {
  '1': 'OscArgument',
  '2': const [
    const {'1': 'int', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'int'},
    const {'1': 'float', '3': 2, '4': 1, '5': 2, '9': 0, '10': 'float'},
    const {'1': 'long', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'long'},
    const {'1': 'double', '3': 4, '4': 1, '5': 1, '9': 0, '10': 'double'},
    const {'1': 'bool', '3': 5, '4': 1, '5': 8, '9': 0, '10': 'bool'},
    const {
      '1': 'color',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.mizer.MonitorOscResponse.OscArgument.OscColor',
      '9': 0,
      '10': 'color'
    },
  ],
  '3': const [MonitorOscResponse_OscArgument_OscColor$json],
  '8': const [
    const {'1': 'argument'},
  ],
};

@$core.Deprecated('Use monitorOscResponseDescriptor instead')
const MonitorOscResponse_OscArgument_OscColor$json = const {
  '1': 'OscColor',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 13, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 13, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 13, '10': 'blue'},
    const {'1': 'alpha', '3': 4, '4': 1, '5': 13, '10': 'alpha'},
  ],
};

/// Descriptor for `MonitorOscResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitorOscResponseDescriptor = $convert.base64Decode(
    'ChJNb25pdG9yT3NjUmVzcG9uc2USHAoJdGltZXN0YW1wGAEgASgEUgl0aW1lc3RhbXASEgoEcGF0aBgCIAEoCVIEcGF0aBI5CgRhcmdzGAMgAygLMiUubWl6ZXIuTW9uaXRvck9zY1Jlc3BvbnNlLk9zY0FyZ3VtZW50UgRhcmdzGrECCgtPc2NBcmd1bWVudBISCgNpbnQYASABKAVIAFIDaW50EhYKBWZsb2F0GAIgASgCSABSBWZsb2F0EhQKBGxvbmcYAyABKANIAFIEbG9uZxIYCgZkb3VibGUYBCABKAFIAFIGZG91YmxlEhQKBGJvb2wYBSABKAhIAFIEYm9vbBJGCgVjb2xvchgGIAEoCzIuLm1pemVyLk1vbml0b3JPc2NSZXNwb25zZS5Pc2NBcmd1bWVudC5Pc2NDb2xvckgAUgVjb2xvchpcCghPc2NDb2xvchIQCgNyZWQYASABKA1SA3JlZBIUCgVncmVlbhgCIAEoDVIFZ3JlZW4SEgoEYmx1ZRgDIAEoDVIEYmx1ZRIUCgVhbHBoYRgEIAEoDVIFYWxwaGFCCgoIYXJndW1lbnQ=');
@$core.Deprecated('Use getConnectionsRequestDescriptor instead')
const GetConnectionsRequest$json = const {
  '1': 'GetConnectionsRequest',
};

/// Descriptor for `GetConnectionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getConnectionsRequestDescriptor =
    $convert.base64Decode('ChVHZXRDb25uZWN0aW9uc1JlcXVlc3Q=');
@$core.Deprecated('Use getDeviceProfilesRequestDescriptor instead')
const GetDeviceProfilesRequest$json = const {
  '1': 'GetDeviceProfilesRequest',
};

/// Descriptor for `GetDeviceProfilesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeviceProfilesRequestDescriptor =
    $convert.base64Decode('ChhHZXREZXZpY2VQcm9maWxlc1JlcXVlc3Q=');
@$core.Deprecated('Use artnetConfigDescriptor instead')
const ArtnetConfig$json = const {
  '1': 'ArtnetConfig',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'host', '3': 2, '4': 1, '5': 9, '10': 'host'},
    const {'1': 'port', '3': 3, '4': 1, '5': 13, '10': 'port'},
  ],
};

/// Descriptor for `ArtnetConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List artnetConfigDescriptor = $convert.base64Decode(
    'CgxBcnRuZXRDb25maWcSEgoEbmFtZRgBIAEoCVIEbmFtZRISCgRob3N0GAIgASgJUgRob3N0EhIKBHBvcnQYAyABKA1SBHBvcnQ=');
@$core.Deprecated('Use sacnConfigDescriptor instead')
const SacnConfig$json = const {
  '1': 'SacnConfig',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `SacnConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sacnConfigDescriptor =
    $convert.base64Decode('CgpTYWNuQ29uZmlnEhIKBG5hbWUYASABKAlSBG5hbWU=');
@$core.Deprecated('Use connectionsDescriptor instead')
const Connections$json = const {
  '1': 'Connections',
  '2': const [
    const {
      '1': 'connections',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mizer.Connection',
      '10': 'connections'
    },
  ],
};

/// Descriptor for `Connections`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionsDescriptor = $convert.base64Decode(
    'CgtDb25uZWN0aW9ucxIzCgtjb25uZWN0aW9ucxgBIAMoCzIRLm1pemVyLkNvbm5lY3Rpb25SC2Nvbm5lY3Rpb25z');
@$core.Deprecated('Use connectionDescriptor instead')
const Connection$json = const {
  '1': 'Connection',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'dmx', '3': 10, '4': 1, '5': 11, '6': '.mizer.DmxConnection', '9': 0, '10': 'dmx'},
    const {
      '1': 'midi',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.mizer.MidiConnection',
      '9': 0,
      '10': 'midi'
    },
    const {'1': 'osc', '3': 12, '4': 1, '5': 11, '6': '.mizer.OscConnection', '9': 0, '10': 'osc'},
    const {
      '1': 'pro_dj_link',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.mizer.ProDjLinkConnection',
      '9': 0,
      '10': 'proDjLink'
    },
    const {
      '1': 'helios',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.mizer.HeliosConnection',
      '9': 0,
      '10': 'helios'
    },
    const {
      '1': 'ether_dream',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.mizer.EtherDreamConnection',
      '9': 0,
      '10': 'etherDream'
    },
    const {
      '1': 'gamepad',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.mizer.GamepadConnection',
      '9': 0,
      '10': 'gamepad'
    },
    const {
      '1': 'mqtt',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.mizer.MqttConnection',
      '9': 0,
      '10': 'mqtt'
    },
    const {'1': 'g13', '3': 18, '4': 1, '5': 11, '6': '.mizer.G13Connection', '9': 0, '10': 'g13'},
    const {
      '1': 'webcam',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.mizer.WebcamConnection',
      '9': 0,
      '10': 'webcam'
    },
  ],
  '8': const [
    const {'1': 'connection'},
  ],
};

/// Descriptor for `Connection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionDescriptor = $convert.base64Decode(
    'CgpDb25uZWN0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSKAoDZG14GAogASgLMhQubWl6ZXIuRG14Q29ubmVjdGlvbkgAUgNkbXgSKwoEbWlkaRgLIAEoCzIVLm1pemVyLk1pZGlDb25uZWN0aW9uSABSBG1pZGkSKAoDb3NjGAwgASgLMhQubWl6ZXIuT3NjQ29ubmVjdGlvbkgAUgNvc2MSPAoLcHJvX2RqX2xpbmsYDSABKAsyGi5taXplci5Qcm9EakxpbmtDb25uZWN0aW9uSABSCXByb0RqTGluaxIxCgZoZWxpb3MYDiABKAsyFy5taXplci5IZWxpb3NDb25uZWN0aW9uSABSBmhlbGlvcxI+CgtldGhlcl9kcmVhbRgPIAEoCzIbLm1pemVyLkV0aGVyRHJlYW1Db25uZWN0aW9uSABSCmV0aGVyRHJlYW0SNAoHZ2FtZXBhZBgQIAEoCzIYLm1pemVyLkdhbWVwYWRDb25uZWN0aW9uSABSB2dhbWVwYWQSKwoEbXF0dBgRIAEoCzIVLm1pemVyLk1xdHRDb25uZWN0aW9uSABSBG1xdHQSKAoDZzEzGBIgASgLMhQubWl6ZXIuRzEzQ29ubmVjdGlvbkgAUgNnMTMSMQoGd2ViY2FtGBMgASgLMhcubWl6ZXIuV2ViY2FtQ29ubmVjdGlvbkgAUgZ3ZWJjYW1CDAoKY29ubmVjdGlvbg==');
@$core.Deprecated('Use dmxConnectionDescriptor instead')
const DmxConnection$json = const {
  '1': 'DmxConnection',
  '2': const [
    const {'1': 'output_id', '3': 1, '4': 1, '5': 9, '10': 'outputId'},
    const {
      '1': 'artnet',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.mizer.ArtnetConfig',
      '9': 0,
      '10': 'artnet'
    },
    const {'1': 'sacn', '3': 4, '4': 1, '5': 11, '6': '.mizer.SacnConfig', '9': 0, '10': 'sacn'},
  ],
  '8': const [
    const {'1': 'config'},
  ],
};

/// Descriptor for `DmxConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dmxConnectionDescriptor = $convert.base64Decode(
    'Cg1EbXhDb25uZWN0aW9uEhsKCW91dHB1dF9pZBgBIAEoCVIIb3V0cHV0SWQSLQoGYXJ0bmV0GAMgASgLMhMubWl6ZXIuQXJ0bmV0Q29uZmlnSABSBmFydG5ldBInCgRzYWNuGAQgASgLMhEubWl6ZXIuU2FjbkNvbmZpZ0gAUgRzYWNuQggKBmNvbmZpZw==');
@$core.Deprecated('Use heliosConnectionDescriptor instead')
const HeliosConnection$json = const {
  '1': 'HeliosConnection',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'firmware', '3': 2, '4': 1, '5': 13, '10': 'firmware'},
  ],
};

/// Descriptor for `HeliosConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heliosConnectionDescriptor = $convert.base64Decode(
    'ChBIZWxpb3NDb25uZWN0aW9uEhIKBG5hbWUYASABKAlSBG5hbWUSGgoIZmlybXdhcmUYAiABKA1SCGZpcm13YXJl');
@$core.Deprecated('Use etherDreamConnectionDescriptor instead')
const EtherDreamConnection$json = const {
  '1': 'EtherDreamConnection',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `EtherDreamConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List etherDreamConnectionDescriptor =
    $convert.base64Decode('ChRFdGhlckRyZWFtQ29ubmVjdGlvbhISCgRuYW1lGAEgASgJUgRuYW1l');
@$core.Deprecated('Use gamepadConnectionDescriptor instead')
const GamepadConnection$json = const {
  '1': 'GamepadConnection',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `GamepadConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gamepadConnectionDescriptor = $convert
    .base64Decode('ChFHYW1lcGFkQ29ubmVjdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use g13ConnectionDescriptor instead')
const G13Connection$json = const {
  '1': 'G13Connection',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `G13Connection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List g13ConnectionDescriptor =
    $convert.base64Decode('Cg1HMTNDb25uZWN0aW9uEg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use webcamConnectionDescriptor instead')
const WebcamConnection$json = const {
  '1': 'WebcamConnection',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `WebcamConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webcamConnectionDescriptor = $convert
    .base64Decode('ChBXZWJjYW1Db25uZWN0aW9uEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use midiConnectionDescriptor instead')
const MidiConnection$json = const {
  '1': 'MidiConnection',
  '2': const [
    const {
      '1': 'device_profile',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'deviceProfile',
      '17': true
    },
  ],
  '8': const [
    const {'1': '_device_profile'},
  ],
};

/// Descriptor for `MidiConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiConnectionDescriptor = $convert.base64Decode(
    'Cg5NaWRpQ29ubmVjdGlvbhIqCg5kZXZpY2VfcHJvZmlsZRgBIAEoCUgAUg1kZXZpY2VQcm9maWxliAEBQhEKD19kZXZpY2VfcHJvZmlsZQ==');
@$core.Deprecated('Use midiDeviceProfilesDescriptor instead')
const MidiDeviceProfiles$json = const {
  '1': 'MidiDeviceProfiles',
  '2': const [
    const {
      '1': 'profiles',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.mizer.MidiDeviceProfile',
      '10': 'profiles'
    },
  ],
};

/// Descriptor for `MidiDeviceProfiles`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfilesDescriptor = $convert.base64Decode(
    'ChJNaWRpRGV2aWNlUHJvZmlsZXMSNAoIcHJvZmlsZXMYASADKAsyGC5taXplci5NaWRpRGV2aWNlUHJvZmlsZVIIcHJvZmlsZXM=');
@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile$json = const {
  '1': 'MidiDeviceProfile',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'manufacturer', '3': 2, '4': 1, '5': 9, '10': 'manufacturer'},
    const {'1': 'model', '3': 3, '4': 1, '5': 9, '10': 'model'},
    const {'1': 'layout', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'layout', '17': true},
    const {
      '1': 'pages',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.mizer.MidiDeviceProfile.Page',
      '10': 'pages'
    },
  ],
  '3': const [
    MidiDeviceProfile_Page$json,
    MidiDeviceProfile_Group$json,
    MidiDeviceProfile_Control$json
  ],
  '8': const [
    const {'1': '_layout'},
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Page$json = const {
  '1': 'Page',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {
      '1': 'groups',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.mizer.MidiDeviceProfile.Group',
      '10': 'groups'
    },
    const {
      '1': 'controls',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.mizer.MidiDeviceProfile.Control',
      '10': 'controls'
    },
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Group$json = const {
  '1': 'Group',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {
      '1': 'controls',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.mizer.MidiDeviceProfile.Control',
      '10': 'controls'
    },
  ],
};

@$core.Deprecated('Use midiDeviceProfileDescriptor instead')
const MidiDeviceProfile_Control$json = const {
  '1': 'Control',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'has_input', '3': 3, '4': 1, '5': 8, '10': 'hasInput'},
    const {'1': 'has_output', '3': 4, '4': 1, '5': 8, '10': 'hasOutput'},
  ],
};

/// Descriptor for `MidiDeviceProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List midiDeviceProfileDescriptor = $convert.base64Decode(
    'ChFNaWRpRGV2aWNlUHJvZmlsZRIOCgJpZBgBIAEoCVICaWQSIgoMbWFudWZhY3R1cmVyGAIgASgJUgxtYW51ZmFjdHVyZXISFAoFbW9kZWwYAyABKAlSBW1vZGVsEhsKBmxheW91dBgEIAEoCUgAUgZsYXlvdXSIAQESMwoFcGFnZXMYBSADKAsyHS5taXplci5NaWRpRGV2aWNlUHJvZmlsZS5QYWdlUgVwYWdlcxqQAQoEUGFnZRISCgRuYW1lGAEgASgJUgRuYW1lEjYKBmdyb3VwcxgCIAMoCzIeLm1pemVyLk1pZGlEZXZpY2VQcm9maWxlLkdyb3VwUgZncm91cHMSPAoIY29udHJvbHMYAyADKAsyIC5taXplci5NaWRpRGV2aWNlUHJvZmlsZS5Db250cm9sUghjb250cm9scxpZCgVHcm91cBISCgRuYW1lGAEgASgJUgRuYW1lEjwKCGNvbnRyb2xzGAIgAygLMiAubWl6ZXIuTWlkaURldmljZVByb2ZpbGUuQ29udHJvbFIIY29udHJvbHMaaQoHQ29udHJvbBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIbCgloYXNfaW5wdXQYAyABKAhSCGhhc0lucHV0Eh0KCmhhc19vdXRwdXQYBCABKAhSCWhhc091dHB1dEIJCgdfbGF5b3V0');
@$core.Deprecated('Use oscConnectionDescriptor instead')
const OscConnection$json = const {
  '1': 'OscConnection',
  '2': const [
    const {'1': 'connection_id', '3': 1, '4': 1, '5': 9, '10': 'connectionId'},
    const {'1': 'input_port', '3': 2, '4': 1, '5': 13, '10': 'inputPort'},
    const {'1': 'output_port', '3': 3, '4': 1, '5': 13, '10': 'outputPort'},
    const {'1': 'output_address', '3': 4, '4': 1, '5': 9, '10': 'outputAddress'},
  ],
};

/// Descriptor for `OscConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List oscConnectionDescriptor = $convert.base64Decode(
    'Cg1Pc2NDb25uZWN0aW9uEiMKDWNvbm5lY3Rpb25faWQYASABKAlSDGNvbm5lY3Rpb25JZBIdCgppbnB1dF9wb3J0GAIgASgNUglpbnB1dFBvcnQSHwoLb3V0cHV0X3BvcnQYAyABKA1SCm91dHB1dFBvcnQSJQoOb3V0cHV0X2FkZHJlc3MYBCABKAlSDW91dHB1dEFkZHJlc3M=');
@$core.Deprecated('Use proDjLinkConnectionDescriptor instead')
const ProDjLinkConnection$json = const {
  '1': 'ProDjLinkConnection',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'model', '3': 2, '4': 1, '5': 9, '10': 'model'},
    const {'1': 'player_number', '3': 3, '4': 1, '5': 13, '10': 'playerNumber'},
    const {'1': 'playback', '3': 5, '4': 1, '5': 11, '6': '.mizer.CdjPlayback', '10': 'playback'},
  ],
};

/// Descriptor for `ProDjLinkConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List proDjLinkConnectionDescriptor = $convert.base64Decode(
    'ChNQcm9EakxpbmtDb25uZWN0aW9uEhgKB2FkZHJlc3MYASABKAlSB2FkZHJlc3MSFAoFbW9kZWwYAiABKAlSBW1vZGVsEiMKDXBsYXllcl9udW1iZXIYAyABKA1SDHBsYXllck51bWJlchIuCghwbGF5YmFjaxgFIAEoCzISLm1pemVyLkNkalBsYXliYWNrUghwbGF5YmFjaw==');
@$core.Deprecated('Use cdjPlaybackDescriptor instead')
const CdjPlayback$json = const {
  '1': 'CdjPlayback',
  '2': const [
    const {'1': 'live', '3': 1, '4': 1, '5': 8, '10': 'live'},
    const {'1': 'bpm', '3': 2, '4': 1, '5': 1, '10': 'bpm'},
    const {'1': 'frame', '3': 3, '4': 1, '5': 13, '10': 'frame'},
    const {
      '1': 'playback',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.mizer.CdjPlayback.State',
      '10': 'playback'
    },
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
    const {'1': 'LOADING', '2': 0},
    const {'1': 'PLAYING', '2': 1},
    const {'1': 'CUED', '2': 2},
    const {'1': 'CUEING', '2': 3},
  ],
};

/// Descriptor for `CdjPlayback`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cdjPlaybackDescriptor = $convert.base64Decode(
    'CgtDZGpQbGF5YmFjaxISCgRsaXZlGAEgASgIUgRsaXZlEhAKA2JwbRgCIAEoAVIDYnBtEhQKBWZyYW1lGAMgASgNUgVmcmFtZRI0CghwbGF5YmFjaxgEIAEoDjIYLm1pemVyLkNkalBsYXliYWNrLlN0YXRlUghwbGF5YmFjaxIuCgV0cmFjaxgFIAEoCzIYLm1pemVyLkNkalBsYXliYWNrLlRyYWNrUgV0cmFjaxo1CgVUcmFjaxIWCgZhcnRpc3QYASABKAlSBmFydGlzdBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUiNwoFU3RhdGUSCwoHTE9BRElORxAAEgsKB1BMQVlJTkcQARIICgRDVUVEEAISCgoGQ1VFSU5HEAM=');
@$core.Deprecated('Use mqttConnectionDescriptor instead')
const MqttConnection$json = const {
  '1': 'MqttConnection',
  '2': const [
    const {'1': 'connection_id', '3': 1, '4': 1, '5': 9, '10': 'connectionId'},
    const {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'username', '17': true},
    const {'1': 'password', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'password', '17': true},
  ],
  '8': const [
    const {'1': '_username'},
    const {'1': '_password'},
  ],
};

/// Descriptor for `MqttConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mqttConnectionDescriptor = $convert.base64Decode(
    'Cg5NcXR0Q29ubmVjdGlvbhIjCg1jb25uZWN0aW9uX2lkGAEgASgJUgxjb25uZWN0aW9uSWQSEAoDdXJsGAIgASgJUgN1cmwSHwoIdXNlcm5hbWUYAyABKAlIAFIIdXNlcm5hbWWIAQESHwoIcGFzc3dvcmQYBCABKAlIAVIIcGFzc3dvcmSIAQFCCwoJX3VzZXJuYW1lQgsKCV9wYXNzd29yZA==');
@$core.Deprecated('Use configureConnectionRequestDescriptor instead')
const ConfigureConnectionRequest$json = const {
  '1': 'ConfigureConnectionRequest',
  '2': const [
    const {'1': 'dmx', '3': 1, '4': 1, '5': 11, '6': '.mizer.DmxConnection', '9': 0, '10': 'dmx'},
    const {
      '1': 'mqtt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.mizer.MqttConnection',
      '9': 0,
      '10': 'mqtt'
    },
    const {'1': 'osc', '3': 3, '4': 1, '5': 11, '6': '.mizer.OscConnection', '9': 0, '10': 'osc'},
  ],
  '8': const [
    const {'1': 'config'},
  ],
};

/// Descriptor for `ConfigureConnectionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List configureConnectionRequestDescriptor = $convert.base64Decode(
    'ChpDb25maWd1cmVDb25uZWN0aW9uUmVxdWVzdBIoCgNkbXgYASABKAsyFC5taXplci5EbXhDb25uZWN0aW9uSABSA2RteBIrCgRtcXR0GAIgASgLMhUubWl6ZXIuTXF0dENvbm5lY3Rpb25IAFIEbXF0dBIoCgNvc2MYAyABKAsyFC5taXplci5Pc2NDb25uZWN0aW9uSABSA29zY0IICgZjb25maWc=');
