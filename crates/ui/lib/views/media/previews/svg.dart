import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mizer/protos/media.pb.dart';
import 'package:mizer/widgets/transparent_background.dart';

class SvgPreview extends StatelessWidget {
  final MediaFile file;

  const SvgPreview({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Stack(
        children: [
          TransparentBackground(),
          Center(child: SvgPicture.file(File(this.file.metadata.sourcePath))),
        ],
      ),
      maxScale: 10,
    );
  }
}
