import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/consts.dart';
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
  Stream<NodePathSettings>? _settings$;

  @override
  void initState() {
    super.initState();
    _observeSettings();
  }

  @override
  void didUpdateWidget(NodePropertiesPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.node?.path != this.widget.node?.path) {
      this._settings$ = null;
      _observeSettings();
    }
  }

  @override
  void activate() {
    super.activate();
    _observeSettings();
  }

  void _observeSettings() {
    if (this.widget.node?.path != null) {
      var path = this.widget.node!.path;
      context.read<NodesApi>().openNodeSettings([path]);
      _settings$ = context.read<NodesApi>().nodeSettings(path).map((settings) =>
          NodePathSettings(path: path, settings: settings));
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
        padding: EdgeInsets.all(PANEL_GAP_SIZE),
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
      if (_settings$ != null)
        StreamBuilder(
            stream: _settings$,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.requireData.path != node.path) {
                return Container();
              }
              return NodeSettingsPane(
                  nodePath: snapshot.requireData.path,
                  title: "Settings".i18n,
                  type: node.type,
                  settings: snapshot.requireData.settings,
                  onUpdate: (updated) {
                    nodesApi.updateNodeSetting(
                        UpdateNodeSettingRequest(path: snapshot.requireData.path, setting: updated));
                    widget.onUpdate();
                  },
                  onHover: (setting) => setState(() {
                        hoveredSetting = setting?.id;
                      }));
            }),
      if (node.inputs.isNotEmpty)
        NodeInputsPane(node: node),
      if (node.outputs.isNotEmpty)
        NodeOutputsPane(node: node),
      HelpGroup(nodeType: node.type, hoveredSetting: hoveredSetting)
    ];
    return widgets;
  }
}

class NodePathSettings {
  final String path;
  final List<NodeSetting> settings;

  NodePathSettings({required this.path, required this.settings});
}
