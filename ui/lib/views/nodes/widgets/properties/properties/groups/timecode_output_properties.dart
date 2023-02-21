import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/protos/timecode.pb.dart';
import 'package:mizer/state/timecode_bloc.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../fields/enum_field.dart';
import '../property_group.dart';

class TimecodeOutputProperties extends StatefulWidget {
  final TimecodeOutputNodeConfig config;
  final Function(TimecodeOutputNodeConfig) onUpdate;

  TimecodeOutputProperties(this.config, {required this.onUpdate});

  @override
  _TimecodeOutputPropertiesState createState() => _TimecodeOutputPropertiesState(config);
}

class _TimecodeOutputPropertiesState extends State<TimecodeOutputProperties> {
  TimecodeOutputNodeConfig state;

  _TimecodeOutputPropertiesState(this.state);

  @override
  void didUpdateWidget(TimecodeOutputProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimecodeBloc, AllTimecodes>(
      builder: (context, state) {
        return PropertyGroup(title: "Timecode Output", children: [
          EnumField<int>(
            label: "Control",
            initialValue: widget.config.controlId,
            items: state.controls.map((c) => SelectOption(value: c.id, label: c.name)).toList(),
            onUpdate: _updateTimecodeControl,
          ),
        ]);
      },
    );
  }

  void _updateTimecodeControl(int controlId) {
    log("_updateTimecodeControl $controlId", name: "TimecodeOutputProperties");
    setState(() {
      state.controlId = controlId;
      widget.onUpdate(state);
    });
  }
}
