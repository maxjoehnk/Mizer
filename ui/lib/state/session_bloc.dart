import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionBloc extends Bloc<Session, Session> {
  final SessionApi api;
  StreamSubscription? subscription;

  SessionBloc(this.api) : super(Session.create()) {
    on<Session>((event, emit) => emit(event));
    this.subscription = api.watchSession().listen((value) => this.add(value));
  }

  @override
  Future<void> close() {
    this.subscription!.cancel();
    return super.close();
  }
}
