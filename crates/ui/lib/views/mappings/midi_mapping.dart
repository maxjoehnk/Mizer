import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/api/contracts/mappings.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

import 'midi_properties.dart';

class MidiMappingDialog extends StatefulWidget {
  final String title;

  const MidiMappingDialog({required this.title, Key? key}) : super(key: key);

  @override
  State<MidiMappingDialog> createState() => _MidiMappingDialogState();
}

class _MidiMappingDialogState extends State<MidiMappingDialog> {
  MidiNodeConfig config = MidiNodeConfig();

  MidiMapping? get binding {
    return MidiMapping(
      config: config,
      inputMapping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: widget.title,
        content: Column(children: [
          MidiProperties(config, isInput: true, onUpdate: (c) => setState(() => config = c)),
        ]),
        actions: [
          PopupAction("Cancel", () => Navigator.of(context).pop()),
          PopupAction("Add", () => Navigator.of(context).pop(binding)),
        ]);
  }
}

Future<void> addMidiMapping(BuildContext context, String title, MappingRequest request) async {
  MidiMapping? mapping = await showDialog(
      context: context,
      builder: (_) => RepositoryProvider<ConnectionsApi>(
          create: (c) => context.read<ConnectionsApi>(), child: MidiMappingDialog(title: title)));
  if (mapping == null) {
    return;
  }
  var api = context.read<MappingsApi>();
  request.midi = mapping;
  await api.addMapping(request);
}
