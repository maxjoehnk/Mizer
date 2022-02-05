import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/protos/effects.pbgrpc.dart';

class EffectsGrpcApi implements EffectsApi {
  final EffectsApiClient client;

  EffectsGrpcApi(ClientChannel channel) : client = EffectsApiClient(channel);

  @override
  Future<List<Effect>> getEffects() async {
    var response = await this.client.getEffects(GetEffectsRequest());

    return response.effects;
  }
}
