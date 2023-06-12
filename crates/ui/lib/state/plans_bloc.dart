import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pb.dart';

class PlansEvent {}

class FetchPlans implements PlansEvent {}

class AddPlan implements PlansEvent {
  final String name;

  AddPlan({required this.name});
}

class RemovePlan implements PlansEvent {
  final String id;

  RemovePlan({required this.id});
}

class RenamePlan implements PlansEvent {
  final String id;
  final String name;

  RenamePlan({required this.id, required this.name});
}

class SelectPlanTab implements PlansEvent {
  final int tabIndex;

  SelectPlanTab(this.tabIndex);
}

class PlaceFixtureSelection implements PlansEvent {
  PlaceFixtureSelection();
}

class MoveFixtureSelection implements PlansEvent {
  final double x;
  final double y;

  MoveFixtureSelection({required this.x, required this.y});
}

class MoveFixture implements PlansEvent {
  final FixtureId id;
  final double x;
  final double y;

  MoveFixture({required this.id, required this.x, required this.y});
}

class AlignFixtures implements PlansEvent {
  final AlignFixturesRequest request;

  AlignFixtures(
      {required AlignFixturesRequest_AlignDirection direction,
      required int groups,
      required int rowGap,
      required int columnGap})
      : request = AlignFixturesRequest(
          direction: direction,
          groups: groups,
          rowGap: rowGap,
          columnGap: columnGap,
        );
}

class AddImage implements PlansEvent {
  final double x;
  final double y;
  final double width;
  final double height;
  final double transparency;
  final Uint8List data;

  AddImage(
      {required this.x,
      required this.y,
      required this.width,
      required this.height,
      required this.transparency,
      required this.data});
}

class MoveImage implements PlansEvent {
  final String imageId;
  final double x;
  final double y;

  MoveImage({required this.imageId, required this.x, required this.y});
}

class ResizeImage implements PlansEvent {
  final String imageId;
  final double width;
  final double height;

  ResizeImage({required this.imageId, required this.width, required this.height});
}

class DeleteImage implements PlansEvent {
  final String imageId;

  DeleteImage({required this.imageId});
}

class PlansState {
  final int tabIndex;
  final List<Plan> plans;

  PlansState({required this.tabIndex, required this.plans});

  factory PlansState.empty() {
    return PlansState(tabIndex: 0, plans: []);
  }

  PlansState copyWith({List<Plan>? plans, int? tabIndex}) {
    return PlansState(tabIndex: tabIndex ?? this.tabIndex, plans: plans ?? this.plans);
  }
}

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  final PlansApi api;

  PlansBloc(this.api) : super(PlansState.empty()) {
    on<FetchPlans>((event, emit) async {
      await _refreshPlans(emit);
    });
    on<AddPlan>((event, emit) async {
      await api.addPlan(event.name);
      await _refreshPlans(emit);
    });
    on<RemovePlan>((event, emit) async {
      await api.removePlan(event.id);
      await _refreshPlans(emit);
    });
    on<RenamePlan>((event, emit) async {
      await api.renamePlan(event.id, event.name);
      await _refreshPlans(emit);
    });
    on<SelectPlanTab>((event, emit) async {
      emit(state.copyWith(tabIndex: event.tabIndex));
    });
    on<PlaceFixtureSelection>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      await api.addFixtureSelection(plan.name);
      await _refreshPlans(emit);
    });
    on<MoveFixtureSelection>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      await api.moveSelection(plan.name, event.x, event.y);
      await _refreshPlans(emit);
    });
    on<MoveFixture>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      await api.moveFixture(MoveFixtureRequest(
          planId: plan.name, fixtureId: event.id, x: event.x.round(), y: event.y.round()));
      await _refreshPlans(emit);
    });
    on<AlignFixtures>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      event.request.planId = plan.name;
      await api.alignFixtures(event.request);
      await _refreshPlans(emit);
    });
    on<AddImage>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      AddImageRequest request = AddImageRequest(
        x: event.x,
        y: event.y,
        width: event.width,
        height: event.height,
        planId: plan.name,
        transparency: event.transparency,
        data: event.data,
      );
      await api.addImage(request);
      await _refreshPlans(emit);
    });
    on<MoveImage>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      MoveImageRequest request = MoveImageRequest(
        planId: plan.name,
        imageId: event.imageId,
        x: event.x,
        y: event.y,
      );
      await api.moveImage(request);
      await _refreshPlans(emit);
    });
    on<ResizeImage>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      ResizeImageRequest request = ResizeImageRequest(
        planId: plan.name,
        imageId: event.imageId,
        width: event.width,
        height: event.height,
      );
      await api.resizeImage(request);
      await _refreshPlans(emit);
    });
    on<DeleteImage>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      await api.removeImage(plan.name, event.imageId);
      await _refreshPlans(emit);
    });
    this.add(FetchPlans());
  }

  Future<void> _refreshPlans(Emitter<PlansState> emit) async {
    var plans = await api.getPlans();
    emit(state.copyWith(plans: plans.plans));
  }
}
