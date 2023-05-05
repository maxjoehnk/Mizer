import 'package:mizer/protos/mappings.pb.dart';

abstract class MappingsApi {
  Future<void> addMapping(MappingRequest request);
}
