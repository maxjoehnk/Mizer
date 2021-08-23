///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const SubscribeProgrammerRequest$json = const {
  '1': 'SubscribeProgrammerRequest',
};

const ProgrammerState$json = const {
  '1': 'ProgrammerState',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 13, '10': 'fixtures'},
  ],
};

const WriteControlRequest$json = const {
  '1': 'WriteControlRequest',
  '2': const [
    const {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    const {'1': 'fader', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'fader'},
    const {'1': 'color', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorChannel', '9': 0, '10': 'color'},
    const {'1': 'generic', '3': 4, '4': 1, '5': 11, '6': '.mizer.programmer.WriteControlRequest.GenericValue', '9': 0, '10': 'generic'},
  ],
  '3': const [WriteControlRequest_GenericValue$json],
  '8': const [
    const {'1': 'value'},
  ],
};

const WriteControlRequest_GenericValue$json = const {
  '1': 'GenericValue',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

const WriteControlResponse$json = const {
  '1': 'WriteControlResponse',
};

const SelectFixturesRequest$json = const {
  '1': 'SelectFixturesRequest',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 13, '10': 'fixtures'},
  ],
};

const SelectFixturesResponse$json = const {
  '1': 'SelectFixturesResponse',
};

const ClearRequest$json = const {
  '1': 'ClearRequest',
};

const ClearResponse$json = const {
  '1': 'ClearResponse',
};

const HighlightRequest$json = const {
  '1': 'HighlightRequest',
  '2': const [
    const {'1': 'highlight', '3': 1, '4': 1, '5': 8, '10': 'highlight'},
  ],
};

const HighlightResponse$json = const {
  '1': 'HighlightResponse',
};

const StoreRequest$json = const {
  '1': 'StoreRequest',
  '2': const [
    const {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
    const {'1': 'store_mode', '3': 2, '4': 1, '5': 14, '6': '.mizer.programmer.StoreRequest.Mode', '10': 'storeMode'},
  ],
  '4': const [StoreRequest_Mode$json],
};

const StoreRequest_Mode$json = const {
  '1': 'Mode',
  '2': const [
    const {'1': 'Overwrite', '2': 0},
    const {'1': 'Merge', '2': 1},
    const {'1': 'AddCue', '2': 2},
  ],
};

const StoreResponse$json = const {
  '1': 'StoreResponse',
};

