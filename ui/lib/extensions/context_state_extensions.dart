import 'package:flutter/widgets.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:provider/provider.dart';

extension ContextStateExtensions on BuildContext {
  void refreshAllStates() {
    this.read<FixturesBloc>().add(FetchFixtures());
    this.read<LayoutsBloc>().add(FetchLayouts());
    this.read<MediaBloc>().add(MediaEvent.Fetch);
    this.read<NodesBloc>().add(FetchNodes());
    this.read<SequencerBloc>().add(FetchSequences());
    this.read<PresetsBloc>().add(FetchPresets());
    this.read<PlansBloc>().add(FetchPlans());
    this.read<EffectsBloc>().add(FetchEffects());
  }
}
