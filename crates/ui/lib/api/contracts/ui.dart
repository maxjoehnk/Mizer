import 'package:mizer/protos/ui.pb.dart';

abstract class UiApi {
  Stream<ShowDialog> dialogRequests();

  Future<TabularData> showTable(String table, List<String> arguments);

  Future<void> commandLineExecute(String command);

  Future<List<View>> getViews();
}
