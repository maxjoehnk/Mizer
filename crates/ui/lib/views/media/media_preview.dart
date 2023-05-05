import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:mizer/protos/media.pb.dart';

class MediaPreview extends StatelessWidget {
  final MediaFile file;

  const MediaPreview({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (file.type == MediaType.IMAGE) {
      return Image.file(File(this.file.metadata.sourcePath));
    }

    if (!file.hasThumbnailPath()) {
      return Container();
    }

    return Image.file(File(file.thumbnailPath));
  }
}
