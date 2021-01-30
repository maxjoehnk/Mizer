import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/navigation.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/views/connections/connections_view.dart';
import 'package:mizer/views/fixtures/fixtures_view.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/media/media_view.dart';
import 'package:mizer/views/nodes/nodes_view.dart';
import 'package:mizer/views/session/session_view.dart';
import 'package:mizer/views/settings/settings_view.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('Navigation', () {
    testWidgets('Default Route', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Home()));

      expect(find.byType(LayoutView), findsOneWidget);
    });

    testNavigation('Nodes', Icons.account_tree_outlined, FetchNodesView,
        bloc: (_) {
      NodesBloc bloc = MockNodesBloc();
      when(bloc.state).thenReturn(Nodes());

      return bloc;
    });
    testNavigation('Fixtures', MdiIcons.spotlight, FixturesView, bloc: (_) {
      FixturesBloc bloc = MockFixturesBloc();
      when(bloc.state).thenReturn(Fixtures());

      return bloc;
    });
    testNavigation('Media', Icons.perm_media_outlined, MediaView, bloc: (_) {
      MediaBloc bloc = MockMediaBloc();
      when(bloc.state).thenReturn(GroupedMediaFiles());

      return bloc;
    });
    testNavigation('Connections', Icons.device_hub, ConnectionsView);
    testNavigation('Session', Icons.mediation, SessionView, bloc: (_) {
      SessionBloc bloc = MockSessionBloc();
      when(bloc.state).thenReturn(Session());

      return bloc;
    });
    testNavigation('Settings', Icons.settings, SettingsView);
  });
}

void testNavigation<T extends Cubit<S>, S>(
    String description, IconData icon, Type widgetType,
    {T Function(BuildContext) bloc}) {
  testWidgets(description, (WidgetTester tester) async {
    if (bloc == null) {
      await tester.pumpWidget(MaterialApp(home: Home()));
    } else {
      await tester.pumpWidget(
          BlocProvider<T>(create: bloc, child: MaterialApp(home: Home())));
    }

    await tester.tap(find.byIcon(icon));
    await tester.pump();

    expect(find.byType(widgetType), findsOneWidget);
  });
}

class MockNodesBloc extends MockBloc<Nodes> implements NodesBloc {}

class MockFixturesBloc extends MockBloc<Fixtures> implements FixturesBloc {}

class MockMediaBloc extends MockBloc<GroupedMediaFiles> implements MediaBloc {}

class MockSessionBloc extends MockBloc<Session> implements SessionBloc {}
