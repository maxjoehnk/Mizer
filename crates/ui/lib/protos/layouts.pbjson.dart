///
//  Generated code. Do not modify.
//  source: layouts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use controlTypeDescriptor instead')
const ControlType$json = const {
  '1': 'ControlType',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'BUTTON', '2': 1},
    const {'1': 'FADER', '2': 2},
    const {'1': 'DIAL', '2': 3},
    const {'1': 'LABEL', '2': 4},
    const {'1': 'TIMECODE', '2': 5},
  ],
};

/// Descriptor for `ControlType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List controlTypeDescriptor = $convert.base64Decode('CgtDb250cm9sVHlwZRIICgROT05FEAASCgoGQlVUVE9OEAESCQoFRkFERVIQAhIICgRESUFMEAMSCQoFTEFCRUwQBBIMCghUSU1FQ09ERRAF');
@$core.Deprecated('Use addLayoutRequestDescriptor instead')
const AddLayoutRequest$json = const {
  '1': 'AddLayoutRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `AddLayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addLayoutRequestDescriptor = $convert.base64Decode('ChBBZGRMYXlvdXRSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');
@$core.Deprecated('Use removeLayoutRequestDescriptor instead')
const RemoveLayoutRequest$json = const {
  '1': 'RemoveLayoutRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `RemoveLayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeLayoutRequestDescriptor = $convert.base64Decode('ChNSZW1vdmVMYXlvdXRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use renameLayoutRequestDescriptor instead')
const RenameLayoutRequest$json = const {
  '1': 'RenameLayoutRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RenameLayoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameLayoutRequestDescriptor = $convert.base64Decode('ChNSZW5hbWVMYXlvdXRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use renameControlRequestDescriptor instead')
const RenameControlRequest$json = const {
  '1': 'RenameControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RenameControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List renameControlRequestDescriptor = $convert.base64Decode('ChRSZW5hbWVDb250cm9sUmVxdWVzdBIbCglsYXlvdXRfaWQYASABKAlSCGxheW91dElkEh0KCmNvbnRyb2xfaWQYAiABKAlSCWNvbnRyb2xJZBISCgRuYW1lGAMgASgJUgRuYW1l');
@$core.Deprecated('Use moveControlRequestDescriptor instead')
const MoveControlRequest$json = const {
  '1': 'MoveControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlPosition', '10': 'position'},
  ],
};

/// Descriptor for `MoveControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveControlRequestDescriptor = $convert.base64Decode('ChJNb3ZlQ29udHJvbFJlcXVlc3QSGwoJbGF5b3V0X2lkGAEgASgJUghsYXlvdXRJZBIdCgpjb250cm9sX2lkGAIgASgJUgljb250cm9sSWQSOgoIcG9zaXRpb24YAyABKAsyHi5taXplci5sYXlvdXRzLkNvbnRyb2xQb3NpdGlvblIIcG9zaXRpb24=');
@$core.Deprecated('Use resizeControlRequestDescriptor instead')
const ResizeControlRequest$json = const {
  '1': 'ResizeControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
    const {'1': 'size', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlSize', '10': 'size'},
  ],
};

/// Descriptor for `ResizeControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resizeControlRequestDescriptor = $convert.base64Decode('ChRSZXNpemVDb250cm9sUmVxdWVzdBIbCglsYXlvdXRfaWQYASABKAlSCGxheW91dElkEh0KCmNvbnRyb2xfaWQYAiABKAlSCWNvbnRyb2xJZBIuCgRzaXplGAMgASgLMhoubWl6ZXIubGF5b3V0cy5Db250cm9sU2l6ZVIEc2l6ZQ==');
@$core.Deprecated('Use updateControlDecorationRequestDescriptor instead')
const UpdateControlDecorationRequest$json = const {
  '1': 'UpdateControlDecorationRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
    const {'1': 'decorations', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlDecorations', '10': 'decorations'},
  ],
};

/// Descriptor for `UpdateControlDecorationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateControlDecorationRequestDescriptor = $convert.base64Decode('Ch5VcGRhdGVDb250cm9sRGVjb3JhdGlvblJlcXVlc3QSGwoJbGF5b3V0X2lkGAEgASgJUghsYXlvdXRJZBIdCgpjb250cm9sX2lkGAIgASgJUgljb250cm9sSWQSQwoLZGVjb3JhdGlvbnMYAyABKAsyIS5taXplci5sYXlvdXRzLkNvbnRyb2xEZWNvcmF0aW9uc1ILZGVjb3JhdGlvbnM=');
@$core.Deprecated('Use updateControlBehaviorRequestDescriptor instead')
const UpdateControlBehaviorRequest$json = const {
  '1': 'UpdateControlBehaviorRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
    const {'1': 'behavior', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlBehavior', '10': 'behavior'},
  ],
};

/// Descriptor for `UpdateControlBehaviorRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateControlBehaviorRequestDescriptor = $convert.base64Decode('ChxVcGRhdGVDb250cm9sQmVoYXZpb3JSZXF1ZXN0EhsKCWxheW91dF9pZBgBIAEoCVIIbGF5b3V0SWQSHQoKY29udHJvbF9pZBgCIAEoCVIJY29udHJvbElkEjoKCGJlaGF2aW9yGAMgASgLMh4ubWl6ZXIubGF5b3V0cy5Db250cm9sQmVoYXZpb3JSCGJlaGF2aW9y');
@$core.Deprecated('Use removeControlRequestDescriptor instead')
const RemoveControlRequest$json = const {
  '1': 'RemoveControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_id', '3': 2, '4': 1, '5': 9, '10': 'controlId'},
  ],
};

