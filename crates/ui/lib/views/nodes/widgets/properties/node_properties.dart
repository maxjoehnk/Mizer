import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/node_properties.dart';

import 'properties/groups/button_properties.dart';
import 'properties/groups/conditional_properties.dart';
import 'properties/groups/constant_number_properties.dart';
import 'properties/groups/delay_properties.dart';
import 'properties/groups/dmx_output_properties.dart';
import 'properties/groups/encoder_properties.dart';
import 'properties/groups/envelope_properties.dart';
import 'properties/groups/extract_properties.dart';
import 'properties/groups/fixture_properties.dart';
import 'properties/groups/g13_input_properties.dart';
import 'properties/groups/g13_output_properties.dart';
import 'properties/groups/gamepad_properties.dart';
import 'properties/groups/label_properties.dart';
import 'properties/groups/math_properties.dart';
import 'properties/groups/merge_properties.dart';
import 'properties/groups/midi_properties.dart';
import 'properties/groups/mqtt_input_properties.dart';
import 'properties/groups/mqtt_output_properties.dart';
import 'properties/groups/noise_properties.dart';
import 'properties/groups/osc_properties.dart';
import 'properties/groups/oscillator_properties.dart';
import 'properties/groups/pixel_pattern_properties.dart';
import 'properties/groups/ramp_properties.dart';
import 'properties/groups/sequencer_properties.dart';
import 'properties/groups/template_properties.dart';
import 'properties/groups/threshold_properties.dart';
import 'properties/groups/timecode_control_properties.dart';
import 'properties/groups/timecode_output_properties.dart';
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

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getPropertyPanes(node, nodesApi),
    ));
  }

  List<Widget> _getPropertyPanes(Node node, NodesApi nodesApi) {
    List<Widget> widgets = [
      NodeProperties(node: node),
    ];
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
              path: node.path, config: NodeConfig(oscOutputConfig: config))),
          isOutput: true));
    }
    if (node.config.hasMidiInputConfig()) {
      widgets.add(MidiProperties(node.config.midiInputConfig,
          isInput: true,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(midiInputConfig: config)))));
    }
    if (node.config.hasMidiOutputConfig()) {
      widgets.add(MidiProperties(node.config.midiOutputConfig,
          isInput: false,
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
          onUpdate: (config) => nodesApi.updateNodeConfig(
              UpdateNodeConfigRequest(path: node.path, config: NodeConfig(buttonConfig: config)))));
    }
    if (node.config.hasMergeConfig()) {
      widgets.add(MergeProperties(node.config.mergeConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(
              UpdateNodeConfigRequest(path: node.path, config: NodeConfig(mergeConfig: config)))));
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
          onUpdate: (config) => nodesApi.updateNodeConfig(
              UpdateNodeConfigRequest(path: node.path, config: NodeConfig(mathConfig: config)))));
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
          onUpdate: (config) => nodesApi.updateNodeConfig(
              UpdateNodeConfigRequest(path: node.path, config: NodeConfig(valueConfig: config)))));
    }
    if (node.config.hasExtractConfig()) {
      widgets.add(ExtractProperties(node.config.extractConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(extractConfig: config)))));
    }
    if (node.config.hasTemplateConfig()) {
      widgets.add(TemplateProperties(node.config.templateConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(templateConfig: config)))));
    }
    if (node.config.hasDelayConfig()) {
      widgets.add(DelayProperties(node.config.delayConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(
              UpdateNodeConfigRequest(path: node.path, config: NodeConfig(delayConfig: config)))));
    }
    if (node.config.hasRampConfig()) {
      widgets.add(RampProperties(node.config.rampConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(
              UpdateNodeConfigRequest(path: node.path, config: NodeConfig(rampConfig: config)))));
    }
    if (node.config.hasNoiseConfig()) {
      widgets.add(NoiseProperties(node.config.noiseConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(
              UpdateNodeConfigRequest(path: node.path, config: NodeConfig(noiseConfig: config)))));
    }
    if (node.config.hasLabelConfig()) {
      widgets.add(LabelProperties(node.config.labelConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(
              UpdateNodeConfigRequest(path: node.path, config: NodeConfig(labelConfig: config)))));
    }
    if (node.config.hasG13InputConfig()) {
      widgets.add(G13InputProperties(node.config.g13InputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(g13InputConfig: config)))));
    }
    if (node.config.hasG13OutputConfig()) {
      widgets.add(G13OutputProperties(node.config.g13OutputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(g13OutputConfig: config)))));
    }
    if (node.config.hasConstantNumberConfig()) {
      widgets.add(ConstantNumberProperties(node.config.constantNumberConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                constantNumberConfig: config,
              )))));
    }
    if (node.config.hasConditionalConfig()) {
      widgets.add(ConditionalProperties(node.config.conditionalConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                conditionalConfig: config,
              )))));
    }
    if (node.config.hasTimecodeControlConfig()) {
      widgets.add(TimecodeControlProperties(node.config.timecodeControlConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                timecodeControlConfig: config,
              )))));
    }
    if (node.config.hasTimecodeOutputConfig()) {
      widgets.add(TimecodeOutputProperties(node.config.timecodeOutputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                timecodeOutputConfig: config,
              )))));
    }
    if (node.config.hasPixelPatternConfig()) {
      widgets.add(PixelPatternProperties(node.config.pixelPatternConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                pixelPatternConfig: config,
              )))));
    }
    return widgets;
  }
}
