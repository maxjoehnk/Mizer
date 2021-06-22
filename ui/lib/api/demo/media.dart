import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/protos/media.pb.dart';

class MediaDemoApi implements MediaApi {
  @override
  Future<MediaTag> createTag(String name) {
    // TODO: implement createTag
    throw UnimplementedError();
  }

  @override
  Future<MediaFiles> getMedia() async {
    return MediaFiles();
  }

  @override
  Future<GroupedMediaFiles> getTagsWithMedia() async {
    return GroupedMediaFiles();
  }

}
