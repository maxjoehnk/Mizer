import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pb.dart';

class PlansEvent {}

class FetchPlans implements PlansEvent {}
class AddPlan implements PlansEvent {
  final String name;

  AddPlan({ required this.name });
}
class RemovePlan implements PlansEvent {
  final String id;

  RemovePlan({ required this.id });
}
class RenamePlan implements PlansEvent {
  final String id;
  final String name;

  RenamePlan({ required this.id, required this.name });
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

  MoveFixtureSelection({ required this.x, required this.y });
}

class MoveFixture implements PlansEvent {
  final FixtureId id;
  final double x;
  final double y;

  MoveFixture({ required this.id, required this.x, required this.y });
}

class AlignFixtures implements PlansEvent {
  final AlignFixturesRequest request;

  AlignFixtures({ required AlignFixturesRequest_AlignDirection direction, required int groups, required int rowGap, required int columnGap }) : request = AlignFixturesRequest(
    direction: direction,
    groups: groups,
    rowGap: rowGap,
    columnGap: columnGap,
  );
}

class PlansState {
  final int tabIndex;
  final List<Plan> plans;

  PlansState({ required this.tabIndex, required this.plans });

  factory PlansState.empty() {
    return PlansState(tabIndex: 0, plans: []);
  }

  PlansState copyWith({ List<Plan>? plans, int? tabIndex }) {
    return PlansState(tabIndex: tabIndex ?? this.tabIndex, plans: plans ?? this.plans);
  }
}

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  final PlansApi api;

  PlansBloc(this.api) : super(PlansState.empty()) {
    on<FetchPlans>((event, emit) async {
      var plans = await api.getPlans();
      emit(state.copyWith(plans: plans.plans));
    });
    on<AddPlan>((event, emit) async {
      await api.addPlan(event.name);
      var plans = await api.getPlans();
      emit(state.copyWith(plans: plans.plans));
    });
    on<RemovePlan>((event, emit) async {
      await api.removePlan(event.id);
      var plans = await api.getPlans();
      emit(state.copyWith(plans: plans.plans));
    });
    on<RenamePlan>((event, emit) async {
      await api.renamePlan(event.id, event.name);
      var plans = await api.getPlans();
      emit(state.copyWith(plans: plans.plans));
    });
    on<SelectPlanTab>((event, emit) async {
      emit(state.copyWith(tabIndex: event.tabIndex));
    });
    on<PlaceFixtureSelection>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      await api.addFixtureSelection(plan.name);
      var plans = await api.getPlans();
      emit(state.copyWith(plans: plans.plans));
    });
    on<MoveFixtureSelection>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      await api.moveSelection(plan.name, event.x, event.y);
      var plans = await api.getPlans();
      emit(state.copyWith(plans: plans.plans));
    });
    on<MoveFixture>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      await api.moveFixture(MoveFixtureRequest(planId: plan.name, fixtureId: event.id, x: event.x.round(), y: event.y.round()));
      var plans = await api.getPlans();
      emit(state.copyWith(plans: plans.plans));
    });
    on<AlignFixtures>((event, emit) async {
      var plan = state.plans[state.tabIndex];
      event.request.planId = plan.name;
      await api.alignFixtures(event.request);
      var plans = await api.getPlans();
      emit(state.copyWith(plans: plans.plans));
    });
    this.add(FetchPlans());
  }
}
