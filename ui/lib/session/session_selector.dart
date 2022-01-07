import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/session/session_discovery.dart';
import 'package:mizer/session/title_screen.dart';

class SessionProvider extends StatelessWidget {
  final SessionDiscovery discovery;
  final Widget Function(ClientChannel) builder;

  SessionProvider(this.discovery, {required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (create) => SessionDiscoveryBloc(discovery), child: SessionSelector(this.builder));
  }
}

class SessionSelector extends StatefulWidget {
  final Widget Function(ClientChannel) builder;

  SessionSelector(this.builder);

  @override
  _SessionSelectorState createState() => _SessionSelectorState();
}

class _SessionSelectorState extends State<SessionSelector> {
  AvailableSession? selectedSession;

  @override
  Widget build(BuildContext context) {
     if (this.selectedSession != null) {
      return this.widget.builder(this.selectedSession!.openChannel());
    } else {
      return TitleScreen(
          selectSession: (session) => setState(() {
                this.selectedSession = session;
              }));
    }
  }
}
