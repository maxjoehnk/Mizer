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

const CueControl$json = const {
  '1': 'CueControl',
  '2': const [
    const {'1': 'INTENSITY', '2': 0},
    const {'1': 'SHUTTER', '2': 1},
    const {'1': 'COLOR_RED', '2': 2},
    const {'1': 'COLOR_GREEN', '2': 3},
    const {'1': 'COLOR_BLUE', '2': 4},
    const {'1': 'PAN', '2': 5},
    const {'1': 'TILT', '2': 6},
    const {'1': 'FOCUS', '2': 7},
    const {'1': 'ZOOM', '2': 8},
    const {'1': 'PRISM', '2': 9},
    const {'1': 'IRIS', '2': 10},
    const {'1': 'FROST', '2': 11},
    const {'1': 'GENERIC', '2': 12},
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
    const {'1': 'sequences', '3': 1, '4': 3, '5': 11, '6': '.mizer.sequencer.Sequence', '10': 'sequences'},
  ],
};

const Sequence$json = const {
  '1': 'Sequence',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'cues', '3': 3, '4': 3, '5': 11, '6': '.mizer.sequencer.Cue', '10': 'cues'},
  ],
};

const Cue$json = const {
  '1': 'Cue',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'trigger', '3': 3, '4': 1, '5': 14, '6': '.mizer.sequencer.CueTrigger', '10': 'trigger'},
    const {'1': 'loop', '3': 4, '4': 1, '5': 8, '10': 'loop'},
    const {'1': 'channels', '3': 5, '4': 3, '5': 11, '6': '.mizer.sequencer.CueChannel', '10': 'channels'},
  ],
};

const CueChannel$json = const {
  '1': 'CueChannel',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 13, '10': 'fixtures'},
    const {'1': 'control', '3': 2, '4': 1, '5': 14, '6': '.mizer.sequencer.CueControl', '10': 'control'},
    const {'1': 'value', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValue', '10': 'value'},
    const {'1': 'fade', '3': 4, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'fade'},
    const {'1': 'delay', '3': 5, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimer', '10': 'delay'},
  ],
};

const CueValue$json = const {
  '1': 'CueValue',
  '2': const [
    const {'1': 'direct', '3': 3, '4': 1, '5': 1, '9': 0, '10': 'direct'},
    const {'1': 'range', '3': 4, '4': 1, '5': 11, '6': '.mizer.sequencer.CueValueRange', '9': 0, '10': 'range'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

const CueTimer$json = const {
  '1': 'CueTimer',
  '2': const [
    const {'1': 'hasTimer', '3': 1, '4': 1, '5': 8, '10': 'hasTimer'},
    const {'1': 'direct', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '9': 0, '10': 'direct'},
    const {'1': 'range', '3': 3, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTimerRange', '9': 0, '10': 'range'},
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
    const {'1': 'from', '3': 1, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '10': 'from'},
    const {'1': 'to', '3': 2, '4': 1, '5': 11, '6': '.mizer.sequencer.CueTime', '10': 'to'},
  ],
};

