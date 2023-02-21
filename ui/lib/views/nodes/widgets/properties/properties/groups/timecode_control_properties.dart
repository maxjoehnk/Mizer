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

class TimecodeControlProperties extends StatefulWidget {
  final TimecodeControlNodeConfig config;
  final Function(TimecodeControlNodeConfig) onUpdate;

  TimecodeControlProperties(this.config, {required this.onUpdate});

  @override
  _TimecodeControlPropertiesState createState() => _TimecodeControlPropertiesState(config);
}

class _TimecodeControlPropertiesState extends State<TimecodeControlProperties> {
  TimecodeControlNodeConfig state;

  _TimecodeControlPropertiesState(this.state);

  @override
  void didUpdateWidget(TimecodeControlProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimecodeBloc, AllTimecodes>(
      builder: (context, state) {
        return PropertyGroup(title: "Timecode Control", children: [
          EnumField<int>(
            label: "Timecode",
            initialValue: widget.config.timecodeId,
            items: state.timecodes.map((t) => SelectOption(value: t.id, label: t.name)).toList(),
            onUpdate: _updateTimecode,
          ),
        ]);
      },
    );
  }

  void _updateTimecode(int timecodeId) {
    log("_updateTimecode $timecodeId", name: "TimecodeControlProperties");
    setState(() {
      state.timecodeId = timecodeId;
      widget.onUpdate(state);
    });
  }
}
