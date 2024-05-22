import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/views/plan/layers/add_screen_layer.dart';
import 'package:mizer/widgets/interactive_surface/interactive_surface.dart';
import 'package:mizer/views/plan/layers/drag_selection_layer.dart';
import 'package:mizer/views/plan/layers/fixtures_layer.dart';
import 'package:mizer/views/plan/layers/image_layer.dart';
import 'package:mizer/views/plan/layers/screens_layer.dart';

const double fieldSize = 24;

class PlanLayout extends StatefulWidget {
  final Plan plan;
  final ProgrammerState? programmerState;
  final bool setupMode;
  final Uint8List? placingImage;
  final bool creatingScreen;
  final Function() cancelPlacing;
  final Function(Offset, Size) placeImage;
  final Function(Rect) onAddScreen;

  const PlanLayout(
      {required this.plan,
      this.programmerState,
      required this.setupMode,
      this.placingImage,
      required this.cancelPlacing,
      required this.placeImage,
      this.creatingScreen = false,
      Key? key, required this.onAddScreen})
      : super(key: key);

  @override
  State<PlanLayout> createState() => _PlanLayoutState();
}

class _PlanLayoutState extends State<PlanLayout> with SingleTickerProviderStateMixin {
  final TransformationController _transformationController = TransformationController();
  FixturesRefPointer? _fixturesPointer;
  SelectionState? _selectionState;

  @override
  void initState() {
    super.initState();
    PlansApi plansApi = context.read();
    plansApi.getFixturesPointer().then((pointer) {
      setState(() {
        _fixturesPointer = pointer;
      });
    });
  }

  @override
  void dispose() {
    _fixturesPointer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fixturesPointer == null) {
      return Container();
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        CanvasBackgroundLayer(_transformationController.value, gridSize: fieldSize,),
        TransformLayer(transformationController: _transformationController, minScale: 0.1, maxScale: 5, scaleFactor: 500),
        if (!widget.creatingScreen)
          PlanDragSelectionLayer(
            plan: widget.plan,
            transformation: _transformationController.value,
            selectionState: _selectionState,
            onUpdateSelection: (selection) => setState(() => _selectionState = selection),
          ),
        if (widget.creatingScreen)
          AddScreenLayer(
            onAddScreen: widget.onAddScreen,
            transformation: _transformationController.value,
            selectionState: _selectionState,
            onUpdateSelection: (selection) => setState(() => _selectionState = selection),
          ),
        PlansImageLayer(
            plan: widget.plan,
            isSetup: widget.setupMode,
            transformation: _transformationController.value),
        Transform(
            transform: _transformationController.value,
            child: PlansScreenLayer(plan: widget.plan)),
        if (widget.placingImage != null)
          ImagePlacer(
              image: widget.placingImage!,
              onPlaced: widget.placeImage,
              onCancel: widget.cancelPlacing),
        Transform(
          transform: _transformationController.value,
          child: PlansFixturesLayer(
            plan: widget.plan,
            setupMode: widget.setupMode,
            fixturesPointer: _fixturesPointer!,
            programmerState: widget.programmerState,
          ),
        ),
        if (_selectionState != null) SelectionIndicator(_selectionState!),
        if (!widget.creatingScreen && _selectionState?.direction != null)
          SelectionDirectionIndicator(_selectionState!.direction!),
      ],
    );
  }
}

Offset _convertFromScreenPosition(Offset offset) {
  return offset / fieldSize;
}

class ImagePlacer extends StatefulWidget {
  final Uint8List image;
  final Function(Offset, Size) onPlaced;
  final Function() onCancel;

  const ImagePlacer({required this.image, required this.onPlaced, required this.onCancel, Key? key})
      : super(key: key);

  @override
  State<ImagePlacer> createState() => _ImagePlacerState();
}

class _ImagePlacerState extends State<ImagePlacer> {
  double x = 0;
  double y = 0;
  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();
    decodeImageFromList(widget.image).then((value) {
      setState(() {
        width = value.width.toDouble();
        height = value.height.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: x,
          top: y,
          width: width,
          height: height,
          child: Image.memory(widget.image),
        ),
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerHover: (event) {
            setState(() {
              x = event.localPosition.dx;
              y = event.localPosition.dy;
            });
          },
          onPointerDown: (event) {
            if (event.buttons == kPrimaryButton) {
              widget.onPlaced(Offset(x, y), Size(width, height));
            }
            if (event.buttons == kSecondaryButton) {
              widget.onCancel();
            }
          },
          child: Container(),
        ),
      ],
    );
  }
}
