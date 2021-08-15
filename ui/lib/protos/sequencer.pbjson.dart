///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const CueTrigger$json = const {
  '1': 'CueTrigger',
  '2': const [
    const {'1': 'GO', '2': 0},
    const {'1': 'FOLLOW', '2': 1},
    const {'1': 'BEATS', '2': 2},
    const {'1': 'TIMECODE', '2': 3},
  ],
};

const GetSequencesRequest$json = const {
  '1': 'GetSequencesRequest',
};

const AddSequenceRequest$json = const {
  '1': 'AddSequenceRequest',
};

const SequenceGoRequest$json = const {
  '1': 'SequenceGoRequest',
  '2': const [
    const {'1': 'sequence', '3': 1, '4': 1, '5': 13, '10': 'sequence'},
  ],
};

const EmptyResponse$json = const {
  '1': 'EmptyResponse',
};

const Sequences$json = const {
  '1': 'Sequences',
  '2': const [
    const {'1': 'sequences', '3': 1, '4': 3, '5': 11, '6': '.mizer.Sequence', '10': 'sequences'},
  ],
};

const Sequence$json = const {
  '1': 'Sequence',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'cues', '3': 3, '4': 3, '5': 11, '6': '.mizer.Cue', '10': 'cues'},
  ],
};

const Cue$json = const {
  '1': 'Cue',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'trigger', '3': 3, '4': 1, '5': 14, '6': '.mizer.CueTrigger', '10': 'trigger'},
    const {'1': 'loop', '3': 4, '4': 1, '5': 8, '10': 'loop'},
    const {'1': 'channels', '3': 5, '4': 3, '5': 11, '6': '.mizer.CueChannel', '10': 'channels'},
  ],
};

const CueChannel$json = const {
  '1': 'CueChannel',
  '2': const [
    const {'1': 'fixture', '3': 1, '4': 1, '5': 13, '10': 'fixture'},
    const {'1': 'channel', '3': 2, '4': 1, '5': 9, '10': 'channel'},
  ],
};

