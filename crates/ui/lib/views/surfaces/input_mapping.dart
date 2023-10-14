import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/surfaces_bloc.dart';

import 'mapping.dart';

class InputMapping extends StatelessWidget {
  const InputMapping({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurfacesCubit, SurfacesState>(
      builder: (context, state) => state.selectedSection == null
          ? Container()
          : AspectRatio(
              aspectRatio: 16 / 9,
              child: MappingDrawer(state.selectedSection!.input, onChange: (transform) {
                context.read<SurfacesCubit>().changeInputTransform(transform);
              }, onConfirm: () {
                context.read<SurfacesCubit>().confirmInputTransform();
              })),
    );
  }
}
