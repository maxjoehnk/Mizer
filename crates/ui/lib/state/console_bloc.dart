import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/console.dart';
import 'package:mizer/protos/console.pb.dart';

class ConsoleState {
  final List<ConsoleMessage> messages;

  ConsoleState(this.messages);

  ConsoleState appendMessage(ConsoleMessage message) {
    return ConsoleState([...messages, message]);
  }
}

class ConsoleCubit extends Cubit<ConsoleState> {
  ConsoleCubit(ConsoleApi api) : super(ConsoleState([])) {
    api.getHistory().then((msgs) => emit(ConsoleState(msgs)));
    api.stream().listen((msg) => emit(state.appendMessage(msg)));
  }
}
