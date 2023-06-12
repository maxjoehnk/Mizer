import 'dart:math';

import 'package:flutter/material.dart' hide ResizeImage;
import 'package:flutter/services.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:provider/provider.dart';

const double fieldSize = 24;

class PlansImageLayer extends StatefulWidget {
  final Plan plan;
  final bool isSetup;
  final Matrix4 transformation;

  const PlansImageLayer(
      {required this.plan, required this.isSetup, required this.transformation, Key? key})
      : super(key: key);

  @override
  State<PlansImageLayer> createState() => _PlansImageLayerState();
}

class _PlansImageLayerState extends State<PlansImageLayer> {
  List<_LoadedImage> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.plan.images.map((i) => _LoadedImage(i)).toList();
  }

  @override
  void didUpdateWidget(PlansImageLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.plan.images == oldWidget.plan.images) {
      return;
    }
    images = widget.plan.images.map((i) => _LoadedImage(i)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
        delegate: PlanImageLayoutDelegate(images, widget.transformation), children: _images);
  }

  List<Widget> get _images {
    return images
        .map((i) => LayoutId(
            id: "image-${i.planImage.id}",
            child: PlanImageEditor(
                image: i,
                transformation: widget.transformation,
                setup: widget.isSetup,
                onMove: (offset) => setState(() {
                      images = images.map((e) {
                        if (e.planImage.id == i.planImage.id) {
                          return e.move(offset);
                        }
                        return e;
                      }).toList();
                    }),
                onResize: (size) => setState(() {
                      images = images.map((e) {
                        if (e.planImage.id == i.planImage.id) {
                          return e.resize(size);
                        }
                        return e;
                      }).toList();
                    }))))
        .toList();
  }
}

class PlanImageEditor extends StatefulWidget {
  final _LoadedImage image;
  final bool setup;
  final Function(Offset) onMove;
  final Function(Size) onResize;
  final Matrix4 transformation;

  const PlanImageEditor(
      {required this.image,
      required this.setup,
      required this.onMove,
      required this.onResize,
      required this.transformation,
      super.key});

  @override
  State<PlanImageEditor> createState() => _PlanImageEditorState();
}

class _PlanImageEditorState extends State<PlanImageEditor> {
  bool hovering = false;
  Offset? movingOffset;

  @override
  Widget build(BuildContext context) {
    if (widget.setup) {
      return _editMode();
    }
    return _image();
  }

  Widget _editMode() {
    return ResizeAnnotations(
      image: widget.image,
      onResize: widget.onResize,
      transformation: widget.transformation,
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        cursor: SystemMouseCursors.move,
        onEnter: (e) {
          setState(() => hovering = true);
        },
        onExit: (e) {
          setState(() => hovering = false);
        },
        child: Listener(
          onPointerDown: (e) {
            var planPosition = MatrixUtils.transformPoint(
                Matrix4.inverted(widget.transformation), e.localPosition);
            setState(() => movingOffset = planPosition - widget.image.position);
          },
          onPointerMove: (e) {
            if (movingOffset == null) {
              return;
            }
            var planPosition = MatrixUtils.transformPoint(
                Matrix4.inverted(widget.transformation), e.localPosition);
            widget.onMove(planPosition - movingOffset!);
          },
          onPointerUp: (e) {
            setState(() => movingOffset = null);
            var bloc = context.read<PlansBloc>();
            bloc.add(MoveImage(
                imageId: widget.image.planImage.id,
                x: widget.image.position.dx,
                y: widget.image.position.dy));
          },
          child: ContextMenu(
            menu: Menu(
              items: [
                MenuItem(
                  label: "Delete",
                  action: () {
                    var bloc = context.read<PlansBloc>();
                    bloc.add(DeleteImage(imageId: widget.image.planImage.id));
                  },
                ),
              ],
            ),
            child: _image(
                child: Placeholder(color: hovering ? Colors.white : Colors.blueGrey.shade700)),
          ),
        ),
      ),
    );
  }

  Widget _image({Widget? child}) {
    return Container(
      foregroundDecoration:
          hovering ? BoxDecoration(border: Border.all(color: Colors.white, width: 1)) : null,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: widget.image.image,
        opacity: widget.image.planImage.transparency,
        fit: BoxFit.fill,
      )),
      child: child,
    );
  }
}

