import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/protos/session.pb.dart';

class SessionBloc extends Bloc<SessionState, SessionState> {
  final SessionApi api;
  StreamSubscription? subscription;

  SessionBloc(this.api) : super(SessionState.create()) {
    on<SessionState>((event, emit) => emit(event));
    this.subscription = api.watchSession().listen((value) => this.add(value));
  }

  @override
  Future<void> close() {
    this.subscription!.cancel();
    return super.close();
  }
}
