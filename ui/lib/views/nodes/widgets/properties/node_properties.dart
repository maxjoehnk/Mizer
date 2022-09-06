import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/groups/envelope_properties.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/groups/gamepad_properties.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/groups/midi_properties.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/groups/threshold_properties.dart';

import 'properties/groups/button_properties.dart';
import 'properties/groups/dmx_output_properties.dart';
import 'properties/groups/encoder_properties.dart';
import 'properties/groups/fixture_properties.dart';
import 'properties/groups/math_properties.dart';
import 'properties/groups/merge_properties.dart';
import 'properties/groups/mqtt_input_properties.dart';
import 'properties/groups/mqtt_output_properties.dart';
import 'properties/groups/oscillator_properties.dart';
import 'properties/groups/osc_properties.dart';
import 'properties/groups/sequencer_properties.dart';
import 'properties/groups/value_properties.dart';
import 'properties/groups/video_file_properties.dart';

class NodePropertiesPane extends StatelessWidget {
  final Node? node;

  NodePropertiesPane({this.node});

  @override
  Widget build(BuildContext context) {
    if (this.node == null) {
      return Container();
    }
    Node node = this.node!;
    var nodesApi = context.read<NodesApi>();
    var textTheme = Theme.of(context).textTheme;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade800,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(4, 4))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(node.path),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              NODE_LABELS[node.type] ?? "",
              style: textTheme.bodySmall,
            ),
          ),
          ..._getPropertyPanes(node, nodesApi),
        ]));
  }

  List<Widget> _getPropertyPanes(Node node, NodesApi nodesApi) {
    List<Widget> widgets = [];
    if (node.config.hasOscillatorConfig()) {
      widgets.add(OscillatorProperties(node.config.oscillatorConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                oscillatorConfig: config,
              )))));
    }
    if (node.config.hasDmxOutputConfig()) {
      widgets.add(DmxOutputProperties(node.config.dmxOutputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                dmxOutputConfig: config,
              )))));
    }
    if (node.config.hasFixtureConfig()) {
      widgets.add(FixtureProperties(node.config.fixtureConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(fixtureConfig: config)))));
    }
    if (node.config.hasVideoFileConfig()) {
      widgets.add(VideoFileProperties(node.config.videoFileConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(videoFileConfig: config)))));
    }
    if (node.config.hasOscInputConfig()) {
      widgets.add(OscProperties(node.config.oscInputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(oscInputConfig: config)))));
    }
    if (node.config.hasOscOutputConfig()) {
      widgets.add(OscProperties(node.config.oscOutputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(oscOutputConfig: config)))));
    }
    if (node.config.hasMidiInputConfig()) {
      widgets.add(MidiProperties(node.config.midiInputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(midiInputConfig: config)))));
    }
    if (node.config.hasMidiOutputConfig()) {
      widgets.add(MidiProperties(node.config.midiOutputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(midiOutputConfig: config)))));
    }
    if (node.config.hasGamepadNodeConfig()) {
      widgets.add(GamepadProperties(node.config.gamepadNodeConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(gamepadNodeConfig: config)))));
    }
    if (node.config.hasThresholdConfig()) {
      widgets.add(ThresholdProperties(node.config.thresholdConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(thresholdConfig: config)))));
    }
    if (node.config.hasEnvelopeConfig()) {
      widgets.add(EnvelopeProperties(node.config.envelopeConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(envelopeConfig: config)))));
    }
    if (node.config.hasButtonConfig()) {
      widgets.add(ButtonProperties(node.config.buttonConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(buttonConfig: config)))));
    }
    if (node.config.hasMergeConfig()) {
      widgets.add(MergeProperties(node.config.mergeConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(mergeConfig: config)))));
    }
    if (node.config.hasSequencerConfig()) {
      widgets.add(SequencerProperties(node.config.sequencerConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(sequencerConfig: config)))));
    }
    if (node.config.hasEncoderConfig()) {
      widgets.add(EncoderProperties(node.config.encoderConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(encoderConfig: config)))));
    }
    if (node.config.hasMathConfig()) {
      widgets.add(MathProperties(node.config.mathConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(mathConfig: config)))));
    }
    if (node.config.hasMqttInputConfig()) {
      widgets.add(MqttInputProperties(node.config.mqttInputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(mqttInputConfig: config)))));
    }
    if (node.config.hasMqttOutputConfig()) {
      widgets.add(MqttOutputProperties(node.config.mqttOutputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(mqttOutputConfig: config)))));
    }
    if (node.config.hasValueConfig()) {
      widgets.add(ValueProperties(node.config.valueConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(valueConfig: config)))));
    }
    return widgets;
  }
}