class ResizeAnnotations extends StatefulWidget {
  final Widget child;
  final _LoadedImage image;
  final Matrix4 transformation;
  final Function(Size) onResize;

  const ResizeAnnotations(
      {required this.child,
      required this.image,
      required this.transformation,
      required this.onResize,
      super.key});

  @override
  State<ResizeAnnotations> createState() => _ResizeAnnotationsState();
}

class _ResizeAnnotationsState extends State<ResizeAnnotations> {
  Offset? movingOffset;
  Size? startSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        Positioned(
          bottom: 0,
          right: 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.resizeDownRight,
            child: Listener(
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: 20,
                height: 20,
              ),
              onPointerDown: (e) {
                setState(() {
                  movingOffset = MatrixUtils.transformPoint(
                      Matrix4.inverted(widget.transformation), e.localPosition);
                  startSize = widget.image.size;
                });
              },
              onPointerMove: (e) {
                if (movingOffset == null) {
                  return;
                }
                Size size = _getNewSize(e.localPosition);
                widget.onResize(size);
              },
              onPointerUp: (e) {
                Size size = _getNewSize(e.localPosition);
                var bloc = context.read<PlansBloc>();
                bloc.add(ResizeImage(
                    imageId: widget.image.planImage.id, width: size.width, height: size.height));
                setState(() {
                  movingOffset = null;
                  startSize = null;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Size _getNewSize(Offset localPosition) {
    var planPosition =
        MatrixUtils.transformPoint(Matrix4.inverted(widget.transformation), localPosition);
    var xDiff = movingOffset!.dx - planPosition.dx;
    var yDiff = movingOffset!.dy - planPosition.dy;
    if (RawKeyboard.instance.keysPressed.any((key) => [
          LogicalKeyboardKey.shift,
          LogicalKeyboardKey.shiftLeft,
          LogicalKeyboardKey.shiftRight,
        ].contains(key))) {
      var diff = max(xDiff, yDiff);
      return Size(startSize!.width - diff, startSize!.height - diff);
    } else {
      return Size(startSize!.width - xDiff, startSize!.height - yDiff);
    }
  }
}

class _LoadedImage {
  final MemoryImage image;
  final PlanImage planImage;
  final Offset position;
  final Size size;

  _LoadedImage(this.planImage, {Offset? position, Size? size})
      : image = MemoryImage(Uint8List.fromList(planImage.data)),
        this.position = position ?? Offset(planImage.x, planImage.y),
        this.size = size ?? Size(planImage.width, planImage.height);

  _LoadedImage move(Offset position) {
    return _LoadedImage(
      planImage,
      position: position,
      size: size,
    );
  }

  _LoadedImage resize(Size size) {
    return _LoadedImage(
      planImage,
      position: position,
      size: size,
    );
  }

  Rect screenPosition(Matrix4 transform) {
    Rect rect = Rect.fromLTWH(position.dx, position.dy, size.width, size.height);

    return MatrixUtils.transformRect(transform, rect);
  }
}

class PlanImageLayoutDelegate extends MultiChildLayoutDelegate {
  final List<_LoadedImage> images;
  final Matrix4 transformation;

  PlanImageLayoutDelegate(this.images, this.transformation);

  @override
  void performLayout(Size size) {
    for (var image in images) {
      var imageId = "image-${image.planImage.id}";
      var screenPosition = image.screenPosition(transformation);
      layoutChild(imageId, BoxConstraints.tight(screenPosition.size));
      positionChild(imageId, screenPosition.topLeft);
    }
  }

  @override
  bool shouldRelayout(covariant PlanImageLayoutDelegate oldDelegate) {
    return images != oldDelegate.images || transformation != oldDelegate.transformation;
  }
}
