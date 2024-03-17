import 'package:flutter/widgets.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPreview extends StatefulWidget {
  final String sourcePath;

  const VideoPreview({super.key, required this.sourcePath});

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    player.open(Media("file://${widget.sourcePath}"));
  }

  @override
  Widget build(BuildContext context) {
    return Video(controller: controller);
  }
}
