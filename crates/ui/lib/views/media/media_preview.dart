import 'package:flutter/widgets.dart';
import 'package:mizer/protos/media.pb.dart';

class MediaPreview extends StatelessWidget {
  final MediaFile file;

  const MediaPreview({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (file.type == MediaType.IMAGE) {
      return Image.network(this.file.contentUrl);
    }

    return Image.network(file.thumbnailUrl);
  }
}
