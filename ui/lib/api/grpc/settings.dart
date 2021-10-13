import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/protos/settings.pbgrpc.dart';

class SettingsGrpcApi implements SettingsApi {
  final SettingsApiClient client;

  SettingsGrpcApi(ClientChannel channel) : client = SettingsApiClient(channel);

  @override
  Future<Settings> loadSettings() {
    return client.loadSettings(RequestSettings());
  }
}
