import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/protos/media.pbgrpc.dart';

class MediaGrpcApi implements MediaApi {
  final MediaApiClient client;

  MediaGrpcApi(ClientChannel channel) : client = MediaApiClient(channel);

  @override
  Future<MediaTag> createTag(String name) {
    return this.client.createTag(CreateMediaTag(name: name));
  }

  @override
  Future<MediaFiles> getMedia() {
    return this.client.getMedia(GetMediaRequest());
  }

  @override
  Future<GroupedMediaFiles> getTagsWithMedia() {
    return this.client.getTagsWithMedia(GetMediaTags());
  }
}
