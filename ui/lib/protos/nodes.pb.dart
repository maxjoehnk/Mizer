///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'nodes.pbenum.dart';

export 'nodes.pbenum.dart';

class NodesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  NodesRequest._() : super();
  factory NodesRequest() => create();
  factory NodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodesRequest clone() => NodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodesRequest copyWith(void Function(NodesRequest) updates) => super.copyWith((message) => updates(message as NodesRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodesRequest create() => NodesRequest._();
  NodesRequest createEmptyInstance() => create();
  static $pb.PbList<NodesRequest> createRepeated() => $pb.PbList<NodesRequest>();
  @$core.pragma('dart2js:noInline')
  static NodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodesRequest>(create);
  static NodesRequest _defaultInstance;
}

class Nodes extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Nodes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<Node>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..pc<NodeConnection>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: NodeConnection.create)
    ..hasRequiredFields = false
  ;

  Nodes._() : super();
  factory Nodes({
    $core.Iterable<Node> nodes,
    $core.Iterable<NodeConnection> channels,
  }) {
    final _result = create();
    if (nodes != null) {
      _result.nodes.addAll(nodes);
    }
    if (channels != null) {
      _result.channels.addAll(channels);
    }
    return _result;
  }
  factory Nodes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Nodes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Nodes clone() => Nodes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Nodes copyWith(void Function(Nodes) updates) => super.copyWith((message) => updates(message as Nodes)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Nodes create() => Nodes._();
  Nodes createEmptyInstance() => create();
  static $pb.PbList<Nodes> createRepeated() => $pb.PbList<Nodes>();
  @$core.pragma('dart2js:noInline')
  static Nodes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Nodes>(create);
  static Nodes _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Node> get nodes => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<NodeConnection> get channels => $_getList(1);
}

class NodeConnection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeConnection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputNode', protoName: 'inputNode')
    ..aOM<Port>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputPort', protoName: 'inputPort', subBuilder: Port.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputNode', protoName: 'outputNode')
    ..aOM<Port>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputPort', protoName: 'outputPort', subBuilder: Port.create)
    ..e<ChannelProtocol>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: ChannelProtocol.Dmx, valueOf: ChannelProtocol.valueOf, enumValues: ChannelProtocol.values)
    ..hasRequiredFields = false
  ;

  NodeConnection._() : super();
  factory NodeConnection({
    $core.String inputNode,
    Port inputPort,
    $core.String outputNode,
    Port outputPort,
    ChannelProtocol protocol,
  }) {
    final _result = create();
    if (inputNode != null) {
      _result.inputNode = inputNode;
    }
    if (inputPort != null) {
      _result.inputPort = inputPort;
    }
    if (outputNode != null) {
      _result.outputNode = outputNode;
    }
    if (outputPort != null) {
      _result.outputPort = outputPort;
    }
    if (protocol != null) {
      _result.protocol = protocol;
    }
    return _result;
  }
  factory NodeConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeConnection clone() => NodeConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeConnection copyWith(void Function(NodeConnection) updates) => super.copyWith((message) => updates(message as NodeConnection)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodeConnection create() => NodeConnection._();
  NodeConnection createEmptyInstance() => create();
  static $pb.PbList<NodeConnection> createRepeated() => $pb.PbList<NodeConnection>();
  @$core.pragma('dart2js:noInline')
  static NodeConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeConnection>(create);
  static NodeConnection _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get inputNode => $_getSZ(0);
  @$pb.TagNumber(1)
  set inputNode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInputNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearInputNode() => clearField(1);

  @$pb.TagNumber(2)
  Port get inputPort => $_getN(1);
  @$pb.TagNumber(2)
  set inputPort(Port v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInputPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearInputPort() => clearField(2);
  @$pb.TagNumber(2)
  Port ensureInputPort() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get outputNode => $_getSZ(2);
  @$pb.TagNumber(3)
  set outputNode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutputNode() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutputNode() => clearField(3);

  @$pb.TagNumber(4)
  Port get outputPort => $_getN(3);
  @$pb.TagNumber(4)
  set outputPort(Port v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutputPort() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutputPort() => clearField(4);
  @$pb.TagNumber(4)
  Port ensureOutputPort() => $_ensure(3);

  @$pb.TagNumber(5)
  ChannelProtocol get protocol => $_getN(4);
  @$pb.TagNumber(5)
  set protocol(ChannelProtocol v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasProtocol() => $_has(4);
  @$pb.TagNumber(5)
  void clearProtocol() => clearField(5);
}

class Node extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Node', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..e<Node_NodeType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Node_NodeType.ArtnetOutput, valueOf: Node_NodeType.valueOf, enumValues: Node_NodeType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..pc<Port>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..pc<Port>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..m<$core.String, $core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'properties', entryClassName: 'Node.PropertiesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OD, packageName: const $pb.PackageName('mizer'))
    ..hasRequiredFields = false
  ;

  Node._() : super();
  factory Node({
    Node_NodeType type,
    $core.String id,
    $core.String title,
    $core.Iterable<Port> inputs,
    $core.Iterable<Port> outputs,
    $core.Map<$core.String, $core.double> properties,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (id != null) {
      _result.id = id;
    }
    if (title != null) {
      _result.title = title;
    }
    if (inputs != null) {
      _result.inputs.addAll(inputs);
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    if (properties != null) {
      _result.properties.addAll(properties);
    }
    return _result;
  }
  factory Node.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Node.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Node clone() => Node()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Node copyWith(void Function(Node) updates) => super.copyWith((message) => updates(message as Node)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Node create() => Node._();
  Node createEmptyInstance() => create();
  static $pb.PbList<Node> createRepeated() => $pb.PbList<Node>();
  @$core.pragma('dart2js:noInline')
  static Node getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Node>(create);
  static Node _defaultInstance;

  @$pb.TagNumber(1)
  Node_NodeType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Node_NodeType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Port> get inputs => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<Port> get outputs => $_getList(4);

  @$pb.TagNumber(7)
  $core.Map<$core.String, $core.double> get properties => $_getMap(5);
}

class Port extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Port', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<ChannelProtocol>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: ChannelProtocol.Dmx, valueOf: ChannelProtocol.valueOf, enumValues: ChannelProtocol.values)
    ..hasRequiredFields = false
  ;

  Port._() : super();
  factory Port({
    $core.String name,
    ChannelProtocol protocol,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (protocol != null) {
      _result.protocol = protocol;
    }
    return _result;
  }
  factory Port.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Port.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Port clone() => Port()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Port copyWith(void Function(Port) updates) => super.copyWith((message) => updates(message as Port)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Port create() => Port._();
  Port createEmptyInstance() => create();
  static $pb.PbList<Port> createRepeated() => $pb.PbList<Port>();
  @$core.pragma('dart2js:noInline')
  static Port getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Port>(create);
  static Port _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  ChannelProtocol get protocol => $_getN(1);
  @$pb.TagNumber(2)
  set protocol(ChannelProtocol v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProtocol() => $_has(1);
  @$pb.TagNumber(2)
  void clearProtocol() => clearField(2);
}

