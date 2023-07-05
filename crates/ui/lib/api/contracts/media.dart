import 'package:mizer/protos/media.pb.dart';

abstract class MediaApi {
  Future<MediaTag> createTag(String name);

  Future<GroupedMediaFiles> getTagsWithMedia();

  Future<MediaFiles> getMedia();

  Future<void> importMedia(List<String> files);

  Future<void> removeMedia(String mediaId);

  Future<List<String>> getMediaFolders();

  Future<void> addMediaFolder(String folder);

  Future<void> removeMediaFolder(String folder);
}
