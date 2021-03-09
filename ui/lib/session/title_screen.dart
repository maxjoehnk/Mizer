import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/session/session_discovery.dart';

class TitleScreen extends StatelessWidget {
  final Function(AvailableSession) selectSession;

  TitleScreen({this.selectSession});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Scaffold(
      body: Column(
        children: [
          Text("Mizer", style: textTheme.headline2),
          Row(children: [
            Expanded(child: SessionList(this.selectSession)),
            Expanded(child: CreateSession()),
          ]),
        ],
      ),
    );
  }
}

class CreateSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.add),
            ),
            Text("Create Session")
          ]),
        ),
        onTap: () {});
  }
}

class SessionList extends StatelessWidget {
  final Function(AvailableSession) selectSession;

  SessionList(this.selectSession);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionDiscoveryBloc, List<AvailableSession>>(
        builder: (context, sessions) => Container(
              height: 500,
              child: ListView(
                  children: sessions
                      .map((session) => ListTile(
                          onTap: () => this.selectSession(session),
                          title: Text(session.host),
                          subtitle: Text(session.project)))
                      .toList()),
            ));
  }
}
