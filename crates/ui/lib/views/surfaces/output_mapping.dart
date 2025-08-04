import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/surfaces_bloc.dart';

import 'package:mizer/views/surfaces/mapping.dart';

class OutputMapping extends StatelessWidget {
  const OutputMapping({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurfacesCubit, SurfacesState>(
      builder: (context, state) => state.selectedSection == null
          ? Container()
          : AspectRatio(
              aspectRatio: 16 / 9,
              child: MappingDrawer(state.selectedSection!.output, onChange: (transform) {
                context.read<SurfacesCubit>().changeOutputTransform(transform);
              }, onConfirm: () {
                context.read<SurfacesCubit>().confirmOutputTransform();
              })),
    );
  }
}