/// Descriptor for `RemoveControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeControlRequestDescriptor = $convert.base64Decode('ChRSZW1vdmVDb250cm9sUmVxdWVzdBIbCglsYXlvdXRfaWQYASABKAlSCGxheW91dElkEh0KCmNvbnRyb2xfaWQYAiABKAlSCWNvbnRyb2xJZA==');
@$core.Deprecated('Use addControlRequestDescriptor instead')
const AddControlRequest$json = const {
  '1': 'AddControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'control_type', '3': 2, '4': 1, '5': 14, '6': '.mizer.layouts.ControlType', '10': 'controlType'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlPosition', '10': 'position'},
  ],
};

/// Descriptor for `AddControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addControlRequestDescriptor = $convert.base64Decode('ChFBZGRDb250cm9sUmVxdWVzdBIbCglsYXlvdXRfaWQYASABKAlSCGxheW91dElkEj0KDGNvbnRyb2xfdHlwZRgCIAEoDjIaLm1pemVyLmxheW91dHMuQ29udHJvbFR5cGVSC2NvbnRyb2xUeXBlEjoKCHBvc2l0aW9uGAMgASgLMh4ubWl6ZXIubGF5b3V0cy5Db250cm9sUG9zaXRpb25SCHBvc2l0aW9u');
@$core.Deprecated('Use addExistingControlRequestDescriptor instead')
const AddExistingControlRequest$json = const {
  '1': 'AddExistingControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'node', '3': 2, '4': 1, '5': 9, '10': 'node'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlPosition', '10': 'position'},
  ],
};

/// Descriptor for `AddExistingControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addExistingControlRequestDescriptor = $convert.base64Decode('ChlBZGRFeGlzdGluZ0NvbnRyb2xSZXF1ZXN0EhsKCWxheW91dF9pZBgBIAEoCVIIbGF5b3V0SWQSEgoEbm9kZRgCIAEoCVIEbm9kZRI6Cghwb3NpdGlvbhgDIAEoCzIeLm1pemVyLmxheW91dHMuQ29udHJvbFBvc2l0aW9uUghwb3NpdGlvbg==');
@$core.Deprecated('Use addSequenceControlRequestDescriptor instead')
const AddSequenceControlRequest$json = const {
  '1': 'AddSequenceControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'sequence_id', '3': 2, '4': 1, '5': 13, '10': 'sequenceId'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlPosition', '10': 'position'},
  ],
};

/// Descriptor for `AddSequenceControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addSequenceControlRequestDescriptor = $convert.base64Decode('ChlBZGRTZXF1ZW5jZUNvbnRyb2xSZXF1ZXN0EhsKCWxheW91dF9pZBgBIAEoCVIIbGF5b3V0SWQSHwoLc2VxdWVuY2VfaWQYAiABKA1SCnNlcXVlbmNlSWQSOgoIcG9zaXRpb24YAyABKAsyHi5taXplci5sYXlvdXRzLkNvbnRyb2xQb3NpdGlvblIIcG9zaXRpb24=');
@$core.Deprecated('Use addGroupControlRequestDescriptor instead')
const AddGroupControlRequest$json = const {
  '1': 'AddGroupControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 13, '10': 'groupId'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlPosition', '10': 'position'},
  ],
};

