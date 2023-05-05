import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../fields/text_field.dart';
import '../property_group.dart';

class TemplateProperties extends StatefulWidget {
  final TemplateNodeConfig config;
  final Function(TemplateNodeConfig) onUpdate;

  TemplateProperties(this.config, {required this.onUpdate});

  @override
  _TemplatePropertiesState createState() => _TemplatePropertiesState(config);
}

class _TemplatePropertiesState extends State<TemplateProperties> {
  TemplateNodeConfig state;

  _TemplatePropertiesState(this.state);

  @override
  void didUpdateWidget(TemplateProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Template", children: [
      TextPropertyField(
        label: "Template",
        value: this.widget.config.template,
        onUpdate: _updateTemplate,
        multiline: true,
      ),
    ]);
  }

  void _updateTemplate(String template) {
    log("_updateTemplate $template", name: "TemplateProperties");
    setState(() {
      state.template = template;
      widget.onUpdate(state);
    });
  }
}
