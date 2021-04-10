import 'package:mizer/protos/media.pb.dart';

abstract class MediaApi {
  Future<MediaTag> createTag(String name);

  Future<GroupedMediaFiles> getTagsWithMedia();

  Future<MediaFiles> getMedia();
}
