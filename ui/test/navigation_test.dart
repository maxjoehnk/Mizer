// @dart=2.11
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
import 'package:mizer/views/programmer/programmer_view.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/media/media_view.dart';
import 'package:mizer/views/nodes/nodes_view.dart';
import 'package:mizer/views/session/session_view.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('Navigation', () {
    testWidgets('Default Route', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Home()));

      expect(find.byType(LayoutView), findsOneWidget);
    }, skip: true);

    testNavigation('Nodes', Icons.account_tree_outlined, FetchNodesView,
        bloc: (_) {
      NodesBloc bloc = MockNodesBloc();
      when(bloc.state).thenReturn(Nodes());

      return bloc;
    });
    testNavigation('Programmer', MdiIcons.tuneVertical, ProgrammerView, bloc: (_) {
      FixturesBloc bloc = MockFixturesBloc();
      when(bloc.state).thenReturn(Fixtures());

      return bloc;
    });
    testNavigation('Media', Icons.perm_media_outlined, MediaView, bloc: (_) {
      MediaBloc bloc = MockMediaBloc();
      when(bloc.state).thenReturn(MediaFiles());

      return bloc;
    });
    testNavigation('Connections', Icons.device_hub, ConnectionsView);
    testNavigation('Session', Icons.mediation, SessionView, bloc: (_) {
      SessionBloc bloc = MockSessionBloc();
      when(bloc.state).thenReturn(Session());

      return bloc;
    });
  }, skip: "Injection of bloc and rendering of navigation bar is borked in tests");
}

void testNavigation<T extends Bloc<E, S>, E, S>(
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
  }, skip: true);
}

class MockNodesBloc extends MockBloc<NodesEvent, Nodes> implements NodesBloc {}

class MockFixturesBloc extends MockBloc<FixturesEvent, Fixtures> implements FixturesBloc {}

class MockMediaBloc extends MockBloc<MediaEvent, MediaFiles> implements MediaBloc {}

class MockSessionBloc extends MockBloc<Session, Session> implements SessionBloc {}
