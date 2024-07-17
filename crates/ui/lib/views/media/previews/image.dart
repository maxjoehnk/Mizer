import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/widgets/transparent_background.dart';

class ImagePreview extends StatelessWidget {
  final MediaFile file;

  const ImagePreview({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Stack(
        children: [
          TransparentBackground(),
          Center(child: Image.file(File(this.file.filePath))),
        ],
      ),
      maxScale: 10,
    );
  }
}
