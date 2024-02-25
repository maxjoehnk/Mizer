import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/groups/help_group.dart';

import 'groups/node_group.dart';
import 'groups/settings_group.dart';

class NodePropertiesPane extends StatefulWidget {
  final Node? node;
  final Function() onUpdate;

  NodePropertiesPane({this.node, required this.onUpdate});

  @override
  State<NodePropertiesPane> createState() => _NodePropertiesPaneState();
}

class _NodePropertiesPaneState extends State<NodePropertiesPane> {
  String? hoveredSetting;

  @override
  Widget build(BuildContext context) {
    if (this.widget.node == null) {
      return Container();
    }
    Node node = this.widget.node!;
    var nodesApi = context.read<NodesApi>();

    return Container(
        padding: EdgeInsets.all(4),
        child: ListView(
          children: _getPropertyPanes(node, nodesApi),
        ));
  }

  List<Widget> _getPropertyPanes(Node node, NodesApi nodesApi) {
    List<Widget> widgets = [
      NodeProperties(node: node),
      NodeSettingsPane(
          nodePath: node.path,
          title: node.details.nodeTypeName,
          type: node.type,
          settings: node.settings,
          onUpdate: (updated) {
            nodesApi.updateNodeSetting(UpdateNodeSettingRequest(path: node.path, setting: updated));
            widget.onUpdate();
          },
          onHover: (setting) => setState(() {
                hoveredSetting = setting?.id;
              })),
      HelpGroup(nodeType: node.type, hoveredSetting: hoveredSetting)
    ];
    return widgets;
  }
}
