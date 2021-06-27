///
//  Generated code. Do not modify.
//  source: session.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const ProjectRequest$json = const {
  '1': 'ProjectRequest',
};

const OpenProjectRequest$json = const {
  '1': 'OpenProjectRequest',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

const ProjectResponse$json = const {
  '1': 'ProjectResponse',
};

const ClientAnnouncement$json = const {
  '1': 'ClientAnnouncement',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

const SessionRequest$json = const {
  '1': 'SessionRequest',
};

const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'devices', '3': 1, '4': 3, '5': 11, '6': '.mizer.SessionDevice', '10': 'devices'},
  ],
};

const SessionDevice$json = const {
  '1': 'SessionDevice',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'ips', '3': 2, '4': 3, '5': 9, '10': 'ips'},
    const {'1': 'clock', '3': 3, '4': 1, '5': 11, '6': '.mizer.DeviceClock', '10': 'clock'},
    const {'1': 'ping', '3': 4, '4': 1, '5': 1, '10': 'ping'},
  ],
};

const DeviceClock$json = const {
  '1': 'DeviceClock',
  '2': const [
    const {'1': 'master', '3': 1, '4': 1, '5': 8, '10': 'master'},
    const {'1': 'drift', '3': 2, '4': 1, '5': 1, '10': 'drift'},
  ],
};

