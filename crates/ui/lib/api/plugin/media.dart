import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/protos/media.pb.dart';

class MediaPluginApi implements MediaApi {
  final MethodChannel channel = const MethodChannel("mizer.live/media");
  final EventChannel events = const EventChannel("mizer.live/media/watch");

  @override
  Stream<MediaFiles> watchMedia() {
    return events.receiveBroadcastStream().map((buffer) {
      return MediaFiles.fromBuffer(_convertBuffer(buffer));
    });
  }

  @override
  Future<void> createTag(String name) async {
    await channel.invokeMethod("createTag", name);
  }

  @override
  Future<void> removeTag(String tagId) async {
    await channel.invokeMethod("removeTag", tagId);
  }

  @override
  Future<MediaFiles> getMedia() async {
    var response = await channel.invokeMethod("getMedia");

    return MediaFiles.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> importMedia(List<String> files) async {
    await channel.invokeMethod("importMedia", files);
  }

  @override
  Future<void> removeMedia(String mediaId) async {
    await channel.invokeMethod("removeMedia", mediaId);
  }

  @override
  Future<List<String>> getMediaFolders() async {
    var folders = await channel.invokeListMethod<String>("getFolders");

    return folders ?? [];
  }

  @override
  Future<void> addMediaFolder(String folder) async {
    await channel.invokeMethod("addFolder", folder);
  }

  @override
  Future<void> removeMediaFolder(String folder) async {
    await channel.invokeMethod("removeFolder", folder);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<void> addTagToMedia(String mediaId, String tagId) async {
    var request = AddTagToMediaRequest(mediaId: mediaId, tagId: tagId);
    await channel.invokeMethod("addTagToMedia", request.writeToBuffer());
  }

  @override
  Future<void> removeTagFromMedia(String mediaId, String tagId) async {
    var request = RemoveTagFromMediaRequest(mediaId: mediaId, tagId: tagId);
    await channel.invokeMethod("removeTagFromMedia", request.writeToBuffer());
  }

  @override
  Future<void> relinkMedia(String mediaId, String path) {
    var request = RelinkMediaRequest(mediaId: mediaId, path: path);
    return channel.invokeMethod("relinkMedia", request.writeToBuffer());
  }
}
