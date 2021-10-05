import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'properties/groups/dmx_output_properties.dart';
import 'properties/groups/fixture_properties.dart';
import 'properties/groups/oscillator_properties.dart';
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade800,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(4, 4))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(node.path),
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
    return widgets;
  }
}
