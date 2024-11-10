import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mizer/mobile/dialogs/direct_connect.dart';
import 'package:multicast_dns/multicast_dns.dart';

class SessionSelector extends StatefulWidget {
  final Function(BuildContext, SessionContext) builder;

  const SessionSelector({required this.builder});

  @override
  State<SessionSelector> createState() => _SessionSelectorState();
}

class SessionContext {
  final Session session;
  final Function() disconnect;

  SessionContext(this.session, this.disconnect);
}

class _SessionSelectorState extends State<SessionSelector> {
  final MDnsClient _mdns = MDnsClient();
  final List<Session> _sessions = [];
  Session? _session;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    _mdns.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_session != null) {
      SessionContext sessionContext = SessionContext(_session!, () {
        setState(() {
          _session = null;
        });
      });
      return widget.builder(context, sessionContext);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Session'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refresh(),
          ),
        ],
      ),
      body: ListView(children: [
        for (final session in _sessions)
          ListTile(
            title: Text(session.project ?? ""),
            isThreeLine: true,
            subtitle: Text("${session.host.name}\n${session.host.host}"),
            onTap: () {
              setState(() {
                _session = session;
              });
            },
          ),
        SizedBox(height: 16),
        TextButton(onPressed: () async {
          Session? session = await showDialog(context: context, builder: (context) => DirectConnectDialog());
          if (session != null) {
            setState(() {
              _session = session;
            });
          }
        }, child: Text("Direct Connect"))
      ]),
    );
  }

  void _refresh() {
    _mdns.stop();
    _mdns.start().then((value) {
      log("Starting mdns lookup");
      return _mdns
          .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer("_mizer._tcp"))
          .asyncMap((ptr) {
        var host = _mdns
            .lookup<SrvResourceRecord>(ResourceRecordQuery.service(ptr.domainName))
            .first
            .then((value) {
          return InternetAddress.lookup(value.target).then((addresses) {

            return Host(value.target, addresses.first.address, value.port);
          });
        });

        var project = _mdns
            .lookup<TxtResourceRecord>(ResourceRecordQuery.text(ptr.domainName))
            .first
            .then((value) {

          return value;
        });

        return Future.wait([host, project]);
      }).forEach((values) {
        var host = values[0] as Host;
        var project = values[1] as TxtResourceRecord;
        var projectName = project.text.replaceFirst("project=", "").trim();
        var session = Session(host, project: projectName);
        setState(() {
          if (_sessions.any((s) => s.project == session.project)) {
            return;
          }
          print("Found session $session");
          _sessions.add(session);
        });
      });
    });
  }
}

class Session {
  final String? project;
  final Host host;

  Session(this.host, { this.project });

  @override
  String toString() {
    return 'Session{project: ${project?.trim()}, host: $host}';
  }
}

class Host {
  final String name;
  final String host;
  final int port;

  Host(this.name, this.host, this.port);

  @override
  String toString() {
    return 'Host{name: $name, host: $host, port: $port}';
  }
}
