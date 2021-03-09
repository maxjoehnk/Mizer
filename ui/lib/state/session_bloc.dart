import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/protos/session.pbgrpc.dart';

class SessionBloc extends Bloc<Session, Session> {
  final SessionApiClient client;
  StreamSubscription subscription;

  SessionBloc(ClientChannel channel)
      : client = SessionApiClient(channel),
        super(Session.create()) {
    this.subscription = client.getSession(SessionRequest()).listen((value) => this.add(value));
  }

  @override
  Future<void> close() {
    this.subscription.cancel();
    return super.close();
  }

  @override
  Stream<Session> mapEventToState(Session event) async* {
    yield event;
  }
}
