import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:multicast_dns/multicast_dns.dart';

var client = MDnsClient();

class SessionDiscovery {
  final MDnsClient client = MDnsClient();

  Future start() async {
    await client.start();
  }

  Stream<AvailableSession> discover() {
    return client
        .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer("_mizer._tcp"), timeout: Duration(days: 1))
        .asyncMap(this._queryPointer);
  }

  Future<AvailableSession> _queryPointer(PtrResourceRecord record) async {
    SrvResourceRecord serviceRecord = await client
        .lookup<SrvResourceRecord>(ResourceRecordQuery.service(record.domainName))
        .first;
    TxtResourceRecord textRecord =
        await client.lookup<TxtResourceRecord>(ResourceRecordQuery.text(record.domainName)).first;
    // TODO: check key for project
    var txtRecord = textRecord.text.split("=");
    var value = txtRecord[1];

    return AvailableSession(host: serviceRecord.target, port: serviceRecord.port, project: value);
  }
}

class AvailableSession {
  final String host;
  final int port;
  final String? project;

  AvailableSession({required this.host, required this.port, this.project});

  @override
  String toString() {
    return "AvailableSession{host: $host, port: $port, project: $project}";
  }

  ClientChannel openChannel() {
    return ClientChannel(
      this.host,
      port: this.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }
}

abstract class SessionDiscoveryEvent {}

class SessionDiscoveryBloc extends Bloc<AvailableSession, List<AvailableSession>> {
  late StreamSubscription subscription;

  SessionDiscoveryBloc(SessionDiscovery discovery) : super([]) {
    this.subscription = discovery.discover().listen(this.add);
  }

  @override
  Future<void> close() async {
    await this.subscription.cancel();
    return super.close();
  }

  @override
  Stream<List<AvailableSession>> mapEventToState(event) async* {
    var existingIndex = state.indexWhere((element) => element.host == event.host);
    if (existingIndex == -1) {
      yield [...this.state, event];
    } else {
      var next = [...this.state];
      next[existingIndex] = event;
      yield next;
    }
  }
}
