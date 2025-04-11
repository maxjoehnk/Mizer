import 'package:mizer/protos/ports.pb.dart';

abstract class PortsApi {
  Future<List<NodePort>> getPorts();

  Future<NodePort> addPort({ String? name });

  Future<void> deletePort(int id);
}