/// Descriptor for `AddGroupControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addGroupControlRequestDescriptor = $convert.base64Decode('ChZBZGRHcm91cENvbnRyb2xSZXF1ZXN0EhsKCWxheW91dF9pZBgBIAEoCVIIbGF5b3V0SWQSGQoIZ3JvdXBfaWQYAiABKA1SB2dyb3VwSWQSOgoIcG9zaXRpb24YAyABKAsyHi5taXplci5sYXlvdXRzLkNvbnRyb2xQb3NpdGlvblIIcG9zaXRpb24=');
@$core.Deprecated('Use addPresetControlRequestDescriptor instead')
const AddPresetControlRequest$json = const {
  '1': 'AddPresetControlRequest',
  '2': const [
    const {'1': 'layout_id', '3': 1, '4': 1, '5': 9, '10': 'layoutId'},
    const {'1': 'preset_id', '3': 2, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '10': 'presetId'},
    const {'1': 'position', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlPosition', '10': 'position'},
  ],
};

/// Descriptor for `AddPresetControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addPresetControlRequestDescriptor = $convert.base64Decode('ChdBZGRQcmVzZXRDb250cm9sUmVxdWVzdBIbCglsYXlvdXRfaWQYASABKAlSCGxheW91dElkEjcKCXByZXNldF9pZBgCIAEoCzIaLm1pemVyLnByb2dyYW1tZXIuUHJlc2V0SWRSCHByZXNldElkEjoKCHBvc2l0aW9uGAMgASgLMh4ubWl6ZXIubGF5b3V0cy5Db250cm9sUG9zaXRpb25SCHBvc2l0aW9u');
@$core.Deprecated('Use layoutsDescriptor instead')
const Layouts$json = const {
  '1': 'Layouts',
  '2': const [
    const {'1': 'layouts', '3': 1, '4': 3, '5': 11, '6': '.mizer.layouts.Layout', '10': 'layouts'},
  ],
};

/// Descriptor for `Layouts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List layoutsDescriptor = $convert.base64Decode('CgdMYXlvdXRzEi8KB2xheW91dHMYASADKAsyFS5taXplci5sYXlvdXRzLkxheW91dFIHbGF5b3V0cw==');
@$core.Deprecated('Use layoutDescriptor instead')
const Layout$json = const {
  '1': 'Layout',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'controls', '3': 2, '4': 3, '5': 11, '6': '.mizer.layouts.LayoutControl', '10': 'controls'},
  ],
};

/// Descriptor for `Layout`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List layoutDescriptor = $convert.base64Decode('CgZMYXlvdXQSDgoCaWQYASABKAlSAmlkEjgKCGNvbnRyb2xzGAIgAygLMhwubWl6ZXIubGF5b3V0cy5MYXlvdXRDb250cm9sUghjb250cm9scw==');
@$core.Deprecated('Use layoutControlDescriptor instead')
const LayoutControl$json = const {
  '1': 'LayoutControl',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.mizer.layouts.ControlPosition', '10': 'position'},
    const {'1': 'size', '3': 3, '4': 1, '5': 11, '6': '.mizer.layouts.ControlSize', '10': 'size'},
    const {'1': 'label', '3': 4, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'decoration', '3': 5, '4': 1, '5': 11, '6': '.mizer.layouts.ControlDecorations', '10': 'decoration'},
    const {'1': 'behavior', '3': 6, '4': 1, '5': 11, '6': '.mizer.layouts.ControlBehavior', '10': 'behavior'},
    const {'1': 'node', '3': 7, '4': 1, '5': 11, '6': '.mizer.layouts.LayoutControl.NodeControlType', '9': 0, '10': 'node'},
    const {'1': 'sequencer', '3': 8, '4': 1, '5': 11, '6': '.mizer.layouts.LayoutControl.SequencerControlType', '9': 0, '10': 'sequencer'},
    const {'1': 'group', '3': 9, '4': 1, '5': 11, '6': '.mizer.layouts.LayoutControl.GroupControlType', '9': 0, '10': 'group'},
    const {'1': 'preset', '3': 10, '4': 1, '5': 11, '6': '.mizer.layouts.LayoutControl.PresetControlType', '9': 0, '10': 'preset'},
  ],
  '3': const [LayoutControl_NodeControlType$json, LayoutControl_SequencerControlType$json, LayoutControl_GroupControlType$json, LayoutControl_PresetControlType$json],
  '8': const [
    const {'1': 'control_type'},
  ],
};

