import 'package:mizer/protos/console.pb.dart';

abstract class ConsoleApi {
  Future<List<ConsoleMessage>> getHistory();

  Stream<ConsoleMessage> stream();
}
