import 'package:mizer/protos/ui.pb.dart';

abstract class UiApi {
  Stream<ShowDialog> dialogRequests();
}