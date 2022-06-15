import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:mizer/api/contracts/effects.dart';

abstract class EffectsEvent {}

class FetchEffects extends EffectsEvent {}

class AddEffect extends EffectsEvent {}

typedef EffectState = List<Effect>;

class DeleteEffect extends EffectsEvent {
  final int id;

  DeleteEffect(this.id);
}

class EffectsBloc extends Bloc<EffectsEvent, EffectState> {
  final EffectsApi api;

  EffectsBloc(this.api) : super(<Effect>[]) {
    this.add(FetchEffects());
  }

  @override
  Stream<EffectState> mapEventToState(EffectsEvent event) async* {
    if (event is FetchEffects) {
      yield await _fetchEffects();
    }
    if (event is AddEffect) {
      await _addEffect(event);
      yield await _fetchEffects();
    }
    if (event is DeleteEffect) {
      await _deleteEffect(event);
      yield await _fetchEffects();
    }
  }

  Future<EffectState> _fetchEffects() async {
    log("fetching effects", name: "EffectsBloc");
    var effects = await api.getEffects();
    log("got ${effects.length} effects", name: "EffectsBloc");

    effects.sortByCompare<int>((effect) => effect.id, (lhs, rhs) => lhs - rhs);

    return effects;
  }

  Future<void> _addEffect(AddEffect event) async {
    log("adding effect: $event", name: "EffectsBloc");
  }

  Future<void> _deleteEffect(DeleteEffect event) async {
    log("deleting effect: $event", name: "EffectsBloc");
    await api.deleteEffect(event.id);
  }
}
