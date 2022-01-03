import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/groups/midi_properties.dart';

import 'properties/groups/dmx_output_properties.dart';
import 'properties/groups/fixture_properties.dart';
import 'properties/groups/oscillator_properties.dart';
import 'properties/groups/osc_properties.dart';
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
              BoxShadow(
                  color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(4, 4))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(node.path),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(NODE_LABELS[node.type] ?? "", style: textTheme.bodySmall,),
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
    return widgets;
  }
}
