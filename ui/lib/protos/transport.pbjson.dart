///
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const TransportState$json = const {
  '1': 'TransportState',
  '2': const [
    const {'1': 'Stopped', '2': 0},
    const {'1': 'Paused', '2': 1},
    const {'1': 'Playing', '2': 2},
  ],
};

const SubscribeTransportRequest$json = const {
  '1': 'SubscribeTransportRequest',
};

const Transport$json = const {
  '1': 'Transport',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.mizer.TransportState', '10': 'state'},
    const {'1': 'speed', '3': 2, '4': 1, '5': 1, '10': 'speed'},
    const {'1': 'timecode', '3': 3, '4': 1, '5': 11, '6': '.mizer.Timecode', '10': 'timecode'},
  ],
};

const Timecode$json = const {
  '1': 'Timecode',
  '2': const [
    const {'1': 'frames', '3': 1, '4': 1, '5': 4, '10': 'frames'},
    const {'1': 'seconds', '3': 2, '4': 1, '5': 4, '10': 'seconds'},
    const {'1': 'minutes', '3': 3, '4': 1, '5': 4, '10': 'minutes'},
    const {'1': 'hours', '3': 4, '4': 1, '5': 4, '10': 'hours'},
  ],
};

const SetTransportRequest$json = const {
  '1': 'SetTransportRequest',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.mizer.TransportState', '10': 'state'},
  ],
};

const SetBpmRequest$json = const {
  '1': 'SetBpmRequest',
  '2': const [
    const {'1': 'bpm', '3': 1, '4': 1, '5': 1, '10': 'bpm'},
  ],
};

