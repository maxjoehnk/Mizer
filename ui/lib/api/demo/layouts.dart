import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pb.dart';

class LayoutsDemoApi implements LayoutsApi {
  @override
  Future<Layouts> addLayout(String name) async {
    return Layouts();
  }

  @override
  Future<Layouts> getLayouts() async {
    return Layouts(layouts: [Layout(
      id: "Default"
    )]);
  }
}
