import 'package:mizer/protos/media.pb.dart';

abstract class MediaApi {
  Stream<MediaFiles> watchMedia();

  Future<void> createTag(String name);
  Future<void> removeTag(String tagId);

  Future<MediaFiles> getMedia();
  Future<void> importMedia(List<String> files);
  Future<void> removeMedia(String mediaId);

  Future<void> addTagToMedia(String mediaId, String tagId);
  Future<void> removeTagFromMedia(String mediaId, String tagId);

  Future<List<String>> getMediaFolders();
  Future<void> addMediaFolder(String folder);
  Future<void> removeMediaFolder(String folder);
}
