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
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 13, '10': 'fixtures'},
    const {'1': 'channel', '3': 2, '4': 1, '5': 9, '10': 'channel'},
    const {'1': 'value', '3': 3, '4': 1, '5': 11, '6': '.mizer.CueValue', '10': 'value'},
    const {'1': 'fade', '3': 4, '4': 1, '5': 11, '6': '.mizer.CueTimer', '10': 'fade'},
    const {'1': 'delay', '3': 5, '4': 1, '5': 11, '6': '.mizer.CueTimer', '10': 'delay'},
  ],
};

const CueValue$json = const {
  '1': 'CueValue',
  '2': const [
    const {'1': 'direct', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'direct'},
    const {'1': 'range', '3': 4, '4': 1, '5': 11, '6': '.mizer.CueValueRange', '9': 0, '10': 'range'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

const CueTimer$json = const {
  '1': 'CueTimer',
  '2': const [
    const {'1': 'hasTimer', '3': 1, '4': 1, '5': 8, '10': 'hasTimer'},
    const {'1': 'direct', '3': 2, '4': 1, '5': 11, '6': '.mizer.CueTime', '9': 0, '10': 'direct'},
    const {'1': 'range', '3': 3, '4': 1, '5': 11, '6': '.mizer.CueTimerRange', '9': 0, '10': 'range'},
  ],
  '8': const [
    const {'1': 'timer'},
  ],
};

const CueValueRange$json = const {
  '1': 'CueValueRange',
  '2': const [
    const {'1': 'from', '3': 1, '4': 1, '5': 1, '10': 'from'},
    const {'1': 'to', '3': 2, '4': 1, '5': 1, '10': 'to'},
  ],
};

const CueTime$json = const {
  '1': 'CueTime',
  '2': const [
    const {'1': 'seconds', '3': 1, '4': 1, '5': 1, '9': 0, '10': 'seconds'},
    const {'1': 'beats', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'beats'},
  ],
  '8': const [
    const {'1': 'time'},
  ],
};

const CueTimerRange$json = const {
  '1': 'CueTimerRange',
  '2': const [
    const {'1': 'from', '3': 1, '4': 1, '5': 11, '6': '.mizer.CueTime', '10': 'from'},
    const {'1': 'to', '3': 2, '4': 1, '5': 11, '6': '.mizer.CueTime', '10': 'to'},
  ],
};

