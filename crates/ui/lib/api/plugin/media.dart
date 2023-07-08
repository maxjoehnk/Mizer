import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/protos/media.pb.dart';

class MediaPluginApi implements MediaApi {
  final MethodChannel channel = const MethodChannel("mizer.live/media");

  @override
  Future<MediaTag> createTag(String name) async {
    var response = await channel.invokeMethod("createTag", name);

    return MediaTag.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<MediaFiles> getMedia() async {
    var response = await channel.invokeMethod("getMedia");

    return MediaFiles.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<GroupedMediaFiles> getTagsWithMedia() async {
    var response = await channel.invokeMethod("getTagsWithMedia");

    return GroupedMediaFiles.fromBuffer(_convertBuffer(response));
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
}
