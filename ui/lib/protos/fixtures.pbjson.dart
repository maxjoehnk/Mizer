///
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const FixtureControl$json = const {
  '1': 'FixtureControl',
  '2': const [
    const {'1': 'INTENSITY', '2': 0},
    const {'1': 'SHUTTER', '2': 1},
    const {'1': 'COLOR', '2': 2},
    const {'1': 'PAN', '2': 3},
    const {'1': 'TILT', '2': 4},
    const {'1': 'FOCUS', '2': 5},
    const {'1': 'ZOOM', '2': 6},
    const {'1': 'PRISM', '2': 7},
    const {'1': 'IRIS', '2': 8},
    const {'1': 'FROST', '2': 9},
    const {'1': 'GENERIC', '2': 10},
  ],
};

const AddFixturesRequest$json = const {
  '1': 'AddFixturesRequest',
  '2': const [
    const {'1': 'requests', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.AddFixtureRequest', '10': 'requests'},
  ],
};

const AddFixtureRequest$json = const {
  '1': 'AddFixtureRequest',
  '2': const [
    const {'1': 'definitionId', '3': 1, '4': 1, '5': 9, '10': 'definitionId'},
    const {'1': 'mode', '3': 2, '4': 1, '5': 9, '10': 'mode'},
    const {'1': 'id', '3': 3, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'channel', '3': 4, '4': 1, '5': 13, '10': 'channel'},
    const {'1': 'universe', '3': 5, '4': 1, '5': 13, '10': 'universe'},
  ],
};

const GetFixturesRequest$json = const {
  '1': 'GetFixturesRequest',
};

const Fixtures$json = const {
  '1': 'Fixtures',
  '2': const [
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.Fixture', '10': 'fixtures'},
  ],
};

const Fixture$json = const {
  '1': 'Fixture',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'manufacturer', '3': 3, '4': 1, '5': 9, '10': 'manufacturer'},
    const {'1': 'mode', '3': 4, '4': 1, '5': 9, '10': 'mode'},
    const {'1': 'universe', '3': 5, '4': 1, '5': 13, '10': 'universe'},
    const {'1': 'channel', '3': 6, '4': 1, '5': 13, '10': 'channel'},
    const {'1': 'controls', '3': 7, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureControls', '10': 'controls'},
  ],
};

const FixtureControls$json = const {
  '1': 'FixtureControls',
  '2': const [
    const {'1': 'control', '3': 1, '4': 1, '5': 14, '6': '.mizer.fixtures.FixtureControl', '10': 'control'},
    const {'1': 'fader', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.FaderChannel', '9': 0, '10': 'fader'},
    const {'1': 'color', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.ColorChannel', '9': 0, '10': 'color'},
    const {'1': 'axis', '3': 4, '4': 1, '5': 11, '6': '.mizer.fixtures.AxisChannel', '9': 0, '10': 'axis'},
    const {'1': 'generic', '3': 5, '4': 1, '5': 11, '6': '.mizer.fixtures.GenericChannel', '9': 0, '10': 'generic'},
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

const FaderChannel$json = const {
  '1': 'FaderChannel',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

const ColorChannel$json = const {
  '1': 'ColorChannel',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 1, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 1, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 1, '10': 'blue'},
  ],
};

const AxisChannel$json = const {
  '1': 'AxisChannel',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'angle_from', '3': 2, '4': 1, '5': 1, '10': 'angleFrom'},
    const {'1': 'angle_to', '3': 3, '4': 1, '5': 1, '10': 'angleTo'},
  ],
};

const GenericChannel$json = const {
  '1': 'GenericChannel',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

const GetFixtureDefinitionsRequest$json = const {
  '1': 'GetFixtureDefinitionsRequest',
};

const FixtureDefinitions$json = const {
  '1': 'FixtureDefinitions',
  '2': const [
    const {'1': 'definitions', '3': 1, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureDefinition', '10': 'definitions'},
  ],
};

const FixtureDefinition$json = const {
  '1': 'FixtureDefinition',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'manufacturer', '3': 3, '4': 1, '5': 9, '10': 'manufacturer'},
    const {'1': 'modes', '3': 4, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureMode', '10': 'modes'},
    const {'1': 'physical', '3': 5, '4': 1, '5': 11, '6': '.mizer.fixtures.FixturePhysicalData', '10': 'physical'},
    const {'1': 'tags', '3': 6, '4': 3, '5': 9, '10': 'tags'},
  ],
};

const FixtureMode$json = const {
  '1': 'FixtureMode',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.fixtures.FixtureChannel', '10': 'channels'},
  ],
};

const FixtureChannel$json = const {
  '1': 'FixtureChannel',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'coarse', '3': 2, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.CoarseResolution', '9': 0, '10': 'coarse'},
    const {'1': 'fine', '3': 3, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.FineResolution', '9': 0, '10': 'fine'},
    const {'1': 'finest', '3': 4, '4': 1, '5': 11, '6': '.mizer.fixtures.FixtureChannel.FinestResolution', '9': 0, '10': 'finest'},
  ],
  '3': const [FixtureChannel_CoarseResolution$json, FixtureChannel_FineResolution$json, FixtureChannel_FinestResolution$json],
  '8': const [
    const {'1': 'resolution'},
  ],
};

const FixtureChannel_CoarseResolution$json = const {
  '1': 'CoarseResolution',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 13, '10': 'channel'},
  ],
};

const FixtureChannel_FineResolution$json = const {
  '1': 'FineResolution',
  '2': const [
    const {'1': 'fineChannel', '3': 1, '4': 1, '5': 13, '10': 'fineChannel'},
    const {'1': 'coarseChannel', '3': 2, '4': 1, '5': 13, '10': 'coarseChannel'},
  ],
};

const FixtureChannel_FinestResolution$json = const {
  '1': 'FinestResolution',
  '2': const [
    const {'1': 'finestChannel', '3': 1, '4': 1, '5': 13, '10': 'finestChannel'},
    const {'1': 'fineChannel', '3': 2, '4': 1, '5': 13, '10': 'fineChannel'},
    const {'1': 'coarseChannel', '3': 3, '4': 1, '5': 13, '10': 'coarseChannel'},
  ],
};

const FixturePhysicalData$json = const {
  '1': 'FixturePhysicalData',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 2, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 2, '10': 'height'},
    const {'1': 'depth', '3': 3, '4': 1, '5': 2, '10': 'depth'},
    const {'1': 'weight', '3': 4, '4': 1, '5': 2, '10': 'weight'},
  ],
};

