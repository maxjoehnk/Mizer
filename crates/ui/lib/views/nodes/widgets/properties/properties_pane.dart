import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/groups/help_group.dart';

import 'groups/node_group.dart';
import 'groups/port_group.dart';
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
  void didUpdateWidget(NodePropertiesPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.node?.path != this.widget.node?.path && this.widget.node?.path != null) {
      context.read<NodesApi>().openNodeSettings([this.widget.node!.path]);
    }
  }

  @override
  void activate() {
    super.activate();
    if (this.widget.node?.path != null) {
      context.read<NodesApi>().openNodeSettings([this.widget.node!.path]);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<NodesApi>().openNodeSettings([]);
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.node == null) {
      return Container();
    }
    Node node = this.widget.node!;
    var nodesApi = context.read<NodesApi>();

    return Container(
        padding: EdgeInsets.all(2),
        child: ListView(
          children: _getPropertyPanes(node, nodesApi),
        ));
  }

  List<Widget> _getPropertyPanes(Node node, NodesApi nodesApi) {
    List<Widget> widgets = [
      NodeProperties(node: node,
        onUpdateColor: (color) {
          nodesApi.updateNodeColor(UpdateNodeColorRequest(path: node.path, color: color));
          widget.onUpdate();
        }
      ),
      NodeSettingsPane(
          nodePath: node.path,
          title: "Settings".i18n,
          type: node.type,
          settings: node.settings,
          onUpdate: (updated) {
            nodesApi.updateNodeSetting(UpdateNodeSettingRequest(path: node.path, setting: updated));
            widget.onUpdate();
          },
          onHover: (setting) => setState(() {
                hoveredSetting = setting?.id;
              })),
      NodeInputsPane(node: node),
      NodeOutputsPane(node: node),
      HelpGroup(nodeType: node.type, hoveredSetting: hoveredSetting)
    ];
    return widgets;
  }
}
