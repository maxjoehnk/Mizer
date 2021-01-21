import 'package:bloc/bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/protos/nodes.pbgrpc.dart';

enum NodesEvent { Fetch }

class NodesBloc extends Bloc<NodesEvent, Nodes> {
  final NodesApiClient client;

  NodesBloc(ClientChannel channel)
      : client = NodesApiClient(channel),
        super(Nodes.create()) {
    this.add(NodesEvent.Fetch);
  }

  @override
  Stream<Nodes> mapEventToState(NodesEvent event) async* {
    switch (event) {
      case NodesEvent.Fetch:
        yield await client.getNodes(NodesRequest());
        break;
    }
  }
}
