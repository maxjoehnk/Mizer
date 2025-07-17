import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/panels/panel_view.dart';
import 'package:mizer/state/navigation_bloc.dart';
import 'package:mizer/views/connections/connections_view.dart';
import 'package:mizer/views/dmx_output/dmx_output.dart';
import 'package:mizer/views/fixture_definitions/fixture_definitions_view.dart';
import 'package:mizer/views/history/history_view.dart';
import 'package:mizer/views/midi_profiles/midi_profiles_view.dart';
import 'package:mizer/views/patch/fixture_patch.dart';
import 'package:mizer/views/preferences/preferences.dart';
import 'package:mizer/views/session/session_view.dart';

class ViewRouter extends StatelessWidget {
  const ViewRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (BuildContext context, NavigationState state) {
        if (state.currentRoute is PatchRoute) {
          return FixturePatchView();
        }
        if (state.currentRoute is DmxRoute) {
          return DmxOutputView();
        }
        if (state.currentRoute is ConnectionsRoute) {
          return ConnectionsView();
        }
        if (state.currentRoute is HistoryRoute) {
          return HistoryView();
        }
        if (state.currentRoute is SessionRoute) {
          return SessionView();
        }
        if (state.currentRoute is PreferencesRoute) {
          return PreferencesView();
        }
        if (state.currentRoute is MidiProfilesRoute) {
          return MidiProfilesView();
        }
        if (state.currentRoute is FixtureLibraryRoute) {
          return FixtureDefinitionsView();
        }
        if (state.currentRoute is MizerViewRoute) {
          int index = (state.currentRoute as MizerViewRoute).index;
          if (index < state.sidebar.length) {
            return PanelView(viewChild: state.sidebar[index].child);
          }
        }

        return Center(child: Text("${state.currentRoute.runtimeType} is not implemented yet. Please check the navigation state."));
      },
    );
  }
}
