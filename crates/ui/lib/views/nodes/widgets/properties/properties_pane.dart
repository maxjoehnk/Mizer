import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/groups/help_group.dart';

import 'groups/comment_group.dart';
import 'groups/node_group.dart';
import 'groups/port_group.dart';
import 'groups/settings_group.dart';

class NodePropertiesPane extends StatefulWidget {
  final Node? node;
  final NodeCommentArea? comment;
  final Function() onUpdate;

  NodePropertiesPane({this.node, this.comment, required this.onUpdate});

  @override
  State<NodePropertiesPane> createState() => _NodePropertiesPaneState();
}

class _NodePropertiesPaneState extends State<NodePropertiesPane> {
  String? hoveredSetting;

  @override
  Widget build(BuildContext context) {
    if (this.widget.node == null && this.widget.comment == null) {
      return Container();
    }
    var nodesApi = context.read<NodesApi>();
    if (this.widget.comment != null) {
      return Container(
        padding: EdgeInsets.all(2),
        child: ListView(
          children: [
            NodeCommentAreaProperties(
                comment: this.widget.comment!,
                onUpdate: (req) {
                  nodesApi.updateComment(req);
                  widget.onUpdate();
                }),
          ],
        ),
      );
    }
    Node node = this.widget.node!;

    return Container(
        padding: EdgeInsets.all(2),
        child: ListView(
          children: _getPropertyPanes(node, nodesApi),
        ));
  }

  List<Widget> _getPropertyPanes(Node node, NodesApi nodesApi) {
    List<Widget> widgets = [
      NodeProperties(
          node: node,
          onUpdateColor: (color) {
            nodesApi.updateNodeColor(UpdateNodeColorRequest(path: node.path, color: color));
            widget.onUpdate();
          }),
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
