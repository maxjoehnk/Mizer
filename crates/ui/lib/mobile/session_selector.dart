import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multicast_dns/multicast_dns.dart';

class SessionSelector extends StatefulWidget {
  final Function(BuildContext, Session) builder;

  const SessionSelector({required this.builder});

  @override
  State<SessionSelector> createState() => _SessionSelectorState();
}

class _SessionSelectorState extends State<SessionSelector> {
  final MDnsClient _mdns = MDnsClient();
  final List<Session> _sessions = [];
  Session? _session;

  @override
  void initState() {
    super.initState();
    _mdns.start().then((value) {
      print("Starting mdns lookup");
      return _mdns
          .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer("_mizer._tcp"))
          .asyncMap((ptr) {
        print("Found $ptr");
        // var ip = _mdns
        //     .lookup<IPAddressResourceRecord>(ResourceRecordQuery.addressIPv4(ptr.domainName))
        //     .first
        //     .then((value) {
        //   print("ip: $value");
        //
        //   return value;
        // });
        var host = _mdns
            .lookup<SrvResourceRecord>(ResourceRecordQuery.service(ptr.domainName))
            .first
            .then((value) {
          print("port: $value");
          return InternetAddress.lookup(value.target).then((addresses) {
            print("addresses: $addresses");

            return Host(value.target, addresses.first, value.port);
          });
        });

        var project = _mdns
            .lookup<TxtResourceRecord>(ResourceRecordQuery.text(ptr.domainName))
            .first
            .then((value) {
          print("project: $value");

          return value;
        });

        return Future.wait([host, project]);
      }).forEach((values) {
        var host = values[0] as Host;
        var project = values[1] as TxtResourceRecord;
        var session = Session(project.text, host);
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

  @override
  void dispose() {
    _mdns.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_session != null) {
      return widget.builder(context, _session!);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Session'),
      ),
      body: ListView(
        children: _sessions.map((session) {
          return ListTile(
            title: Text(session.host.name),
            subtitle: Text(session.project),
            onTap: () {
              setState(() {
                _session = session;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}

class Session {
  final String project;
  final Host host;

  Session(this.project, this.host);

  @override
  String toString() {
    return 'Session{project: ${project.trim()}, host: $host}';
  }
}

class Host {
  final String name;
  final InternetAddress host;
  final int port;

  Host(this.name, this.host, this.port);

  @override
  String toString() {
    return 'Host{name: $name, host: $host, port: $port}';
  }
}
