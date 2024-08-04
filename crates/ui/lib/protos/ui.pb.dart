//
//  Generated code. Do not modify.
//  source: ui.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ShowDialog extends $pb.GeneratedMessage {
  factory ShowDialog({
    $core.String? title,
    $core.Iterable<DialogElement>? elements,
  }) {
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (elements != null) {
      $result.elements.addAll(elements);
    }
    return $result;
  }
  ShowDialog._() : super();
  factory ShowDialog.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ShowDialog.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ShowDialog', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..pc<DialogElement>(2, _omitFieldNames ? '' : 'elements', $pb.PbFieldType.PM, subBuilder: DialogElement.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ShowDialog clone() => ShowDialog()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ShowDialog copyWith(void Function(ShowDialog) updates) => super.copyWith((message) => updates(message as ShowDialog)) as ShowDialog;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShowDialog create() => ShowDialog._();
  ShowDialog createEmptyInstance() => create();
  static $pb.PbList<ShowDialog> createRepeated() => $pb.PbList<ShowDialog>();
  @$core.pragma('dart2js:noInline')
  static ShowDialog getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShowDialog>(create);
  static ShowDialog? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<DialogElement> get elements => $_getList(1);
}

enum DialogElement_Element {
  text, 
  notSet
}

class DialogElement extends $pb.GeneratedMessage {
  factory DialogElement({
    $core.String? text,
  }) {
    final $result = create();
    if (text != null) {
      $result.text = text;
    }
    return $result;
  }
  DialogElement._() : super();
  factory DialogElement.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DialogElement.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, DialogElement_Element> _DialogElement_ElementByTag = {
    1 : DialogElement_Element.text,
    0 : DialogElement_Element.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DialogElement', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DialogElement clone() => DialogElement()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DialogElement copyWith(void Function(DialogElement) updates) => super.copyWith((message) => updates(message as DialogElement)) as DialogElement;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DialogElement create() => DialogElement._();
  DialogElement createEmptyInstance() => create();
  static $pb.PbList<DialogElement> createRepeated() => $pb.PbList<DialogElement>();
  @$core.pragma('dart2js:noInline')
  static DialogElement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DialogElement>(create);
  static DialogElement? _defaultInstance;

  DialogElement_Element whichElement() => _DialogElement_ElementByTag[$_whichOneof(0)]!;
  void clearElement() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);
}

class TabularData extends $pb.GeneratedMessage {
  factory TabularData({
    $core.Iterable<$core.String>? columns,
    $core.Iterable<Row>? rows,
  }) {
    final $result = create();
    if (columns != null) {
      $result.columns.addAll(columns);
    }
    if (rows != null) {
      $result.rows.addAll(rows);
    }
    return $result;
  }
  TabularData._() : super();
  factory TabularData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TabularData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TabularData', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'columns')
    ..pc<Row>(2, _omitFieldNames ? '' : 'rows', $pb.PbFieldType.PM, subBuilder: Row.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TabularData clone() => TabularData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TabularData copyWith(void Function(TabularData) updates) => super.copyWith((message) => updates(message as TabularData)) as TabularData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TabularData create() => TabularData._();
  TabularData createEmptyInstance() => create();
  static $pb.PbList<TabularData> createRepeated() => $pb.PbList<TabularData>();
  @$core.pragma('dart2js:noInline')
  static TabularData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TabularData>(create);
  static TabularData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get columns => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Row> get rows => $_getList(1);
}

class Row extends $pb.GeneratedMessage {
  factory Row({
    $core.String? id,
    $core.Iterable<$core.String>? cells,
    $core.Iterable<Row>? children,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (cells != null) {
      $result.cells.addAll(cells);
    }
    if (children != null) {
      $result.children.addAll(children);
    }
    return $result;
  }
  Row._() : super();
  factory Row.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Row.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Row', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..pPS(2, _omitFieldNames ? '' : 'cells')
    ..pc<Row>(3, _omitFieldNames ? '' : 'children', $pb.PbFieldType.PM, subBuilder: Row.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Row clone() => Row()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Row copyWith(void Function(Row) updates) => super.copyWith((message) => updates(message as Row)) as Row;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Row create() => Row._();
  Row createEmptyInstance() => create();
  static $pb.PbList<Row> createRepeated() => $pb.PbList<Row>();
  @$core.pragma('dart2js:noInline')
  static Row getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Row>(create);
  static Row? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get cells => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<Row> get children => $_getList(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
