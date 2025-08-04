import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/console_bloc.dart';
import 'package:mizer/state/midi_profiles_bloc.dart';
import 'package:mizer/state/nodes_view.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/state/status_bar_bloc.dart';
import 'package:mizer/state/surfaces_bloc.dart';

import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'presets_bloc.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/state/timecode_bloc.dart';

class StateProvider extends StatelessWidget {
  final Widget child;

  StateProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: NodesViewState(child: this.child),
      providers: [
        BlocProvider(create: (context) => NodesBloc(context.read())),
        BlocProvider(create: (context) => SessionBloc(context.read())),
        BlocProvider(create: (context) => FixturesBloc(context.read())),
        BlocProvider(create: (context) => MediaBloc(context.read())),
        BlocProvider(create: (context) => LayoutsBloc(context.read())),
        BlocProvider(create: (context) => SettingsBloc(context.read())),
        BlocProvider(create: (context) => MidiProfilesBloc(context.read())),
        BlocProvider(create: (context) => SequencerBloc(context.read())),
        BlocProvider(create: (context) => PresetsBloc(context.read())),
        BlocProvider(create: (context) => PlansBloc(context.read())),
        BlocProvider(create: (context) => EffectsBloc(context.read())),
        BlocProvider(create: (context) => TimecodeBloc(context.read())),
        BlocProvider(create: (context) => StatusBarCubit(context.read())),
        BlocProvider(create: (context) => SurfacesCubit(context.read())),
        BlocProvider(create: (context) => ConsoleCubit(context.read())),
      ],
    );
  }
}
