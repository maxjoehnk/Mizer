///
//  Generated code. Do not modify.
//  source: fixtures.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const AddFixturesRequest$json = const {
  '1': 'AddFixturesRequest',
  '2': const [
    const {'1': 'requests', '3': 1, '4': 3, '5': 11, '6': '.mizer.AddFixtureRequest', '10': 'requests'},
    const {'1': 'create_nodes', '3': 2, '4': 1, '5': 8, '10': 'createNodes'},
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
    const {'1': 'fixtures', '3': 1, '4': 3, '5': 11, '6': '.mizer.Fixture', '10': 'fixtures'},
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
  ],
};

const GetFixtureDefinitionsRequest$json = const {
  '1': 'GetFixtureDefinitionsRequest',
};

const FixtureDefinitions$json = const {
  '1': 'FixtureDefinitions',
  '2': const [
    const {'1': 'definitions', '3': 1, '4': 3, '5': 11, '6': '.mizer.FixtureDefinition', '10': 'definitions'},
  ],
};

const FixtureDefinition$json = const {
  '1': 'FixtureDefinition',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'manufacturer', '3': 3, '4': 1, '5': 9, '10': 'manufacturer'},
    const {'1': 'modes', '3': 4, '4': 3, '5': 11, '6': '.mizer.FixtureMode', '10': 'modes'},
    const {'1': 'physical', '3': 5, '4': 1, '5': 11, '6': '.mizer.FixturePhysicalData', '10': 'physical'},
    const {'1': 'tags', '3': 6, '4': 3, '5': 9, '10': 'tags'},
  ],
};

const FixtureMode$json = const {
  '1': 'FixtureMode',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'channels', '3': 2, '4': 3, '5': 11, '6': '.mizer.FixtureChannel', '10': 'channels'},
  ],
};

const FixtureChannel$json = const {
  '1': 'FixtureChannel',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'coarse', '3': 2, '4': 1, '5': 11, '6': '.mizer.FixtureChannel.CoarseResolution', '9': 0, '10': 'coarse'},
    const {'1': 'fine', '3': 3, '4': 1, '5': 11, '6': '.mizer.FixtureChannel.FineResolution', '9': 0, '10': 'fine'},
    const {'1': 'finest', '3': 4, '4': 1, '5': 11, '6': '.mizer.FixtureChannel.FinestResolution', '9': 0, '10': 'finest'},
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

