///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'nodes.pbenum.dart';

export 'nodes.pbenum.dart';

class AddNodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddNodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..e<Node_NodeType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Node_NodeType.Fader, valueOf: Node_NodeType.valueOf, enumValues: Node_NodeType.values)
    ..aOM<NodePosition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: NodePosition.create)
    ..hasRequiredFields = false
  ;

  AddNodeRequest._() : super();
  factory AddNodeRequest({
    Node_NodeType type,
    NodePosition position,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (position != null) {
      _result.position = position;
    }
    return _result;
  }
  factory AddNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddNodeRequest clone() => AddNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddNodeRequest copyWith(void Function(AddNodeRequest) updates) => super.copyWith((message) => updates(message as AddNodeRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddNodeRequest create() => AddNodeRequest._();
  AddNodeRequest createEmptyInstance() => create();
  static $pb.PbList<AddNodeRequest> createRepeated() => $pb.PbList<AddNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static AddNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddNodeRequest>(create);
  static AddNodeRequest _defaultInstance;

  @$pb.TagNumber(1)
  Node_NodeType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Node_NodeType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  NodePosition get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(NodePosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  NodePosition ensurePosition() => $_ensure(1);
}

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

class WriteControl extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteControl', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  WriteControl._() : super();
  factory WriteControl({
    $core.String path,
    $core.String port,
    $core.double value,
  }) {
    final _result = create();
    if (path != null) {
      _result.path = path;
    }
    if (port != null) {
      _result.port = port;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory WriteControl.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteControl.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteControl clone() => WriteControl()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteControl copyWith(void Function(WriteControl) updates) => super.copyWith((message) => updates(message as WriteControl)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteControl create() => WriteControl._();
  WriteControl createEmptyInstance() => create();
  static $pb.PbList<WriteControl> createRepeated() => $pb.PbList<WriteControl>();
  @$core.pragma('dart2js:noInline')
  static WriteControl getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteControl>(create);
  static WriteControl _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get port => $_getSZ(1);
  @$pb.TagNumber(2)
  set port($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get value => $_getN(2);
  @$pb.TagNumber(3)
  set value($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => clearField(3);
}

class WriteResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WriteResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  WriteResponse._() : super();
  factory WriteResponse() => create();
  factory WriteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WriteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WriteResponse clone() => WriteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WriteResponse copyWith(void Function(WriteResponse) updates) => super.copyWith((message) => updates(message as WriteResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteResponse create() => WriteResponse._();
  WriteResponse createEmptyInstance() => create();
  static $pb.PbList<WriteResponse> createRepeated() => $pb.PbList<WriteResponse>();
  @$core.pragma('dart2js:noInline')
  static WriteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WriteResponse>(create);
  static WriteResponse _defaultInstance;
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
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetNode', protoName: 'targetNode')
    ..aOM<Port>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetPort', protoName: 'targetPort', subBuilder: Port.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceNode', protoName: 'sourceNode')
    ..aOM<Port>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourcePort', protoName: 'sourcePort', subBuilder: Port.create)
    ..e<ChannelProtocol>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: ChannelProtocol.Single, valueOf: ChannelProtocol.valueOf, enumValues: ChannelProtocol.values)
    ..hasRequiredFields = false
  ;

  NodeConnection._() : super();
  factory NodeConnection({
    $core.String targetNode,
    Port targetPort,
    $core.String sourceNode,
    Port sourcePort,
    ChannelProtocol protocol,
  }) {
    final _result = create();
    if (targetNode != null) {
      _result.targetNode = targetNode;
    }
    if (targetPort != null) {
      _result.targetPort = targetPort;
    }
    if (sourceNode != null) {
      _result.sourceNode = sourceNode;
    }
    if (sourcePort != null) {
      _result.sourcePort = sourcePort;
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
  $core.String get targetNode => $_getSZ(0);
  @$pb.TagNumber(1)
  set targetNode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetNode() => clearField(1);

  @$pb.TagNumber(2)
  Port get targetPort => $_getN(1);
  @$pb.TagNumber(2)
  set targetPort(Port v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetPort() => clearField(2);
  @$pb.TagNumber(2)
  Port ensureTargetPort() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get sourceNode => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceNode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSourceNode() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceNode() => clearField(3);

  @$pb.TagNumber(4)
  Port get sourcePort => $_getN(3);
  @$pb.TagNumber(4)
  set sourcePort(Port v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSourcePort() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourcePort() => clearField(4);
  @$pb.TagNumber(4)
  Port ensureSourcePort() => $_ensure(3);

  @$pb.TagNumber(5)
  ChannelProtocol get protocol => $_getN(4);
  @$pb.TagNumber(5)
  set protocol(ChannelProtocol v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasProtocol() => $_has(4);
  @$pb.TagNumber(5)
  void clearProtocol() => clearField(5);
}

enum Node_NodeConfig {
  oscillatorConfig, 
  scriptingConfig, 
  sequenceConfig, 
  clockConfig, 
  fixtureConfig, 
  buttonConfig, 
  faderConfig, 
  ildaFileConfig, 
  laserConfig, 
  pixelPatternConfig, 
  pixelDmxConfig, 
  dmxOutputConfig, 
  midiInputConfig, 
  midiOutputConfig, 
  opcOutputConfig, 
  oscInputConfig, 
  videoColorBalanceConfig, 
  videoEffectConfig, 
  videoFileConfig, 
  videoOutputConfig, 
  videoTransformConfig, 
  notSet
}

class Node extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Node_NodeConfig> _Node_NodeConfigByTag = {
    6 : Node_NodeConfig.oscillatorConfig,
    7 : Node_NodeConfig.scriptingConfig,
    8 : Node_NodeConfig.sequenceConfig,
    9 : Node_NodeConfig.clockConfig,
    10 : Node_NodeConfig.fixtureConfig,
    11 : Node_NodeConfig.buttonConfig,
    12 : Node_NodeConfig.faderConfig,
    15 : Node_NodeConfig.ildaFileConfig,
    16 : Node_NodeConfig.laserConfig,
    17 : Node_NodeConfig.pixelPatternConfig,
    18 : Node_NodeConfig.pixelDmxConfig,
    19 : Node_NodeConfig.dmxOutputConfig,
    20 : Node_NodeConfig.midiInputConfig,
    21 : Node_NodeConfig.midiOutputConfig,
    22 : Node_NodeConfig.opcOutputConfig,
    23 : Node_NodeConfig.oscInputConfig,
    25 : Node_NodeConfig.videoColorBalanceConfig,
    26 : Node_NodeConfig.videoEffectConfig,
    27 : Node_NodeConfig.videoFileConfig,
    28 : Node_NodeConfig.videoOutputConfig,
    29 : Node_NodeConfig.videoTransformConfig,
    0 : Node_NodeConfig.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Node', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..oo(0, [6, 7, 8, 9, 10, 11, 12, 15, 16, 17, 18, 19, 20, 21, 22, 23, 25, 26, 27, 28, 29])
    ..e<Node_NodeType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Node_NodeType.Fader, valueOf: Node_NodeType.valueOf, enumValues: Node_NodeType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..pc<Port>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..pc<Port>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputs', $pb.PbFieldType.PM, subBuilder: Port.create)
    ..aOM<NodeDesigner>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'designer', subBuilder: NodeDesigner.create)
    ..aOM<OscillatorNodeConfig>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oscillatorConfig', protoName: 'oscillatorConfig', subBuilder: OscillatorNodeConfig.create)
    ..aOM<ScriptingNodeConfig>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scriptingConfig', protoName: 'scriptingConfig', subBuilder: ScriptingNodeConfig.create)
    ..aOM<SequenceNodeConfig>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceConfig', protoName: 'sequenceConfig', subBuilder: SequenceNodeConfig.create)
    ..aOM<ClockNodeConfig>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clockConfig', protoName: 'clockConfig', subBuilder: ClockNodeConfig.create)
    ..aOM<FixtureNodeConfig>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtureConfig', protoName: 'fixtureConfig', subBuilder: FixtureNodeConfig.create)
    ..aOM<InputNodeConfig>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buttonConfig', protoName: 'buttonConfig', subBuilder: InputNodeConfig.create)
    ..aOM<InputNodeConfig>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'faderConfig', protoName: 'faderConfig', subBuilder: InputNodeConfig.create)
    ..aOM<IldaFileNodeConfig>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ildaFileConfig', protoName: 'ildaFileConfig', subBuilder: IldaFileNodeConfig.create)
    ..aOM<LaserNodeConfig>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'laserConfig', protoName: 'laserConfig', subBuilder: LaserNodeConfig.create)
    ..aOM<PixelPatternNodeConfig>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pixelPatternConfig', protoName: 'pixelPatternConfig', subBuilder: PixelPatternNodeConfig.create)
    ..aOM<PixelDmxNodeConfig>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pixelDmxConfig', protoName: 'pixelDmxConfig', subBuilder: PixelDmxNodeConfig.create)
    ..aOM<DmxOutputNodeConfig>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dmxOutputConfig', protoName: 'dmxOutputConfig', subBuilder: DmxOutputNodeConfig.create)
    ..aOM<MidiInputNodeConfig>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiInputConfig', protoName: 'midiInputConfig', subBuilder: MidiInputNodeConfig.create)
    ..aOM<MidiOutputNodeConfig>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiOutputConfig', protoName: 'midiOutputConfig', subBuilder: MidiOutputNodeConfig.create)
    ..aOM<OpcOutputNodeConfig>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'opcOutputConfig', protoName: 'opcOutputConfig', subBuilder: OpcOutputNodeConfig.create)
    ..aOM<OscInputNodeConfig>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oscInputConfig', protoName: 'oscInputConfig', subBuilder: OscInputNodeConfig.create)
    ..aOM<VideoColorBalanceNodeConfig>(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoColorBalanceConfig', protoName: 'videoColorBalanceConfig', subBuilder: VideoColorBalanceNodeConfig.create)
    ..aOM<VideoEffectNodeConfig>(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoEffectConfig', protoName: 'videoEffectConfig', subBuilder: VideoEffectNodeConfig.create)
    ..aOM<VideoFileNodeConfig>(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoFileConfig', protoName: 'videoFileConfig', subBuilder: VideoFileNodeConfig.create)
    ..aOM<VideoOutputNodeConfig>(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoOutputConfig', protoName: 'videoOutputConfig', subBuilder: VideoOutputNodeConfig.create)
    ..aOM<VideoTransformNodeConfig>(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoTransformConfig', protoName: 'videoTransformConfig', subBuilder: VideoTransformNodeConfig.create)
    ..hasRequiredFields = false
  ;

  Node._() : super();
  factory Node({
    Node_NodeType type,
    $core.String path,
    $core.Iterable<Port> inputs,
    $core.Iterable<Port> outputs,
    NodeDesigner designer,
    OscillatorNodeConfig oscillatorConfig,
    ScriptingNodeConfig scriptingConfig,
    SequenceNodeConfig sequenceConfig,
    ClockNodeConfig clockConfig,
    FixtureNodeConfig fixtureConfig,
    InputNodeConfig buttonConfig,
    InputNodeConfig faderConfig,
    IldaFileNodeConfig ildaFileConfig,
    LaserNodeConfig laserConfig,
    PixelPatternNodeConfig pixelPatternConfig,
    PixelDmxNodeConfig pixelDmxConfig,
    DmxOutputNodeConfig dmxOutputConfig,
    MidiInputNodeConfig midiInputConfig,
    MidiOutputNodeConfig midiOutputConfig,
    OpcOutputNodeConfig opcOutputConfig,
    OscInputNodeConfig oscInputConfig,
    VideoColorBalanceNodeConfig videoColorBalanceConfig,
    VideoEffectNodeConfig videoEffectConfig,
    VideoFileNodeConfig videoFileConfig,
    VideoOutputNodeConfig videoOutputConfig,
    VideoTransformNodeConfig videoTransformConfig,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (path != null) {
      _result.path = path;
    }
    if (inputs != null) {
      _result.inputs.addAll(inputs);
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    if (designer != null) {
      _result.designer = designer;
    }
    if (oscillatorConfig != null) {
      _result.oscillatorConfig = oscillatorConfig;
    }
    if (scriptingConfig != null) {
      _result.scriptingConfig = scriptingConfig;
    }
    if (sequenceConfig != null) {
      _result.sequenceConfig = sequenceConfig;
    }
    if (clockConfig != null) {
      _result.clockConfig = clockConfig;
    }
    if (fixtureConfig != null) {
      _result.fixtureConfig = fixtureConfig;
    }
    if (buttonConfig != null) {
      _result.buttonConfig = buttonConfig;
    }
    if (faderConfig != null) {
      _result.faderConfig = faderConfig;
    }
    if (ildaFileConfig != null) {
      _result.ildaFileConfig = ildaFileConfig;
    }
    if (laserConfig != null) {
      _result.laserConfig = laserConfig;
    }
    if (pixelPatternConfig != null) {
      _result.pixelPatternConfig = pixelPatternConfig;
    }
    if (pixelDmxConfig != null) {
      _result.pixelDmxConfig = pixelDmxConfig;
    }
    if (dmxOutputConfig != null) {
      _result.dmxOutputConfig = dmxOutputConfig;
    }
    if (midiInputConfig != null) {
      _result.midiInputConfig = midiInputConfig;
    }
    if (midiOutputConfig != null) {
      _result.midiOutputConfig = midiOutputConfig;
    }
    if (opcOutputConfig != null) {
      _result.opcOutputConfig = opcOutputConfig;
    }
    if (oscInputConfig != null) {
      _result.oscInputConfig = oscInputConfig;
    }
    if (videoColorBalanceConfig != null) {
      _result.videoColorBalanceConfig = videoColorBalanceConfig;
    }
    if (videoEffectConfig != null) {
      _result.videoEffectConfig = videoEffectConfig;
    }
    if (videoFileConfig != null) {
      _result.videoFileConfig = videoFileConfig;
    }
    if (videoOutputConfig != null) {
      _result.videoOutputConfig = videoOutputConfig;
    }
    if (videoTransformConfig != null) {
      _result.videoTransformConfig = videoTransformConfig;
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

  Node_NodeConfig whichNodeConfig() => _Node_NodeConfigByTag[$_whichOneof(0)];
  void clearNodeConfig() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Node_NodeType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Node_NodeType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Port> get inputs => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Port> get outputs => $_getList(3);

  @$pb.TagNumber(5)
  NodeDesigner get designer => $_getN(4);
  @$pb.TagNumber(5)
  set designer(NodeDesigner v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDesigner() => $_has(4);
  @$pb.TagNumber(5)
  void clearDesigner() => clearField(5);
  @$pb.TagNumber(5)
  NodeDesigner ensureDesigner() => $_ensure(4);

  @$pb.TagNumber(6)
  OscillatorNodeConfig get oscillatorConfig => $_getN(5);
  @$pb.TagNumber(6)
  set oscillatorConfig(OscillatorNodeConfig v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasOscillatorConfig() => $_has(5);
  @$pb.TagNumber(6)
  void clearOscillatorConfig() => clearField(6);
  @$pb.TagNumber(6)
  OscillatorNodeConfig ensureOscillatorConfig() => $_ensure(5);

  @$pb.TagNumber(7)
  ScriptingNodeConfig get scriptingConfig => $_getN(6);
  @$pb.TagNumber(7)
  set scriptingConfig(ScriptingNodeConfig v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasScriptingConfig() => $_has(6);
  @$pb.TagNumber(7)
  void clearScriptingConfig() => clearField(7);
  @$pb.TagNumber(7)
  ScriptingNodeConfig ensureScriptingConfig() => $_ensure(6);

  @$pb.TagNumber(8)
  SequenceNodeConfig get sequenceConfig => $_getN(7);
  @$pb.TagNumber(8)
  set sequenceConfig(SequenceNodeConfig v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasSequenceConfig() => $_has(7);
  @$pb.TagNumber(8)
  void clearSequenceConfig() => clearField(8);
  @$pb.TagNumber(8)
  SequenceNodeConfig ensureSequenceConfig() => $_ensure(7);

  @$pb.TagNumber(9)
  ClockNodeConfig get clockConfig => $_getN(8);
  @$pb.TagNumber(9)
  set clockConfig(ClockNodeConfig v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasClockConfig() => $_has(8);
  @$pb.TagNumber(9)
  void clearClockConfig() => clearField(9);
  @$pb.TagNumber(9)
  ClockNodeConfig ensureClockConfig() => $_ensure(8);

  @$pb.TagNumber(10)
  FixtureNodeConfig get fixtureConfig => $_getN(9);
  @$pb.TagNumber(10)
  set fixtureConfig(FixtureNodeConfig v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasFixtureConfig() => $_has(9);
  @$pb.TagNumber(10)
  void clearFixtureConfig() => clearField(10);
  @$pb.TagNumber(10)
  FixtureNodeConfig ensureFixtureConfig() => $_ensure(9);

  @$pb.TagNumber(11)
  InputNodeConfig get buttonConfig => $_getN(10);
  @$pb.TagNumber(11)
  set buttonConfig(InputNodeConfig v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasButtonConfig() => $_has(10);
  @$pb.TagNumber(11)
  void clearButtonConfig() => clearField(11);
  @$pb.TagNumber(11)
  InputNodeConfig ensureButtonConfig() => $_ensure(10);

  @$pb.TagNumber(12)
  InputNodeConfig get faderConfig => $_getN(11);
  @$pb.TagNumber(12)
  set faderConfig(InputNodeConfig v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasFaderConfig() => $_has(11);
  @$pb.TagNumber(12)
  void clearFaderConfig() => clearField(12);
  @$pb.TagNumber(12)
  InputNodeConfig ensureFaderConfig() => $_ensure(11);

  @$pb.TagNumber(15)
  IldaFileNodeConfig get ildaFileConfig => $_getN(12);
  @$pb.TagNumber(15)
  set ildaFileConfig(IldaFileNodeConfig v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasIldaFileConfig() => $_has(12);
  @$pb.TagNumber(15)
  void clearIldaFileConfig() => clearField(15);
  @$pb.TagNumber(15)
  IldaFileNodeConfig ensureIldaFileConfig() => $_ensure(12);

  @$pb.TagNumber(16)
  LaserNodeConfig get laserConfig => $_getN(13);
  @$pb.TagNumber(16)
  set laserConfig(LaserNodeConfig v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasLaserConfig() => $_has(13);
  @$pb.TagNumber(16)
  void clearLaserConfig() => clearField(16);
  @$pb.TagNumber(16)
  LaserNodeConfig ensureLaserConfig() => $_ensure(13);

  @$pb.TagNumber(17)
  PixelPatternNodeConfig get pixelPatternConfig => $_getN(14);
  @$pb.TagNumber(17)
  set pixelPatternConfig(PixelPatternNodeConfig v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasPixelPatternConfig() => $_has(14);
  @$pb.TagNumber(17)
  void clearPixelPatternConfig() => clearField(17);
  @$pb.TagNumber(17)
  PixelPatternNodeConfig ensurePixelPatternConfig() => $_ensure(14);

  @$pb.TagNumber(18)
  PixelDmxNodeConfig get pixelDmxConfig => $_getN(15);
  @$pb.TagNumber(18)
  set pixelDmxConfig(PixelDmxNodeConfig v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasPixelDmxConfig() => $_has(15);
  @$pb.TagNumber(18)
  void clearPixelDmxConfig() => clearField(18);
  @$pb.TagNumber(18)
  PixelDmxNodeConfig ensurePixelDmxConfig() => $_ensure(15);

  @$pb.TagNumber(19)
  DmxOutputNodeConfig get dmxOutputConfig => $_getN(16);
  @$pb.TagNumber(19)
  set dmxOutputConfig(DmxOutputNodeConfig v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasDmxOutputConfig() => $_has(16);
  @$pb.TagNumber(19)
  void clearDmxOutputConfig() => clearField(19);
  @$pb.TagNumber(19)
  DmxOutputNodeConfig ensureDmxOutputConfig() => $_ensure(16);

  @$pb.TagNumber(20)
  MidiInputNodeConfig get midiInputConfig => $_getN(17);
  @$pb.TagNumber(20)
  set midiInputConfig(MidiInputNodeConfig v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasMidiInputConfig() => $_has(17);
  @$pb.TagNumber(20)
  void clearMidiInputConfig() => clearField(20);
  @$pb.TagNumber(20)
  MidiInputNodeConfig ensureMidiInputConfig() => $_ensure(17);

  @$pb.TagNumber(21)
  MidiOutputNodeConfig get midiOutputConfig => $_getN(18);
  @$pb.TagNumber(21)
  set midiOutputConfig(MidiOutputNodeConfig v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasMidiOutputConfig() => $_has(18);
  @$pb.TagNumber(21)
  void clearMidiOutputConfig() => clearField(21);
  @$pb.TagNumber(21)
  MidiOutputNodeConfig ensureMidiOutputConfig() => $_ensure(18);

  @$pb.TagNumber(22)
  OpcOutputNodeConfig get opcOutputConfig => $_getN(19);
  @$pb.TagNumber(22)
  set opcOutputConfig(OpcOutputNodeConfig v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasOpcOutputConfig() => $_has(19);
  @$pb.TagNumber(22)
  void clearOpcOutputConfig() => clearField(22);
  @$pb.TagNumber(22)
  OpcOutputNodeConfig ensureOpcOutputConfig() => $_ensure(19);

  @$pb.TagNumber(23)
  OscInputNodeConfig get oscInputConfig => $_getN(20);
  @$pb.TagNumber(23)
  set oscInputConfig(OscInputNodeConfig v) { setField(23, v); }
  @$pb.TagNumber(23)
  $core.bool hasOscInputConfig() => $_has(20);
  @$pb.TagNumber(23)
  void clearOscInputConfig() => clearField(23);
  @$pb.TagNumber(23)
  OscInputNodeConfig ensureOscInputConfig() => $_ensure(20);

  @$pb.TagNumber(25)
  VideoColorBalanceNodeConfig get videoColorBalanceConfig => $_getN(21);
  @$pb.TagNumber(25)
  set videoColorBalanceConfig(VideoColorBalanceNodeConfig v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasVideoColorBalanceConfig() => $_has(21);
  @$pb.TagNumber(25)
  void clearVideoColorBalanceConfig() => clearField(25);
  @$pb.TagNumber(25)
  VideoColorBalanceNodeConfig ensureVideoColorBalanceConfig() => $_ensure(21);

  @$pb.TagNumber(26)
  VideoEffectNodeConfig get videoEffectConfig => $_getN(22);
  @$pb.TagNumber(26)
  set videoEffectConfig(VideoEffectNodeConfig v) { setField(26, v); }
  @$pb.TagNumber(26)
  $core.bool hasVideoEffectConfig() => $_has(22);
  @$pb.TagNumber(26)
  void clearVideoEffectConfig() => clearField(26);
  @$pb.TagNumber(26)
  VideoEffectNodeConfig ensureVideoEffectConfig() => $_ensure(22);

  @$pb.TagNumber(27)
  VideoFileNodeConfig get videoFileConfig => $_getN(23);
  @$pb.TagNumber(27)
  set videoFileConfig(VideoFileNodeConfig v) { setField(27, v); }
  @$pb.TagNumber(27)
  $core.bool hasVideoFileConfig() => $_has(23);
  @$pb.TagNumber(27)
  void clearVideoFileConfig() => clearField(27);
  @$pb.TagNumber(27)
  VideoFileNodeConfig ensureVideoFileConfig() => $_ensure(23);

  @$pb.TagNumber(28)
  VideoOutputNodeConfig get videoOutputConfig => $_getN(24);
  @$pb.TagNumber(28)
  set videoOutputConfig(VideoOutputNodeConfig v) { setField(28, v); }
  @$pb.TagNumber(28)
  $core.bool hasVideoOutputConfig() => $_has(24);
  @$pb.TagNumber(28)
  void clearVideoOutputConfig() => clearField(28);
  @$pb.TagNumber(28)
  VideoOutputNodeConfig ensureVideoOutputConfig() => $_ensure(24);

  @$pb.TagNumber(29)
  VideoTransformNodeConfig get videoTransformConfig => $_getN(25);
  @$pb.TagNumber(29)
  set videoTransformConfig(VideoTransformNodeConfig v) { setField(29, v); }
  @$pb.TagNumber(29)
  $core.bool hasVideoTransformConfig() => $_has(25);
  @$pb.TagNumber(29)
  void clearVideoTransformConfig() => clearField(29);
  @$pb.TagNumber(29)
  VideoTransformNodeConfig ensureVideoTransformConfig() => $_ensure(25);
}

class OscillatorNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OscillatorNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..e<OscillatorNodeConfig_OscillatorType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: OscillatorNodeConfig_OscillatorType.Square, valueOf: OscillatorNodeConfig_OscillatorType.valueOf, enumValues: OscillatorNodeConfig_OscillatorType.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ratio', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'max', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'min', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.OD)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reverse')
    ..hasRequiredFields = false
  ;

  OscillatorNodeConfig._() : super();
  factory OscillatorNodeConfig({
    OscillatorNodeConfig_OscillatorType type,
    $core.double ratio,
    $core.double max,
    $core.double min,
    $core.double offset,
    $core.bool reverse,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (ratio != null) {
      _result.ratio = ratio;
    }
    if (max != null) {
      _result.max = max;
    }
    if (min != null) {
      _result.min = min;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (reverse != null) {
      _result.reverse = reverse;
    }
    return _result;
  }
  factory OscillatorNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OscillatorNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OscillatorNodeConfig clone() => OscillatorNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OscillatorNodeConfig copyWith(void Function(OscillatorNodeConfig) updates) => super.copyWith((message) => updates(message as OscillatorNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OscillatorNodeConfig create() => OscillatorNodeConfig._();
  OscillatorNodeConfig createEmptyInstance() => create();
  static $pb.PbList<OscillatorNodeConfig> createRepeated() => $pb.PbList<OscillatorNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static OscillatorNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OscillatorNodeConfig>(create);
  static OscillatorNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  OscillatorNodeConfig_OscillatorType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(OscillatorNodeConfig_OscillatorType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get ratio => $_getN(1);
  @$pb.TagNumber(2)
  set ratio($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRatio() => $_has(1);
  @$pb.TagNumber(2)
  void clearRatio() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get max => $_getN(2);
  @$pb.TagNumber(3)
  set max($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMax() => $_has(2);
  @$pb.TagNumber(3)
  void clearMax() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get min => $_getN(3);
  @$pb.TagNumber(4)
  set min($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMin() => $_has(3);
  @$pb.TagNumber(4)
  void clearMin() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get offset => $_getN(4);
  @$pb.TagNumber(5)
  set offset($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOffset() => $_has(4);
  @$pb.TagNumber(5)
  void clearOffset() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get reverse => $_getBF(5);
  @$pb.TagNumber(6)
  set reverse($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReverse() => $_has(5);
  @$pb.TagNumber(6)
  void clearReverse() => clearField(6);
}

class ScriptingNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ScriptingNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'script')
    ..hasRequiredFields = false
  ;

  ScriptingNodeConfig._() : super();
  factory ScriptingNodeConfig({
    $core.String script,
  }) {
    final _result = create();
    if (script != null) {
      _result.script = script;
    }
    return _result;
  }
  factory ScriptingNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScriptingNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScriptingNodeConfig clone() => ScriptingNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScriptingNodeConfig copyWith(void Function(ScriptingNodeConfig) updates) => super.copyWith((message) => updates(message as ScriptingNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ScriptingNodeConfig create() => ScriptingNodeConfig._();
  ScriptingNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ScriptingNodeConfig> createRepeated() => $pb.PbList<ScriptingNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ScriptingNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScriptingNodeConfig>(create);
  static ScriptingNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get script => $_getSZ(0);
  @$pb.TagNumber(1)
  set script($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScript() => $_has(0);
  @$pb.TagNumber(1)
  void clearScript() => clearField(1);
}

class SequenceNodeConfig_SequenceStep extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequenceNodeConfig.SequenceStep', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tick', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hold')
    ..hasRequiredFields = false
  ;

  SequenceNodeConfig_SequenceStep._() : super();
  factory SequenceNodeConfig_SequenceStep({
    $core.double tick,
    $core.double value,
    $core.bool hold,
  }) {
    final _result = create();
    if (tick != null) {
      _result.tick = tick;
    }
    if (value != null) {
      _result.value = value;
    }
    if (hold != null) {
      _result.hold = hold;
    }
    return _result;
  }
  factory SequenceNodeConfig_SequenceStep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceNodeConfig_SequenceStep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceNodeConfig_SequenceStep clone() => SequenceNodeConfig_SequenceStep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceNodeConfig_SequenceStep copyWith(void Function(SequenceNodeConfig_SequenceStep) updates) => super.copyWith((message) => updates(message as SequenceNodeConfig_SequenceStep)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SequenceNodeConfig_SequenceStep create() => SequenceNodeConfig_SequenceStep._();
  SequenceNodeConfig_SequenceStep createEmptyInstance() => create();
  static $pb.PbList<SequenceNodeConfig_SequenceStep> createRepeated() => $pb.PbList<SequenceNodeConfig_SequenceStep>();
  @$core.pragma('dart2js:noInline')
  static SequenceNodeConfig_SequenceStep getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceNodeConfig_SequenceStep>(create);
  static SequenceNodeConfig_SequenceStep _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get tick => $_getN(0);
  @$pb.TagNumber(1)
  set tick($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTick() => $_has(0);
  @$pb.TagNumber(1)
  void clearTick() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get hold => $_getBF(2);
  @$pb.TagNumber(3)
  set hold($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHold() => $_has(2);
  @$pb.TagNumber(3)
  void clearHold() => clearField(3);
}

class SequenceNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SequenceNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..pc<SequenceNodeConfig_SequenceStep>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: SequenceNodeConfig_SequenceStep.create)
    ..hasRequiredFields = false
  ;

  SequenceNodeConfig._() : super();
  factory SequenceNodeConfig({
    $core.Iterable<SequenceNodeConfig_SequenceStep> steps,
  }) {
    final _result = create();
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    return _result;
  }
  factory SequenceNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SequenceNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SequenceNodeConfig clone() => SequenceNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SequenceNodeConfig copyWith(void Function(SequenceNodeConfig) updates) => super.copyWith((message) => updates(message as SequenceNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SequenceNodeConfig create() => SequenceNodeConfig._();
  SequenceNodeConfig createEmptyInstance() => create();
  static $pb.PbList<SequenceNodeConfig> createRepeated() => $pb.PbList<SequenceNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static SequenceNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SequenceNodeConfig>(create);
  static SequenceNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SequenceNodeConfig_SequenceStep> get steps => $_getList(0);
}

class ClockNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClockNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speed', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ClockNodeConfig._() : super();
  factory ClockNodeConfig({
    $core.double speed,
  }) {
    final _result = create();
    if (speed != null) {
      _result.speed = speed;
    }
    return _result;
  }
  factory ClockNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClockNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClockNodeConfig clone() => ClockNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClockNodeConfig copyWith(void Function(ClockNodeConfig) updates) => super.copyWith((message) => updates(message as ClockNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClockNodeConfig create() => ClockNodeConfig._();
  ClockNodeConfig createEmptyInstance() => create();
  static $pb.PbList<ClockNodeConfig> createRepeated() => $pb.PbList<ClockNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static ClockNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClockNodeConfig>(create);
  static ClockNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get speed => $_getN(0);
  @$pb.TagNumber(1)
  set speed($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpeed() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpeed() => clearField(1);
}

class FixtureNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FixtureNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixtureId')
    ..hasRequiredFields = false
  ;

  FixtureNodeConfig._() : super();
  factory FixtureNodeConfig({
    $core.String fixtureId,
  }) {
    final _result = create();
    if (fixtureId != null) {
      _result.fixtureId = fixtureId;
    }
    return _result;
  }
  factory FixtureNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FixtureNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FixtureNodeConfig clone() => FixtureNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FixtureNodeConfig copyWith(void Function(FixtureNodeConfig) updates) => super.copyWith((message) => updates(message as FixtureNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FixtureNodeConfig create() => FixtureNodeConfig._();
  FixtureNodeConfig createEmptyInstance() => create();
  static $pb.PbList<FixtureNodeConfig> createRepeated() => $pb.PbList<FixtureNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static FixtureNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FixtureNodeConfig>(create);
  static FixtureNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fixtureId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fixtureId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFixtureId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFixtureId() => clearField(1);
}

class InputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  InputNodeConfig._() : super();
  factory InputNodeConfig() => create();
  factory InputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InputNodeConfig clone() => InputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InputNodeConfig copyWith(void Function(InputNodeConfig) updates) => super.copyWith((message) => updates(message as InputNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InputNodeConfig create() => InputNodeConfig._();
  InputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<InputNodeConfig> createRepeated() => $pb.PbList<InputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static InputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InputNodeConfig>(create);
  static InputNodeConfig _defaultInstance;
}

class IldaFileNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IldaFileNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'file')
    ..hasRequiredFields = false
  ;

  IldaFileNodeConfig._() : super();
  factory IldaFileNodeConfig({
    $core.String file,
  }) {
    final _result = create();
    if (file != null) {
      _result.file = file;
    }
    return _result;
  }
  factory IldaFileNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IldaFileNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IldaFileNodeConfig clone() => IldaFileNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IldaFileNodeConfig copyWith(void Function(IldaFileNodeConfig) updates) => super.copyWith((message) => updates(message as IldaFileNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IldaFileNodeConfig create() => IldaFileNodeConfig._();
  IldaFileNodeConfig createEmptyInstance() => create();
  static $pb.PbList<IldaFileNodeConfig> createRepeated() => $pb.PbList<IldaFileNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static IldaFileNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IldaFileNodeConfig>(create);
  static IldaFileNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get file => $_getSZ(0);
  @$pb.TagNumber(1)
  set file($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => clearField(1);
}

class LaserNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LaserNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..hasRequiredFields = false
  ;

  LaserNodeConfig._() : super();
  factory LaserNodeConfig({
    $core.String deviceId,
  }) {
    final _result = create();
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    return _result;
  }
  factory LaserNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LaserNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LaserNodeConfig clone() => LaserNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LaserNodeConfig copyWith(void Function(LaserNodeConfig) updates) => super.copyWith((message) => updates(message as LaserNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LaserNodeConfig create() => LaserNodeConfig._();
  LaserNodeConfig createEmptyInstance() => create();
  static $pb.PbList<LaserNodeConfig> createRepeated() => $pb.PbList<LaserNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static LaserNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LaserNodeConfig>(create);
  static LaserNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceId() => clearField(1);
}

class PixelPatternNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PixelPatternNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..e<PixelPatternNodeConfig_Pattern>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pattern', $pb.PbFieldType.OE, defaultOrMaker: PixelPatternNodeConfig_Pattern.RgbIterate, valueOf: PixelPatternNodeConfig_Pattern.valueOf, enumValues: PixelPatternNodeConfig_Pattern.values)
    ..hasRequiredFields = false
  ;

  PixelPatternNodeConfig._() : super();
  factory PixelPatternNodeConfig({
    PixelPatternNodeConfig_Pattern pattern,
  }) {
    final _result = create();
    if (pattern != null) {
      _result.pattern = pattern;
    }
    return _result;
  }
  factory PixelPatternNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PixelPatternNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PixelPatternNodeConfig clone() => PixelPatternNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PixelPatternNodeConfig copyWith(void Function(PixelPatternNodeConfig) updates) => super.copyWith((message) => updates(message as PixelPatternNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PixelPatternNodeConfig create() => PixelPatternNodeConfig._();
  PixelPatternNodeConfig createEmptyInstance() => create();
  static $pb.PbList<PixelPatternNodeConfig> createRepeated() => $pb.PbList<PixelPatternNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static PixelPatternNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PixelPatternNodeConfig>(create);
  static PixelPatternNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  PixelPatternNodeConfig_Pattern get pattern => $_getN(0);
  @$pb.TagNumber(1)
  set pattern(PixelPatternNodeConfig_Pattern v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPattern() => $_has(0);
  @$pb.TagNumber(1)
  void clearPattern() => clearField(1);
}

class PixelDmxNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PixelDmxNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startUniverse', $pb.PbFieldType.OU3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'output')
    ..hasRequiredFields = false
  ;

  PixelDmxNodeConfig._() : super();
  factory PixelDmxNodeConfig({
    $fixnum.Int64 width,
    $fixnum.Int64 height,
    $core.int startUniverse,
    $core.String output,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (startUniverse != null) {
      _result.startUniverse = startUniverse;
    }
    if (output != null) {
      _result.output = output;
    }
    return _result;
  }
  factory PixelDmxNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PixelDmxNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PixelDmxNodeConfig clone() => PixelDmxNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PixelDmxNodeConfig copyWith(void Function(PixelDmxNodeConfig) updates) => super.copyWith((message) => updates(message as PixelDmxNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PixelDmxNodeConfig create() => PixelDmxNodeConfig._();
  PixelDmxNodeConfig createEmptyInstance() => create();
  static $pb.PbList<PixelDmxNodeConfig> createRepeated() => $pb.PbList<PixelDmxNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static PixelDmxNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PixelDmxNodeConfig>(create);
  static PixelDmxNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get width => $_getI64(0);
  @$pb.TagNumber(1)
  set width($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get height => $_getI64(1);
  @$pb.TagNumber(2)
  set height($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get startUniverse => $_getIZ(2);
  @$pb.TagNumber(3)
  set startUniverse($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartUniverse() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartUniverse() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get output => $_getSZ(3);
  @$pb.TagNumber(4)
  set output($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutput() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutput() => clearField(4);
}

class DmxOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DmxOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'output')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'universe', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DmxOutputNodeConfig._() : super();
  factory DmxOutputNodeConfig({
    $core.String output,
    $core.int universe,
    $core.int channel,
  }) {
    final _result = create();
    if (output != null) {
      _result.output = output;
    }
    if (universe != null) {
      _result.universe = universe;
    }
    if (channel != null) {
      _result.channel = channel;
    }
    return _result;
  }
  factory DmxOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DmxOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DmxOutputNodeConfig clone() => DmxOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DmxOutputNodeConfig copyWith(void Function(DmxOutputNodeConfig) updates) => super.copyWith((message) => updates(message as DmxOutputNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DmxOutputNodeConfig create() => DmxOutputNodeConfig._();
  DmxOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<DmxOutputNodeConfig> createRepeated() => $pb.PbList<DmxOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static DmxOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DmxOutputNodeConfig>(create);
  static DmxOutputNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get output => $_getSZ(0);
  @$pb.TagNumber(1)
  set output($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutput() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutput() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get universe => $_getIZ(1);
  @$pb.TagNumber(2)
  set universe($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUniverse() => $_has(1);
  @$pb.TagNumber(2)
  void clearUniverse() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get channel => $_getIZ(2);
  @$pb.TagNumber(3)
  set channel($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannel() => clearField(3);
}

class MidiInputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiInputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  MidiInputNodeConfig._() : super();
  factory MidiInputNodeConfig() => create();
  factory MidiInputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiInputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiInputNodeConfig clone() => MidiInputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiInputNodeConfig copyWith(void Function(MidiInputNodeConfig) updates) => super.copyWith((message) => updates(message as MidiInputNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiInputNodeConfig create() => MidiInputNodeConfig._();
  MidiInputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<MidiInputNodeConfig> createRepeated() => $pb.PbList<MidiInputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static MidiInputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiInputNodeConfig>(create);
  static MidiInputNodeConfig _defaultInstance;
}

class MidiOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  MidiOutputNodeConfig._() : super();
  factory MidiOutputNodeConfig() => create();
  factory MidiOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiOutputNodeConfig clone() => MidiOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiOutputNodeConfig copyWith(void Function(MidiOutputNodeConfig) updates) => super.copyWith((message) => updates(message as MidiOutputNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiOutputNodeConfig create() => MidiOutputNodeConfig._();
  MidiOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<MidiOutputNodeConfig> createRepeated() => $pb.PbList<MidiOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static MidiOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiOutputNodeConfig>(create);
  static MidiOutputNodeConfig _defaultInstance;
}

class OpcOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OpcOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  OpcOutputNodeConfig._() : super();
  factory OpcOutputNodeConfig({
    $core.String host,
    $core.int port,
    $fixnum.Int64 width,
    $fixnum.Int64 height,
  }) {
    final _result = create();
    if (host != null) {
      _result.host = host;
    }
    if (port != null) {
      _result.port = port;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory OpcOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpcOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpcOutputNodeConfig clone() => OpcOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpcOutputNodeConfig copyWith(void Function(OpcOutputNodeConfig) updates) => super.copyWith((message) => updates(message as OpcOutputNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OpcOutputNodeConfig create() => OpcOutputNodeConfig._();
  OpcOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<OpcOutputNodeConfig> createRepeated() => $pb.PbList<OpcOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static OpcOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpcOutputNodeConfig>(create);
  static OpcOutputNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get host => $_getSZ(0);
  @$pb.TagNumber(1)
  set host($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get port => $_getIZ(1);
  @$pb.TagNumber(2)
  set port($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get width => $_getI64(2);
  @$pb.TagNumber(3)
  set width($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get height => $_getI64(3);
  @$pb.TagNumber(4)
  set height($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => clearField(4);
}

class OscInputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OscInputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'host')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'port', $pb.PbFieldType.OU3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'path')
    ..hasRequiredFields = false
  ;

  OscInputNodeConfig._() : super();
  factory OscInputNodeConfig({
    $core.String host,
    $core.int port,
    $core.String path,
  }) {
    final _result = create();
    if (host != null) {
      _result.host = host;
    }
    if (port != null) {
      _result.port = port;
    }
    if (path != null) {
      _result.path = path;
    }
    return _result;
  }
  factory OscInputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OscInputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OscInputNodeConfig clone() => OscInputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OscInputNodeConfig copyWith(void Function(OscInputNodeConfig) updates) => super.copyWith((message) => updates(message as OscInputNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OscInputNodeConfig create() => OscInputNodeConfig._();
  OscInputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<OscInputNodeConfig> createRepeated() => $pb.PbList<OscInputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static OscInputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OscInputNodeConfig>(create);
  static OscInputNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get host => $_getSZ(0);
  @$pb.TagNumber(1)
  set host($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHost() => $_has(0);
  @$pb.TagNumber(1)
  void clearHost() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get port => $_getIZ(1);
  @$pb.TagNumber(2)
  set port($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get path => $_getSZ(2);
  @$pb.TagNumber(3)
  set path($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearPath() => clearField(3);
}

class VideoColorBalanceNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoColorBalanceNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  VideoColorBalanceNodeConfig._() : super();
  factory VideoColorBalanceNodeConfig() => create();
  factory VideoColorBalanceNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoColorBalanceNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoColorBalanceNodeConfig clone() => VideoColorBalanceNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoColorBalanceNodeConfig copyWith(void Function(VideoColorBalanceNodeConfig) updates) => super.copyWith((message) => updates(message as VideoColorBalanceNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoColorBalanceNodeConfig create() => VideoColorBalanceNodeConfig._();
  VideoColorBalanceNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoColorBalanceNodeConfig> createRepeated() => $pb.PbList<VideoColorBalanceNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoColorBalanceNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoColorBalanceNodeConfig>(create);
  static VideoColorBalanceNodeConfig _defaultInstance;
}

class VideoEffectNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoEffectNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  VideoEffectNodeConfig._() : super();
  factory VideoEffectNodeConfig() => create();
  factory VideoEffectNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoEffectNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoEffectNodeConfig clone() => VideoEffectNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoEffectNodeConfig copyWith(void Function(VideoEffectNodeConfig) updates) => super.copyWith((message) => updates(message as VideoEffectNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoEffectNodeConfig create() => VideoEffectNodeConfig._();
  VideoEffectNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoEffectNodeConfig> createRepeated() => $pb.PbList<VideoEffectNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoEffectNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoEffectNodeConfig>(create);
  static VideoEffectNodeConfig _defaultInstance;
}

class VideoFileNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoFileNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'file')
    ..hasRequiredFields = false
  ;

  VideoFileNodeConfig._() : super();
  factory VideoFileNodeConfig({
    $core.String file,
  }) {
    final _result = create();
    if (file != null) {
      _result.file = file;
    }
    return _result;
  }
  factory VideoFileNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoFileNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoFileNodeConfig clone() => VideoFileNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoFileNodeConfig copyWith(void Function(VideoFileNodeConfig) updates) => super.copyWith((message) => updates(message as VideoFileNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoFileNodeConfig create() => VideoFileNodeConfig._();
  VideoFileNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoFileNodeConfig> createRepeated() => $pb.PbList<VideoFileNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoFileNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoFileNodeConfig>(create);
  static VideoFileNodeConfig _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get file => $_getSZ(0);
  @$pb.TagNumber(1)
  set file($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => clearField(1);
}

class VideoOutputNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoOutputNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  VideoOutputNodeConfig._() : super();
  factory VideoOutputNodeConfig() => create();
  factory VideoOutputNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoOutputNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoOutputNodeConfig clone() => VideoOutputNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoOutputNodeConfig copyWith(void Function(VideoOutputNodeConfig) updates) => super.copyWith((message) => updates(message as VideoOutputNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoOutputNodeConfig create() => VideoOutputNodeConfig._();
  VideoOutputNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoOutputNodeConfig> createRepeated() => $pb.PbList<VideoOutputNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoOutputNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoOutputNodeConfig>(create);
  static VideoOutputNodeConfig _defaultInstance;
}

class VideoTransformNodeConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoTransformNodeConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  VideoTransformNodeConfig._() : super();
  factory VideoTransformNodeConfig() => create();
  factory VideoTransformNodeConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoTransformNodeConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoTransformNodeConfig clone() => VideoTransformNodeConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoTransformNodeConfig copyWith(void Function(VideoTransformNodeConfig) updates) => super.copyWith((message) => updates(message as VideoTransformNodeConfig)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoTransformNodeConfig create() => VideoTransformNodeConfig._();
  VideoTransformNodeConfig createEmptyInstance() => create();
  static $pb.PbList<VideoTransformNodeConfig> createRepeated() => $pb.PbList<VideoTransformNodeConfig>();
  @$core.pragma('dart2js:noInline')
  static VideoTransformNodeConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoTransformNodeConfig>(create);
  static VideoTransformNodeConfig _defaultInstance;
}

class NodePosition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodePosition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  NodePosition._() : super();
  factory NodePosition({
    $core.double x,
    $core.double y,
  }) {
    final _result = create();
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    return _result;
  }
  factory NodePosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodePosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodePosition clone() => NodePosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodePosition copyWith(void Function(NodePosition) updates) => super.copyWith((message) => updates(message as NodePosition)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodePosition create() => NodePosition._();
  NodePosition createEmptyInstance() => create();
  static $pb.PbList<NodePosition> createRepeated() => $pb.PbList<NodePosition>();
  @$core.pragma('dart2js:noInline')
  static NodePosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodePosition>(create);
  static NodePosition _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);
}

class NodeDesigner extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NodeDesigner', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOM<NodePosition>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', subBuilder: NodePosition.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scale', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  NodeDesigner._() : super();
  factory NodeDesigner({
    NodePosition position,
    $core.double scale,
  }) {
    final _result = create();
    if (position != null) {
      _result.position = position;
    }
    if (scale != null) {
      _result.scale = scale;
    }
    return _result;
  }
  factory NodeDesigner.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeDesigner.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeDesigner clone() => NodeDesigner()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeDesigner copyWith(void Function(NodeDesigner) updates) => super.copyWith((message) => updates(message as NodeDesigner)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NodeDesigner create() => NodeDesigner._();
  NodeDesigner createEmptyInstance() => create();
  static $pb.PbList<NodeDesigner> createRepeated() => $pb.PbList<NodeDesigner>();
  @$core.pragma('dart2js:noInline')
  static NodeDesigner getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeDesigner>(create);
  static NodeDesigner _defaultInstance;

  @$pb.TagNumber(1)
  NodePosition get position => $_getN(0);
  @$pb.TagNumber(1)
  set position(NodePosition v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearPosition() => clearField(1);
  @$pb.TagNumber(1)
  NodePosition ensurePosition() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get scale => $_getN(1);
  @$pb.TagNumber(2)
  set scale($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScale() => $_has(1);
  @$pb.TagNumber(2)
  void clearScale() => clearField(2);
}

class Port extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Port', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mizer'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<ChannelProtocol>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protocol', $pb.PbFieldType.OE, defaultOrMaker: ChannelProtocol.Single, valueOf: ChannelProtocol.valueOf, enumValues: ChannelProtocol.values)
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

