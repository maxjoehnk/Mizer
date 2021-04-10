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
    var response = await  channel.invokeMethod("getTagsWithMedia");

    return GroupedMediaFiles.fromBuffer(_convertBuffer(response));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}
