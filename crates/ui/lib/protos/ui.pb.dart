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

import 'ui.pbenum.dart';

export 'ui.pbenum.dart';

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

class View extends $pb.GeneratedMessage {
  factory View({
    $core.String? title,
    $core.String? icon,
    ViewChild? child,
  }) {
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (icon != null) {
      $result.icon = icon;
    }
    if (child != null) {
      $result.child = child;
    }
    return $result;
  }
  View._() : super();
  factory View.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory View.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'View', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'icon')
    ..aOM<ViewChild>(3, _omitFieldNames ? '' : 'child', subBuilder: ViewChild.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  View clone() => View()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  View copyWith(void Function(View) updates) => super.copyWith((message) => updates(message as View)) as View;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static View create() => View._();
  View createEmptyInstance() => create();
  static $pb.PbList<View> createRepeated() => $pb.PbList<View>();
  @$core.pragma('dart2js:noInline')
  static View getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<View>(create);
  static View? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get icon => $_getSZ(1);
  @$pb.TagNumber(2)
  set icon($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIcon() => $_has(1);
  @$pb.TagNumber(2)
  void clearIcon() => clearField(2);

  @$pb.TagNumber(3)
  ViewChild get child => $_getN(2);
  @$pb.TagNumber(3)
  set child(ViewChild v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasChild() => $_has(2);
  @$pb.TagNumber(3)
  void clearChild() => clearField(3);
  @$pb.TagNumber(3)
  ViewChild ensureChild() => $_ensure(2);
}

enum ViewChild_Child {
  group, 
  panel, 
  notSet
}

class ViewChild extends $pb.GeneratedMessage {
  factory ViewChild({
    PanelGroup? group,
    Panel? panel,
    Size? width,
    Size? height,
  }) {
    final $result = create();
    if (group != null) {
      $result.group = group;
    }
    if (panel != null) {
      $result.panel = panel;
    }
    if (width != null) {
      $result.width = width;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  ViewChild._() : super();
  factory ViewChild.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ViewChild.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ViewChild_Child> _ViewChild_ChildByTag = {
    1 : ViewChild_Child.group,
    2 : ViewChild_Child.panel,
    0 : ViewChild_Child.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ViewChild', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<PanelGroup>(1, _omitFieldNames ? '' : 'group', subBuilder: PanelGroup.create)
    ..aOM<Panel>(2, _omitFieldNames ? '' : 'panel', subBuilder: Panel.create)
    ..aOM<Size>(3, _omitFieldNames ? '' : 'width', subBuilder: Size.create)
    ..aOM<Size>(4, _omitFieldNames ? '' : 'height', subBuilder: Size.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ViewChild clone() => ViewChild()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ViewChild copyWith(void Function(ViewChild) updates) => super.copyWith((message) => updates(message as ViewChild)) as ViewChild;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ViewChild create() => ViewChild._();
  ViewChild createEmptyInstance() => create();
  static $pb.PbList<ViewChild> createRepeated() => $pb.PbList<ViewChild>();
  @$core.pragma('dart2js:noInline')
  static ViewChild getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ViewChild>(create);
  static ViewChild? _defaultInstance;

  ViewChild_Child whichChild() => _ViewChild_ChildByTag[$_whichOneof(0)]!;
  void clearChild() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  PanelGroup get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(PanelGroup v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => clearField(1);
  @$pb.TagNumber(1)
  PanelGroup ensureGroup() => $_ensure(0);

  @$pb.TagNumber(2)
  Panel get panel => $_getN(1);
  @$pb.TagNumber(2)
  set panel(Panel v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPanel() => $_has(1);
  @$pb.TagNumber(2)
  void clearPanel() => clearField(2);
  @$pb.TagNumber(2)
  Panel ensurePanel() => $_ensure(1);

  @$pb.TagNumber(3)
  Size get width => $_getN(2);
  @$pb.TagNumber(3)
  set width(Size v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);
  @$pb.TagNumber(3)
  Size ensureWidth() => $_ensure(2);

  @$pb.TagNumber(4)
  Size get height => $_getN(3);
  @$pb.TagNumber(4)
  set height(Size v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => clearField(4);
  @$pb.TagNumber(4)
  Size ensureHeight() => $_ensure(3);
}

class PanelGroup extends $pb.GeneratedMessage {
  factory PanelGroup({
    PanelGroup_Direction? direction,
    $core.Iterable<ViewChild>? children,
  }) {
    final $result = create();
    if (direction != null) {
      $result.direction = direction;
    }
    if (children != null) {
      $result.children.addAll(children);
    }
    return $result;
  }
  PanelGroup._() : super();
  factory PanelGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PanelGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PanelGroup', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..e<PanelGroup_Direction>(1, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: PanelGroup_Direction.DIRECTION_HORIZONTAL, valueOf: PanelGroup_Direction.valueOf, enumValues: PanelGroup_Direction.values)
    ..pc<ViewChild>(2, _omitFieldNames ? '' : 'children', $pb.PbFieldType.PM, subBuilder: ViewChild.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PanelGroup clone() => PanelGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PanelGroup copyWith(void Function(PanelGroup) updates) => super.copyWith((message) => updates(message as PanelGroup)) as PanelGroup;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PanelGroup create() => PanelGroup._();
  PanelGroup createEmptyInstance() => create();
  static $pb.PbList<PanelGroup> createRepeated() => $pb.PbList<PanelGroup>();
  @$core.pragma('dart2js:noInline')
  static PanelGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PanelGroup>(create);
  static PanelGroup? _defaultInstance;

  @$pb.TagNumber(1)
  PanelGroup_Direction get direction => $_getN(0);
  @$pb.TagNumber(1)
  set direction(PanelGroup_Direction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDirection() => $_has(0);
  @$pb.TagNumber(1)
  void clearDirection() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<ViewChild> get children => $_getList(1);
}

enum Size_Size {
  fill, 
  flex, 
  gridItems, 
  pixels, 
  notSet
}

class Size extends $pb.GeneratedMessage {
  factory Size({
    Fill? fill,
    Flex? flex,
    GridItems? gridItems,
    Pixels? pixels,
  }) {
    final $result = create();
    if (fill != null) {
      $result.fill = fill;
    }
    if (flex != null) {
      $result.flex = flex;
    }
    if (gridItems != null) {
      $result.gridItems = gridItems;
    }
    if (pixels != null) {
      $result.pixels = pixels;
    }
    return $result;
  }
  Size._() : super();
  factory Size.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Size.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Size_Size> _Size_SizeByTag = {
    1 : Size_Size.fill,
    2 : Size_Size.flex,
    3 : Size_Size.gridItems,
    4 : Size_Size.pixels,
    0 : Size_Size.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Size', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<Fill>(1, _omitFieldNames ? '' : 'fill', subBuilder: Fill.create)
    ..aOM<Flex>(2, _omitFieldNames ? '' : 'flex', subBuilder: Flex.create)
    ..aOM<GridItems>(3, _omitFieldNames ? '' : 'gridItems', protoName: 'gridItems', subBuilder: GridItems.create)
    ..aOM<Pixels>(4, _omitFieldNames ? '' : 'pixels', subBuilder: Pixels.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Size clone() => Size()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Size copyWith(void Function(Size) updates) => super.copyWith((message) => updates(message as Size)) as Size;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Size create() => Size._();
  Size createEmptyInstance() => create();
  static $pb.PbList<Size> createRepeated() => $pb.PbList<Size>();
  @$core.pragma('dart2js:noInline')
  static Size getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Size>(create);
  static Size? _defaultInstance;

  Size_Size whichSize() => _Size_SizeByTag[$_whichOneof(0)]!;
  void clearSize() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Fill get fill => $_getN(0);
  @$pb.TagNumber(1)
  set fill(Fill v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFill() => $_has(0);
  @$pb.TagNumber(1)
  void clearFill() => clearField(1);
  @$pb.TagNumber(1)
  Fill ensureFill() => $_ensure(0);

  @$pb.TagNumber(2)
  Flex get flex => $_getN(1);
  @$pb.TagNumber(2)
  set flex(Flex v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFlex() => $_has(1);
  @$pb.TagNumber(2)
  void clearFlex() => clearField(2);
  @$pb.TagNumber(2)
  Flex ensureFlex() => $_ensure(1);

  @$pb.TagNumber(3)
  GridItems get gridItems => $_getN(2);
  @$pb.TagNumber(3)
  set gridItems(GridItems v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGridItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearGridItems() => clearField(3);
  @$pb.TagNumber(3)
  GridItems ensureGridItems() => $_ensure(2);

  @$pb.TagNumber(4)
  Pixels get pixels => $_getN(3);
  @$pb.TagNumber(4)
  set pixels(Pixels v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPixels() => $_has(3);
  @$pb.TagNumber(4)
  void clearPixels() => clearField(4);
  @$pb.TagNumber(4)
  Pixels ensurePixels() => $_ensure(3);
}

class Fill extends $pb.GeneratedMessage {
  factory Fill() => create();
  Fill._() : super();
  factory Fill.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Fill.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Fill', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Fill clone() => Fill()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Fill copyWith(void Function(Fill) updates) => super.copyWith((message) => updates(message as Fill)) as Fill;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Fill create() => Fill._();
  Fill createEmptyInstance() => create();
  static $pb.PbList<Fill> createRepeated() => $pb.PbList<Fill>();
  @$core.pragma('dart2js:noInline')
  static Fill getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Fill>(create);
  static Fill? _defaultInstance;
}

class Flex extends $pb.GeneratedMessage {
  factory Flex({
    $core.int? flex,
  }) {
    final $result = create();
    if (flex != null) {
      $result.flex = flex;
    }
    return $result;
  }
  Flex._() : super();
  factory Flex.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Flex.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Flex', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'flex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Flex clone() => Flex()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Flex copyWith(void Function(Flex) updates) => super.copyWith((message) => updates(message as Flex)) as Flex;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Flex create() => Flex._();
  Flex createEmptyInstance() => create();
  static $pb.PbList<Flex> createRepeated() => $pb.PbList<Flex>();
  @$core.pragma('dart2js:noInline')
  static Flex getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Flex>(create);
  static Flex? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get flex => $_getIZ(0);
  @$pb.TagNumber(1)
  set flex($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFlex() => $_has(0);
  @$pb.TagNumber(1)
  void clearFlex() => clearField(1);
}

class GridItems extends $pb.GeneratedMessage {
  factory GridItems({
    $core.double? count,
  }) {
    final $result = create();
    if (count != null) {
      $result.count = count;
    }
    return $result;
  }
  GridItems._() : super();
  factory GridItems.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GridItems.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GridItems', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'count', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GridItems clone() => GridItems()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GridItems copyWith(void Function(GridItems) updates) => super.copyWith((message) => updates(message as GridItems)) as GridItems;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GridItems create() => GridItems._();
  GridItems createEmptyInstance() => create();
  static $pb.PbList<GridItems> createRepeated() => $pb.PbList<GridItems>();
  @$core.pragma('dart2js:noInline')
  static GridItems getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GridItems>(create);
  static GridItems? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get count => $_getN(0);
  @$pb.TagNumber(1)
  set count($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => clearField(1);
}

class Pixels extends $pb.GeneratedMessage {
  factory Pixels({
    $core.int? pixels,
  }) {
    final $result = create();
    if (pixels != null) {
      $result.pixels = pixels;
    }
    return $result;
  }
  Pixels._() : super();
  factory Pixels.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pixels.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Pixels', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pixels', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Pixels clone() => Pixels()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Pixels copyWith(void Function(Pixels) updates) => super.copyWith((message) => updates(message as Pixels)) as Pixels;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Pixels create() => Pixels._();
  Pixels createEmptyInstance() => create();
  static $pb.PbList<Pixels> createRepeated() => $pb.PbList<Pixels>();
  @$core.pragma('dart2js:noInline')
  static Pixels getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pixels>(create);
  static Pixels? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pixels => $_getIZ(0);
  @$pb.TagNumber(1)
  set pixels($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPixels() => $_has(0);
  @$pb.TagNumber(1)
  void clearPixels() => clearField(1);
}

class Panel extends $pb.GeneratedMessage {
  factory Panel({
    $core.String? panelType,
  }) {
    final $result = create();
    if (panelType != null) {
      $result.panelType = panelType;
    }
    return $result;
  }
  Panel._() : super();
  factory Panel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Panel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Panel', package: const $pb.PackageName(_omitMessageNames ? '' : 'mizer.ui'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'panelType', protoName: 'panelType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Panel clone() => Panel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Panel copyWith(void Function(Panel) updates) => super.copyWith((message) => updates(message as Panel)) as Panel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Panel create() => Panel._();
  Panel createEmptyInstance() => create();
  static $pb.PbList<Panel> createRepeated() => $pb.PbList<Panel>();
  @$core.pragma('dart2js:noInline')
  static Panel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Panel>(create);
  static Panel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get panelType => $_getSZ(0);
  @$pb.TagNumber(1)
  set panelType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPanelType() => $_has(0);
  @$pb.TagNumber(1)
  void clearPanelType() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
