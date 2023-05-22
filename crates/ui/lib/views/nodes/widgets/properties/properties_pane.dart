import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'groups/node_group.dart';
import 'groups/settings_group.dart';

class NodePropertiesPane extends StatelessWidget {
  final Node? node;
  final Function() onUpdate;

  NodePropertiesPane({this.node, required this.onUpdate});

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
      NodeSettingsPane(
          title: NODE_LABELS[node.type] ?? "",
          type: node.type,
          settings: node.settings,
          onUpdate: (updated) {
            nodesApi.updateNodeSetting(UpdateNodeSettingRequest(path: node.path, setting: updated));
            onUpdate();
          }),
    ];
    return widgets;
  }
}
