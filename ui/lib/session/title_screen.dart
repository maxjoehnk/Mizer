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
            Expanded(
                child: Column(
              children: [
                JoinSession(this.selectSession),
                CreateSession(),
              ],
            )),
          ]),
        ],
      ),
    );
  }
}

class JoinSession extends StatelessWidget {
  final Function(AvailableSession) selectSession;

  JoinSession(this.selectSession);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.link),
            ),
            Text("Join Session")
          ]),
        ),
        onTap: () => showDialog(context: context, builder: (context) => JoinSessionDialog()).then((value) {
          if (value == null) {
            return;
          }
          this.selectSession(value);
        }));
  }
}

class JoinSessionDialog extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();
  final TextEditingController portController = TextEditingController(text: "50051");

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Join Session"),
        actions: [
          ElevatedButton(
              child: Text("Connect"),
              onPressed: () {
                String ip = this.ipController.text;
                int port = int.parse(this.portController.text);
                AvailableSession session = AvailableSession(host: ip, port: port);

                Navigator.of(context).pop(session);
              })
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: "IP"),
                controller: this.ipController),
            TextField(
              keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(labelText: "Port"),
                controller: this.portController),
          ],
        ));
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
