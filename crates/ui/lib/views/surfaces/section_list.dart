import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/surfaces_bloc.dart';
import 'package:mizer/widgets/list_item.dart';
import 'package:mizer/widgets/panel.dart';

class SectionList extends StatelessWidget {
  const SectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurfacesCubit, SurfacesState>(
      builder: (context, state) {
        return Panel(
          label: 'Sections',
          child: ListView(
            children: state.selectedSurface?.sections
                    .map((section) => ListItem(
                          child: Text(section.name),
                          selected: section.id == state.selectedSectionId,
                          onTap: () => context.read<SurfacesCubit>().selectSection(section.id),
                        ))
                    .toList() ??
                [],
          ),
        );
      },
    );
  }
}
