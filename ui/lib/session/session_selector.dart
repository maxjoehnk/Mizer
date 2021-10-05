import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/session/session_discovery.dart';
import 'package:mizer/session/title_screen.dart';

class SessionProvider extends StatelessWidget {
  final SessionDiscovery discovery;
  final Widget Function(ClientChannel) builder;
  final Widget Function() demo;

  SessionProvider(this.discovery, {required this.builder, required this.demo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (create) => SessionDiscoveryBloc(discovery), child: SessionSelector(this.builder, this.demo));
  }
}

class SessionSelector extends StatefulWidget {
  final Widget Function(ClientChannel) builder;
  final Widget Function() demo;

  SessionSelector(this.builder, this.demo);

  @override
  _SessionSelectorState createState() => _SessionSelectorState();
}

class _SessionSelectorState extends State<SessionSelector> {
  AvailableSession? selectedSession;
  bool runDemo = false;

  @override
  Widget build(BuildContext context) {
    if (this.runDemo) {
      return this.widget.demo();
    }else if (this.selectedSession != null) {
      return this.widget.builder(this.selectedSession!.openChannel());
    } else {
      return TitleScreen(
          selectSession: (session) => setState(() {
                this.selectedSession = session;
              }),
      openDemo: () => setState(() => runDemo = true));
    }
  }
}
