import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/sequencer_bloc.dart';

import '../field.dart';
import '../property_group.dart';

class SequencerProperties extends StatefulWidget {
  final SequencerNodeConfig config;
  final Function(SequencerNodeConfig) onUpdate;

  SequencerProperties(this.config, {required this.onUpdate});

  @override
  _SequencerPropertiesState createState() => _SequencerPropertiesState(config);
}

class _SequencerPropertiesState extends State<SequencerProperties> {
  SequencerNodeConfig state;

  _SequencerPropertiesState(this.state);

  @override
  void didUpdateWidget(SequencerProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(
      title: "Sequencer",
      children: [_SequencerInfo(widget.config)],
    );
  }
}

class _SequencerInfo extends StatelessWidget {
  final SequencerNodeConfig config;

  _SequencerInfo(this.config);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SequencerBloc, SequencerState>(builder: (context, sequences) {
      var sequence = sequences.sequences.firstWhereOrNull((s) => s.id == config.sequenceId);
      var sequenceName = sequence?.name ?? "";

      return Field(label: "Sequence", child: Text(sequenceName));
    });
  }
}
