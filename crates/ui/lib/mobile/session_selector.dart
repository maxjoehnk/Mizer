import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/mobile/dialogs/direct_connect.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
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
        backgroundColor: Grey800,
        shadowColor: Colors.transparent,
        title: Text('Mizer'),
      ),
      body: Panel(
        label: "Connect to Session",
        actions: [
          PanelActionModel(
            label: "Refresh",
            onClick: () => _refresh(),
          ),
          PanelActionModel(
            label: "Direct Connect",
            onClick: () async {
            Session? session = await showDialog(context: context, builder: (context) => DirectConnectDialog());
            if (session != null) {
              setState(() {
                _session = session;
              });
            }
          }),
        ],
        child: MizerTable(rows: [
          for (final session in _sessions)
            MizerTableRow(
              cells: [
                Text(session.project ?? ""),
                Text("${session.host.name} (${session.host.host})"),
              ],
              onTap: () => setState(() {
                  _session = session;
                })
            )
        ], columns: [Text("Project"), Text("Host")]),
      ),
    );
  }

  void _refresh() {
    setState(() {
      _sessions.clear();
    });
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
            var ipv4 = addresses.where((a) => a.type == InternetAddressType.IPv4).firstOrNull;
            var ipv6 = addresses.where((a) => a.type == InternetAddressType.IPv6).firstOrNull;
            var ipAddress = ipv4 ?? ipv6 ?? addresses.first;

            return Host(
                value.target,
                ipAddress.address,
                value.port);
          });
        });

        Future<String> project = _mdns
            .lookup<TxtResourceRecord>(ResourceRecordQuery.text(ptr.domainName))
            .first
            .then((value) {
              var path = value.text.replaceFirst("project=", "").trim();

              return path.split("/").last.replaceAll(".yml", "");
        });

        return Future.wait([host, project]);
      }).forEach((values) {
        var host = values[0] as Host;
        var project = values[1] as String;
        var session = Session(host, project: project);
        setState(() {
          var match = _sessions.indexWhere((s) => s.project == session.project);
          if (match != -1) {
            _sessions[match] = session;
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
