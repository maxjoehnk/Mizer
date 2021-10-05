// @dart=2.11
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/api/grpc/programmer.dart';
import 'package:mizer/api/grpc/sequencer.dart';

import 'connections.dart';
import 'fixtures.dart';
import 'layouts.dart';
import 'media.dart';
import 'nodes.dart';
import 'session.dart';
import 'transport.dart';

class GrpcApiProvider extends StatelessWidget {
  final ClientChannel _channel;
  final Widget child;

  GrpcApiProvider(this._channel, {@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: child,
      providers: [
        RepositoryProvider<SessionApi>(create: (context) => SessionGrpcApi(_channel)),
        RepositoryProvider<MediaApi>(create: (context) => MediaGrpcApi(_channel)),
        RepositoryProvider<NodesApi>(create: (context) => NodesGrpcApi(_channel)),
        RepositoryProvider<LayoutsApi>(create: (context) => LayoutsGrpcApi(_channel)),
        RepositoryProvider<FixturesApi>(create: (context) => FixturesGrpcApi(_channel)),
        RepositoryProvider<TransportApi>(create: (context) => TransportGrpcApi(_channel)),
        RepositoryProvider<ConnectionsApi>(create: (context) => ConnectionsGrpcApi(_channel)),
        RepositoryProvider<SequencerApi>(create: (context) => SequencerGrpcApi(_channel)),
        RepositoryProvider<ProgrammerApi>(create: (context) => ProgrammerGrpcApi(_channel)),
      ],
    );
  }
}
