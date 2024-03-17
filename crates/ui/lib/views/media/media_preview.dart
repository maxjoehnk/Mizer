import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:mizer/protos/media.pb.dart';

import 'previews/image.dart';
import 'previews/svg.dart';

import 'video_preview.dart';

class MediaPreview extends StatelessWidget {
  final MediaFile file;

  const MediaPreview({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (file.type == MediaType.IMAGE) {
      return ImagePreview(file: file);
    }

    if (file.type == MediaType.VECTOR) {
      return SvgPreview(file: file);
    }

    if (file.type == MediaType.VIDEO) {
      return VideoPreview(sourcePath: this.file.metadata.sourcePath);
    }

    if (!file.hasThumbnailPath()) {
      return Container();
    }

    return Image.file(File(file.thumbnailPath));
  }
}
