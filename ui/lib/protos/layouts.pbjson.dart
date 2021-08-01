///
//  Generated code. Do not modify.
//  source: layouts.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const LayoutResponse$json = const {
  '1': 'LayoutResponse',
};

const GetLayoutsRequest$json = const {
  '1': 'GetLayoutsRequest',
};

const AddLayoutRequest$json = const {
  '1': 'AddLayoutRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

const RemoveLayoutRequest$json = const {
  '1': 'RemoveLayoutRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

const RenameLayoutRequest$json = const {
  '1': 'RenameLayoutRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

const RenameControlRequest$json = const {
  '1': 'RenameControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
  ],
};

const MoveControlRequest$json = const {
  '1': 'MoveControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.ControlPosition', '10': 'position'},
  ],
};

const RemoveControlRequest$json = const {
  '1': 'RemoveControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
  ],
};

const AddControlRequest$json = const {
  '1': 'AddControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'node_type', '3': 2, '4': 1, '5': 14, '6': '.mizer.Node.NodeType', '10': 'nodeType'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.ControlPosition', '10': 'position'},
  ],
};

const AddExistingControlRequest$json = const {
  '1': 'AddExistingControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'node', '3': 2, '4': 1, '5': 9, '10': 'node'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.ControlPosition', '10': 'position'},
  ],
};

const Layouts$json = const {
  '1': 'Layouts',
  '2': const [
    const {'1': 'layouts', '3': 1, '4': 3, '5': 11, '6': '.mizer.Layout', '10': 'layouts'},
  ],
};

const Layout$json = const {
  '1': 'Layout',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'controls', '3': 2, '4': 3, '5': 11, '6': '.mizer.LayoutControl', '10': 'controls'},
  ],
};

const LayoutControl$json = const {
  '1': 'LayoutControl',
  '2': const [
    const {'1': 'node', '3': 1, '4': 1, '5': 9, '10': 'node'},
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.ControlPosition', '10': 'position'},
    const {'1': 'size', '3': 3, '4': 1, '5': 11, '6': '.mizer.ControlSize', '10': 'size'},
    const {'1': 'label', '3': 4, '4': 1, '5': 9, '10': 'label'},
  ],
};

const ControlPosition$json = const {
  '1': 'ControlPosition',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 4, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 4, '10': 'y'},
  ],
};

const ControlSize$json = const {
  '1': 'ControlSize',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 4, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
  ],
};

