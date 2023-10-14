import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/surfaces_bloc.dart';
import 'package:mizer/widgets/list_item.dart';
import 'package:mizer/widgets/panel.dart';

class SurfaceList extends StatelessWidget {
  const SurfaceList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurfacesCubit, SurfacesState>(
      builder: (context, state) {
        return Panel(
          label: 'Surfaces'.i18n,
          child: ListView(
            children: state.surfaces
                .map((surface) => ListItem(
                      child: Text(surface.name),
                      selected: surface.id == state.selectedSurfaceId,
                      onTap: () => context.read<SurfacesCubit>().selectSurface(surface.id),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
