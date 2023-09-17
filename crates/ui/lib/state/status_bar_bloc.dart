import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class StatusBarState {
  String? message;

  StatusBarState(this.message);

  factory StatusBarState.empty() {
    return StatusBarState(null);
  }

  @override
  String toString() {
    return 'StatusBarState{message: $message}';
  }
}

class StatusBarCubit extends Cubit<StatusBarState> {
  StatusBarCubit() : super(StatusBarState.empty());

  void addMessage(String message) {
    emit(StatusBarState(message));
  }

  void clearMessage() {
    emit(StatusBarState.empty());
  }
}

extension StatusBarExt on BuildContext {
  void addStatus(String message) {
    read<StatusBarCubit>().addMessage(message);
  }

  void clearStatus() {
    read<StatusBarCubit>().clearMessage();
  }
}
