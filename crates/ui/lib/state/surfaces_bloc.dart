import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:mizer/api/contracts/surfaces.dart';
import 'package:mizer/protos/surfaces.pb.dart';

class SurfacesState {
  List<Surface> surfaces;
  String? selectedSurfaceId;
  int? selectedSectionId;

  SurfacesState(this.surfaces, {this.selectedSurfaceId, this.selectedSectionId});

  SurfacesState copyWith(
          {List<Surface>? surfaces, String? selectedSurfaceId, int? selectedSectionId}) =>
      SurfacesState(surfaces ?? this.surfaces,
          selectedSurfaceId: selectedSurfaceId ?? this.selectedSurfaceId,
          selectedSectionId: selectedSectionId ?? this.selectedSectionId);

  SurfacesState _updateSection(Function(SurfaceSection section) updateSection) {
    final surfaceIndex = surfaces.indexWhere((s) => s.id == selectedSurfaceId);
    if (surfaceIndex == -1) {
      return this;
    }
    final newSurfaces = List.of(surfaces);
    Surface surface = newSurfaces[surfaceIndex];
    final sectionIndex = surface.sections.indexWhere((s) => s.id == selectedSectionId);
    if (sectionIndex == -1) {
      return this;
    }
    updateSection(surface.sections[sectionIndex]);
    newSurfaces[surfaceIndex] = surface;
    return copyWith(surfaces: newSurfaces);
  }

  Surface? get selectedSurface => surfaces.firstWhereOrNull((s) => s.id == selectedSurfaceId);

  SurfaceSection? get selectedSection =>
      selectedSurface?.sections.firstWhereOrNull((s) => s.id == selectedSectionId);

  @override
  String toString() {
    return 'SurfacesState{surfaces: $surfaces, selectedSurfaceId: $selectedSurfaceId}';
  }
}

class SurfacesCubit extends Cubit<SurfacesState> {
  final SurfacesApi api;

  SurfacesCubit(this.api) : super(SurfacesState([])) {
    api.getSurfaces().listen((surfaces) {
      emit(state.copyWith(surfaces: surfaces));
    });
  }

  Future<void> renameSurface(String name) async {
    if (state.selectedSurfaceId == null) {
      return;
    }
    await api.renameSurface(state.selectedSurfaceId!, name);
  }

  selectSurface(String surfaceId) {
    emit(state.copyWith(selectedSurfaceId: surfaceId)..selectedSectionId = null);
  }

  selectSection(int sectionId) {
    emit(state.copyWith(selectedSectionId: sectionId));
  }

  changeInputTransform(SurfaceTransform transform) {
    api.changeInputTransform(state.selectedSurfaceId!, state.selectedSectionId!, transform);
    emit(state._updateSection((section) => section..input = transform));
  }

  Future<void> confirmInputTransform() async {
    await api.updateSectionInput(
        state.selectedSurfaceId!, state.selectedSectionId!, state.selectedSection!.input);
  }

  changeOutputTransform(SurfaceTransform transform) {
    api.changeOutputTransform(state.selectedSurfaceId!, state.selectedSectionId!, transform);
    emit(state._updateSection((section) => section..output = transform));
  }

  Future<void> confirmOutputTransform() async {
    await api.updateSectionOutput(
        state.selectedSurfaceId!, state.selectedSectionId!, state.selectedSection!.output);
  }
}
