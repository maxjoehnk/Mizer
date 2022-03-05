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
    this.add(FetchPlans());
  }

  @override
  Stream<PlansState> mapEventToState(PlansEvent event) async* {
    if (event is FetchPlans) {
      var plans = await api.getPlans();
      yield state.copyWith(plans: plans.plans);
    }
    if (event is AddPlan) {
      await api.addPlan(event.name);
      var plans = await api.getPlans();
      yield state.copyWith(plans: plans.plans);
    }
    if (event is RemovePlan) {
      await api.removePlan(event.id);
      var plans = await api.getPlans();
      yield state.copyWith(plans: plans.plans);
    }
    if (event is RenamePlan) {
      await api.renamePlan(event.id, event.name);
      var plans = await api.getPlans();
      yield state.copyWith(plans: plans.plans);
    }
    if (event is SelectPlanTab) {
      yield state.copyWith(tabIndex: event.tabIndex);
    }
    if (event is PlaceFixtureSelection) {
      var plan = state.plans[state.tabIndex];
      await api.addFixtureSelection(plan.name);
      var plans = await api.getPlans();
      yield state.copyWith(plans: plans.plans);
    }
    if (event is MoveFixtureSelection) {
      var plan = state.plans[state.tabIndex];
      await api.moveSelection(plan.name, event.x, event.y);
      var plans = await api.getPlans();
      yield state.copyWith(plans: plans.plans);
    }
    if (event is MoveFixture) {
      var plan = state.plans[state.tabIndex];
      await api.moveFixture(MoveFixtureRequest(planId: plan.name, fixtureId: event.id, x: event.x.round(), y: event.y.round()));
      var plans = await api.getPlans();
      yield state.copyWith(plans: plans.plans);
    }
  }
}
