import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/protos/media.pbgrpc.dart';
import 'package:mizer/protos/nodes.pbgrpc.dart';
import 'package:mizer/state/media_bloc.dart';

import 'fixtures_bloc.dart';
import 'nodes_bloc.dart';
import 'session_bloc.dart';

class StateProvider extends StatelessWidget {
  final ClientChannel _channel;
  final Widget child;

  StateProvider(this._channel, {@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: MultiBlocProvider(
        child: this.child,
        providers: [
          BlocProvider(create: (context) => NodesBloc(context.read())),
          BlocProvider(create: (context) => SessionBloc(_channel)),
          BlocProvider(create: (context) => FixturesBloc(_channel)),
          BlocProvider(create: (context) => MediaBloc(context.read())),
        ],
      ),
      providers: [
        RepositoryProvider(create: (context) => MediaApiClient(_channel)),
        RepositoryProvider(create: (context) => NodesApiClient(_channel)),
      ],
    );
  }
}
