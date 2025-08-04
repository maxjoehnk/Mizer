import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/surfaces_bloc.dart';
import 'package:mizer/views/surfaces/input_mapping.dart';
import 'package:mizer/views/surfaces/output_mapping.dart';
import 'package:mizer/views/surfaces/settings.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';

import 'package:mizer/views/surfaces/section_list.dart';
import 'package:mizer/views/surfaces/surface_list.dart';

class SurfacesView extends StatelessWidget {
  const SurfacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurfacesCubit, SurfacesState>(
      builder: (context, state) => Row(spacing: PANEL_GAP_SIZE, children: [
        Flexible(
          child: Column(
            spacing: PANEL_GAP_SIZE,
            children: [
              Expanded(
                child: SurfaceList(),
              ),
              Expanded(
                child: SectionList(),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Panel(
            label: "Surface ${state.selectedSurface?.name ?? ""}".i18n,
            tabIndex: 0,
            tabs: [
              Tab(label: 'Input'.i18n, child: InputMapping()),
              Tab(label: 'Output'.i18n, child: OutputMapping()),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: SectionSettings(),
        )
      ]),
    );
  }
}
