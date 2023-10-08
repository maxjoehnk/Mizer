import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/status.dart';

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
  final StatusApi api;

  StatusBarCubit(this.api) : super(StatusBarState.empty()) {
    api.getStatusMessages().listen((event) {
      emit(StatusBarState(event));
    });
  }
}
