import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:mizer/api/contracts/ui.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/ui.pb.dart';
import 'package:provider/provider.dart';

class MizerRoute {}

class MizerViewRoute extends MizerRoute {
  final int index;

  MizerViewRoute({required this.index});
}

class PatchRoute extends MizerRoute {}

class ConnectionsRoute extends MizerRoute {}

class DmxRoute extends MizerRoute {}

class HistoryRoute extends MizerRoute {}

class SessionRoute extends MizerRoute {}

class MidiProfilesRoute extends MizerRoute {}

class FixtureLibraryRoute extends MizerRoute {}

class PreferencesRoute extends MizerRoute {}

class HeaderTarget {
  final String title;
  final MizerRoute route;

  HeaderTarget({required this.title, required this.route});
}

class NavigationState {
  final MizerRoute currentRoute;
  final List<View> sidebar;
  final List<HeaderTarget> header;

  NavigationState({
    required this.currentRoute,
    required this.sidebar,
    required this.header,
  });

  factory NavigationState.empty() {
    return NavigationState(
      currentRoute: MizerRoute(),
      sidebar: [],
      header: [],
    );
  }

  bool isActive(View view) {
    int index = this.sidebar.indexOf(view);

    if (!(currentRoute is MizerViewRoute)) {
      return false;
    }

    return (currentRoute as MizerViewRoute).index == index;
  }
}

class NavigationBloc extends Cubit<NavigationState> {
  final UiApi api;

  NavigationBloc(this.api) : super(NavigationState.empty()) {
    emit(NavigationState(
      currentRoute: MizerRoute(),
      sidebar: [],
      header: [
        HeaderTarget(title: 'Patch'.i18n, route: PatchRoute()),
        HeaderTarget(title: 'Connections'.i18n, route: ConnectionsRoute()),
        HeaderTarget(title: 'DMX Output'.i18n, route: DmxRoute()),
        HeaderTarget(title: 'History'.i18n, route: HistoryRoute()),
        HeaderTarget(title: 'Session'.i18n, route: SessionRoute()),
        HeaderTarget(title: 'MIDI Profiles'.i18n, route: MidiProfilesRoute()),
        HeaderTarget(title: 'Fixture Library'.i18n, route: FixtureLibraryRoute()),
      ],
    ));
    this.fetch();
  }

  fetch() async {
    var views = await this.api.getViews();
    emit(NavigationState(currentRoute: state.currentRoute, sidebar: views, header: state.header));
  }

  navigate(MizerRoute route) {
    emit(NavigationState(currentRoute: route, sidebar: state.sidebar, header: state.header));
  }
}

extension NavigationExt on BuildContext {
  navigate(MizerRoute route) {
    final bloc = read<NavigationBloc>();
    bloc.navigate(route);
  }

  openView(View view) {
    final bloc = read<NavigationBloc>();
    bloc.navigate(MizerViewRoute(index: bloc.state.sidebar.indexOf(view)));
  }
}
