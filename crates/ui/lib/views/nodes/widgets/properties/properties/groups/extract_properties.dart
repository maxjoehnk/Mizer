import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../fields/text_field.dart';
import '../property_group.dart';

class ExtractProperties extends StatefulWidget {
  final ExtractNodeConfig config;
  final Function(ExtractNodeConfig) onUpdate;

  ExtractProperties(this.config, {required this.onUpdate});

  @override
  _ExtractPropertiesState createState() => _ExtractPropertiesState(config);
}

class _ExtractPropertiesState extends State<ExtractProperties> {
  ExtractNodeConfig state;

  _ExtractPropertiesState(this.state);

  @override
  void didUpdateWidget(ExtractProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Extract", children: [
      TextPropertyField(
        label: "Path",
        value: this.widget.config.path,
        onUpdate: _updatePath,
      ),
    ]);
  }

  void _updatePath(String path) {
    log("_updatePath $path", name: "ExtractProperties");
    setState(() {
      state.path = path;
      widget.onUpdate(state);
    });
  }
}
