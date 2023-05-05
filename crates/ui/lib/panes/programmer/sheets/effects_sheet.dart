import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/widgets/inputs/fader.dart';

class EffectsSheet extends StatelessWidget {
  final List<EffectProgrammerState> effects;

  const EffectsSheet({required this.effects, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProgrammerApi api = context.read();
    return BlocBuilder<EffectsBloc, EffectState>(
      builder: (context, state) {
        return ListView(
            scrollDirection: Axis.horizontal,
            children: this
                .effects
                .map((effect) => Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4), color: Colors.black12),
                      child: Column(children: [
                        Text(state.firstWhereOrNull((e) => e.id == effect.effectId)?.name ?? ""),
                        Expanded(
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                              width: 64,
                              margin: const EdgeInsets.all(8),
                              child: FaderInput(
                                  label: "Rate",
                                  value: effect.effectRate,
                                  onValue: (rate) => api.writeEffectRate(effect.effectId, rate))),
                          Container(
                              width: 64,
                              margin: const EdgeInsets.all(8),
                              child: FaderInput(
                                  label: "Offset",
                                  value: effect.effectOffset,
                                  onValue: (offset) =>
                                      api.writeEffectOffset(effect.effectId, offset))),
                        ]))
                      ]),
                    ))
                .toList());
      },
    );
  }
}
