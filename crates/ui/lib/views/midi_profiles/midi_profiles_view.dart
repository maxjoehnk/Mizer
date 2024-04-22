import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/midi_profiles_bloc.dart';

import 'midi_profiles_table.dart';

class MidiProfilesView extends StatelessWidget {
  const MidiProfilesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MidiProfilesBloc, MidiProfilesState>(
      builder: (context, state) => MidiProfilesTable(profiles: state.profiles),
    );
  }
}
