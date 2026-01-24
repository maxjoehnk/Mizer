import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/surfaces.pb.dart';
import 'package:mizer/state/surfaces_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/number_field.dart';
import 'package:mizer/views/nodes/widgets/properties/groups/property_group.dart';
import 'package:mizer/widgets/panel.dart';

class SectionSettings extends StatelessWidget {
  const SectionSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurfacesCubit, SurfacesState>(
      builder: (context, state) {
        return Panel(
          label: 'Settings ({name})'.i18n.args({ "name": state.selectedSection?.name ?? "" }),
          child: Padding(
            padding: const EdgeInsets.all(PANEL_GAP_SIZE),
            child: Column(
              children: state.selectedSection == null
                  ? []
                  : [
                      MappingSettings(
                          title: "Input".i18n,
                          transform: state.selectedSection!.input,
                          onChange: (transform) {
                            context.read<SurfacesCubit>().changeInputTransform(transform);
                          }),
                      MappingSettings(
                          title: "Output".i18n,
                          transform: state.selectedSection!.output,
                          onChange: (transform) {
                            context.read<SurfacesCubit>().changeOutputTransform(transform);
                          }),
                    ],
            ),
          ),
        );
      },
    );
  }
}

class MappingSettings extends StatelessWidget {
  final String title;
  final SurfaceTransform transform;
  final Function(SurfaceTransform) onChange;

  MappingSettings(
      {super.key, required this.title, required this.transform, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: title, children: [
      Text("Top Left".i18n),
      Point(
          point: transform.topLeft,
          onUpdateX: (value) =>
              _update(topLeft: SurfaceTransformPoint(x: value, y: transform.topLeft.y)),
          onUpdateY: (value) =>
              _update(topLeft: SurfaceTransformPoint(y: value, x: transform.topLeft.x))),
      Text("Top Right".i18n),
      Point(
          point: transform.topRight,
          onUpdateX: (value) {
            _update(topRight: SurfaceTransformPoint(x: value, y: transform.topRight.y));
          },
          onUpdateY: (value) {
            _update(topRight: SurfaceTransformPoint(y: value, x: transform.topRight.x));
          }),
      Text("Bottom Left".i18n),
      Point(
          point: transform.bottomLeft,
          onUpdateX: (value) {
            _update(bottomLeft: SurfaceTransformPoint(x: value, y: transform.bottomLeft.y));
          },
          onUpdateY: (value) {
            _update(bottomLeft: SurfaceTransformPoint(y: value, x: transform.bottomLeft.x));
          }),
      Text("Bottom Right".i18n),
      Point(
          point: transform.bottomRight,
          onUpdateX: (value) {
            _update(bottomRight: SurfaceTransformPoint(x: value, y: transform.bottomRight.y));
          },
          onUpdateY: (value) {
            _update(bottomRight: SurfaceTransformPoint(y: value, x: transform.bottomRight.x));
          }),
    ]);
  }

  _update(
      {SurfaceTransformPoint? topLeft,
      SurfaceTransformPoint? topRight,
      SurfaceTransformPoint? bottomLeft,
      SurfaceTransformPoint? bottomRight}) {
    onChange(SurfaceTransform(
        topLeft: topLeft ?? transform.topLeft,
        topRight: topRight ?? transform.topRight,
        bottomLeft: bottomLeft ?? transform.bottomLeft,
        bottomRight: bottomRight ?? transform.bottomRight));
  }
}

class Point extends StatelessWidget {
  final SurfaceTransformPoint point;
  final double width = 1920;
  final double height = 1080;
  final Function(double) onUpdateX;
  final Function(double) onUpdateY;

  const Point({super.key, required this.point, required this.onUpdateX, required this.onUpdateY});

  @override
  Widget build(BuildContext context) {
    double x = point.x * width;
    x = double.parse(x.toStringAsFixed(1));
    double y = point.y * height;
    y = double.parse(y.toStringAsFixed(1));
    return Row(
      spacing: PANEL_GAP_SIZE,
      children: [
        Expanded(
          child: NumberField(
              label: "X",
              labelWidth: 40,
              value: x,
              min: 0.0,
              max: width,
              step: 0.1,
              fractions: true,
              changeDetection: NumberFieldChangeDetection.Value,
              onUpdate: (value) => this.onUpdateX(value / width)),
        ),
        Expanded(
          child: NumberField(
              label: "Y",
              labelWidth: 40,
              value: y,
              min: 0.0,
              max: height,
              step: 0.1,
              fractions: true,
              changeDetection: NumberFieldChangeDetection.Value,
              onUpdate: (value) => this.onUpdateY(value / height)),
        ),
      ],
    );
  }
}
