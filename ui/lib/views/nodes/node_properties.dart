import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/properties/groups/dmx_output_properties.dart';
import 'package:mizer/views/nodes/properties/groups/fixture_properties.dart';
import 'package:mizer/views/nodes/properties/groups/oscillator_properties.dart';
import 'package:mizer/views/nodes/properties/groups/video_file_properties.dart';

class NodePropertiesPane extends StatelessWidget {
  final Node node;

  NodePropertiesPane({this.node});

  @override
  Widget build(BuildContext context) {
    if (this.node == null) {
      return Container();
    }
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
            child: Text(this.node.path),
          ),
          ..._getPropertyPanes(nodesApi),
        ]));
  }

  List<Widget> _getPropertyPanes(NodesApi nodesApi) {
    List<Widget> widgets = [];
    if (this.node.config.hasOscillatorConfig()) {
      widgets.add(OscillatorProperties(this.node.config.oscillatorConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                oscillatorConfig: config,
              )))));
    }
    if (this.node.config.hasDmxOutputConfig()) {
      widgets.add(DmxOutputProperties(this.node.config.dmxOutputConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path,
              config: NodeConfig(
                dmxOutputConfig: config,
              )))));
    }
    if (this.node.config.hasFixtureConfig()) {
      widgets.add(FixtureProperties(this.node.config.fixtureConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(fixtureConfig: config)))));
    }
    if (this.node.config.hasVideoFileConfig()) {
      widgets.add(VideoFileProperties(this.node.config.videoFileConfig,
          onUpdate: (config) => nodesApi.updateNodeConfig(UpdateNodeConfigRequest(
              path: node.path, config: NodeConfig(videoFileConfig: config)))));
    }
    return widgets;
  }
}
