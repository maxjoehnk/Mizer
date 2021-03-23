import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Positioned(
        top: 16,
        right: 16,
        bottom: 16,
        width: 256,
        child: Container(
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
              ..._getPropertyPanes(),
            ])));
  }

  List<Widget> _getPropertyPanes() {
    List<Widget> widgets = [];
    if (this.node.hasOscillatorConfig()) {
      widgets.add(OscillatorProperties(this.node.oscillatorConfig));
    }
    if (this.node.hasDmxOutputConfig()) {
      widgets.add(DmxOutputProperties(this.node.dmxOutputConfig));
    }
    if (this.node.hasFixtureConfig()) {
      widgets.add(FixtureProperties(this.node.fixtureConfig));
    }
    if (this.node.hasVideoFileConfig()) {
      widgets.add(VideoFileProperties(this.node.videoFileConfig));
    }
    return widgets;
  }
}