@$core.Deprecated('Use layoutControlDescriptor instead')
const LayoutControl_NodeControlType$json = const {
  '1': 'NodeControlType',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

@$core.Deprecated('Use layoutControlDescriptor instead')
const LayoutControl_SequencerControlType$json = const {
  '1': 'SequencerControlType',
  '2': const [
    const {'1': 'sequence_id', '3': 1, '4': 1, '5': 13, '10': 'sequenceId'},
  ],
};

@$core.Deprecated('Use layoutControlDescriptor instead')
const LayoutControl_GroupControlType$json = const {
  '1': 'GroupControlType',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 13, '10': 'groupId'},
  ],
};

@$core.Deprecated('Use layoutControlDescriptor instead')
const LayoutControl_PresetControlType$json = const {
  '1': 'PresetControlType',
  '2': const [
    const {'1': 'preset_id', '3': 1, '4': 1, '5': 11, '6': '.mizer.programmer.PresetId', '10': 'presetId'},
  ],
};

/// Descriptor for `LayoutControl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List layoutControlDescriptor = $convert.base64Decode('Cg1MYXlvdXRDb250cm9sEg4KAmlkGAEgASgJUgJpZBI6Cghwb3NpdGlvbhgCIAEoCzIeLm1pemVyLmxheW91dHMuQ29udHJvbFBvc2l0aW9uUghwb3NpdGlvbhIuCgRzaXplGAMgASgLMhoubWl6ZXIubGF5b3V0cy5Db250cm9sU2l6ZVIEc2l6ZRIUCgVsYWJlbBgEIAEoCVIFbGFiZWwSQQoKZGVjb3JhdGlvbhgFIAEoCzIhLm1pemVyLmxheW91dHMuQ29udHJvbERlY29yYXRpb25zUgpkZWNvcmF0aW9uEjoKCGJlaGF2aW9yGAYgASgLMh4ubWl6ZXIubGF5b3V0cy5Db250cm9sQmVoYXZpb3JSCGJlaGF2aW9yEkIKBG5vZGUYByABKAsyLC5taXplci5sYXlvdXRzLkxheW91dENvbnRyb2wuTm9kZUNvbnRyb2xUeXBlSABSBG5vZGUSUQoJc2VxdWVuY2VyGAggASgLMjEubWl6ZXIubGF5b3V0cy5MYXlvdXRDb250cm9sLlNlcXVlbmNlckNvbnRyb2xUeXBlSABSCXNlcXVlbmNlchJFCgVncm91cBgJIAEoCzItLm1pemVyLmxheW91dHMuTGF5b3V0Q29udHJvbC5Hcm91cENvbnRyb2xUeXBlSABSBWdyb3VwEkgKBnByZXNldBgKIAEoCzIuLm1pemVyLmxheW91dHMuTGF5b3V0Q29udHJvbC5QcmVzZXRDb250cm9sVHlwZUgAUgZwcmVzZXQaJQoPTm9kZUNvbnRyb2xUeXBlEhIKBHBhdGgYASABKAlSBHBhdGgaNwoUU2VxdWVuY2VyQ29udHJvbFR5cGUSHwoLc2VxdWVuY2VfaWQYASABKA1SCnNlcXVlbmNlSWQaLQoQR3JvdXBDb250cm9sVHlwZRIZCghncm91cF9pZBgBIAEoDVIHZ3JvdXBJZBpMChFQcmVzZXRDb250cm9sVHlwZRI3CglwcmVzZXRfaWQYASABKAsyGi5taXplci5wcm9ncmFtbWVyLlByZXNldElkUghwcmVzZXRJZEIOCgxjb250cm9sX3R5cGU=');
@$core.Deprecated('Use controlPositionDescriptor instead')
const ControlPosition$json = const {
  '1': 'ControlPosition',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 4, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 4, '10': 'y'},
  ],
};

/// Descriptor for `ControlPosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlPositionDescriptor = $convert.base64Decode('Cg9Db250cm9sUG9zaXRpb24SDAoBeBgBIAEoBFIBeBIMCgF5GAIgASgEUgF5');
@$core.Deprecated('Use controlSizeDescriptor instead')
const ControlSize$json = const {
  '1': 'ControlSize',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 4, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 4, '10': 'height'},
  ],
};

/// Descriptor for `ControlSize`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlSizeDescriptor = $convert.base64Decode('CgtDb250cm9sU2l6ZRIUCgV3aWR0aBgBIAEoBFIFd2lkdGgSFgoGaGVpZ2h0GAIgASgEUgZoZWlnaHQ=');
@$core.Deprecated('Use controlDecorationsDescriptor instead')
const ControlDecorations$json = const {
  '1': 'ControlDecorations',
  '2': const [
    const {'1': 'has_color', '3': 1, '4': 1, '5': 8, '10': 'hasColor'},
    const {'1': 'color', '3': 2, '4': 1, '5': 11, '6': '.mizer.layouts.Color', '10': 'color'},
    const {'1': 'has_image', '3': 3, '4': 1, '5': 8, '10': 'hasImage'},
    const {'1': 'image', '3': 4, '4': 1, '5': 12, '10': 'image'},
  ],
};

