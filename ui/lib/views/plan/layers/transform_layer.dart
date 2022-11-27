import 'package:flutter/material.dart';

class TransformLayer extends StatelessWidget {
  final TransformationController transformationController;

  const TransformLayer({required this.transformationController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: InteractiveViewer(
            transformationController: transformationController,
            minScale: 0.1,
            maxScale: 5,
            scaleFactor: 500,
            boundaryMargin: EdgeInsets.all(double.infinity),
            child: SizedBox.expand()));
  }
}
