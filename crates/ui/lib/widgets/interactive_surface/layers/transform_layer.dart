import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mizer/views/nodes/consts.dart';

class TransformLayer extends StatelessWidget {
  final TransformationController transformationController;
  final double minScale;
  final double maxScale;
  final double? scaleFactor;

  const TransformLayer({required this.transformationController, Key? key, this.minScale = MIN_ZOOM, this.maxScale = MAX_ZOOM, this.scaleFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: InteractiveViewer(
            transformationController: transformationController,
            minScale: minScale,
            maxScale: maxScale,
            scaleFactor: scaleFactor ?? kDefaultMouseScrollToScaleFactor,
            boundaryMargin: EdgeInsets.all(double.infinity),
            child: SizedBox.expand()));
  }
}