/// Descriptor for `ControlDecorations`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlDecorationsDescriptor = $convert.base64Decode('ChJDb250cm9sRGVjb3JhdGlvbnMSGwoJaGFzX2NvbG9yGAEgASgIUghoYXNDb2xvchIqCgVjb2xvchgCIAEoCzIULm1pemVyLmxheW91dHMuQ29sb3JSBWNvbG9yEhsKCWhhc19pbWFnZRgDIAEoCFIIaGFzSW1hZ2USFAoFaW1hZ2UYBCABKAxSBWltYWdl');
@$core.Deprecated('Use colorDescriptor instead')
const Color$json = const {
  '1': 'Color',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 1, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 1, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 1, '10': 'blue'},
  ],
};

/// Descriptor for `Color`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorDescriptor = $convert.base64Decode('CgVDb2xvchIQCgNyZWQYASABKAFSA3JlZBIUCgVncmVlbhgCIAEoAVIFZ3JlZW4SEgoEYmx1ZRgDIAEoAVIEYmx1ZQ==');
@$core.Deprecated('Use controlBehaviorDescriptor instead')
const ControlBehavior$json = const {
  '1': 'ControlBehavior',
  '2': const [
    const {'1': 'sequencer', '3': 1, '4': 1, '5': 11, '6': '.mizer.layouts.SequencerControlBehavior', '10': 'sequencer'},
  ],
};

/// Descriptor for `ControlBehavior`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlBehaviorDescriptor = $convert.base64Decode('Cg9Db250cm9sQmVoYXZpb3ISRQoJc2VxdWVuY2VyGAEgASgLMicubWl6ZXIubGF5b3V0cy5TZXF1ZW5jZXJDb250cm9sQmVoYXZpb3JSCXNlcXVlbmNlcg==');
@$core.Deprecated('Use sequencerControlBehaviorDescriptor instead')
const SequencerControlBehavior$json = const {
  '1': 'SequencerControlBehavior',
  '2': const [
    const {'1': 'click_behavior', '3': 1, '4': 1, '5': 14, '6': '.mizer.layouts.SequencerControlBehavior.ClickBehavior', '10': 'clickBehavior'},
  ],
  '4': const [SequencerControlBehavior_ClickBehavior$json],
};

@$core.Deprecated('Use sequencerControlBehaviorDescriptor instead')
const SequencerControlBehavior_ClickBehavior$json = const {
  '1': 'ClickBehavior',
  '2': const [
    const {'1': 'GO_FORWARD', '2': 0},
    const {'1': 'TOGGLE', '2': 1},
  ],
};

/// Descriptor for `SequencerControlBehavior`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequencerControlBehaviorDescriptor = $convert.base64Decode('ChhTZXF1ZW5jZXJDb250cm9sQmVoYXZpb3ISXAoOY2xpY2tfYmVoYXZpb3IYASABKA4yNS5taXplci5sYXlvdXRzLlNlcXVlbmNlckNvbnRyb2xCZWhhdmlvci5DbGlja0JlaGF2aW9yUg1jbGlja0JlaGF2aW9yIisKDUNsaWNrQmVoYXZpb3ISDgoKR09fRk9SV0FSRBAAEgoKBlRPR0dMRRAB');
@$core.Deprecated('Use readFaderValueRequestDescriptor instead')
const ReadFaderValueRequest$json = const {
  '1': 'ReadFaderValueRequest',
  '2': const [
    const {'1': 'node', '3': 1, '4': 1, '5': 9, '10': 'node'},
  ],
};

/// Descriptor for `ReadFaderValueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readFaderValueRequestDescriptor = $convert.base64Decode('ChVSZWFkRmFkZXJWYWx1ZVJlcXVlc3QSEgoEbm9kZRgBIAEoCVIEbm9kZQ==');
@$core.Deprecated('Use faderValueResponseDescriptor instead')
const FaderValueResponse$json = const {
  '1': 'FaderValueResponse',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `FaderValueResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List faderValueResponseDescriptor = $convert.base64Decode('ChJGYWRlclZhbHVlUmVzcG9uc2USFAoFdmFsdWUYASABKAFSBXZhbHVl');
