import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
import 'package:mizer/views/sequencer/sequencer_settings.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'cue_list.dart';
import 'sequence_list.dart';
import 'track_sheet.dart';

class SequencerView extends StatefulWidget {
  const SequencerView({Key? key}) : super(key: key);

  @override
  State<SequencerView> createState() => _SequencerViewState();
}

class _SequencerViewState extends State<SequencerView> with SingleTickerProviderStateMixin {
  SequencerPointer? _pointer;
  Map<int, SequenceState> sequenceStates = {};
  Ticker? ticker;
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    var sequencerApi = context.read<SequencerApi>();
    sequencerApi.getSequencerPointer().then((pointer) => setState(() {
          _pointer = pointer;
          ticker = this.createTicker((elapsed) {
            setState(() {
              sequenceStates = _pointer!.readState();
            });
          });
          ticker!.start();
        }));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FixturesBloc>().add(FetchFixtures());
      context.read<SequencerBloc>().add(FetchSequences());
    });
  }

  @override
  void dispose() {
    _pointer?.dispose();
    ticker?.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HotkeyConfiguration(
      hotkeySelector: (hotkeys) => hotkeys.sequencer,
      hotkeyMap: {
        "go_forward": () {
          SequencerBloc bloc = context.read();
          if (bloc.state.selectedSequenceId != null) {
            _sequenceGoForward(bloc.state.selectedSequenceId!);
          }
        },
        "go_backward": () {
          SequencerBloc bloc = context.read();
          if (bloc.state.selectedSequenceId != null) {
            _sequenceGoBackward(bloc.state.selectedSequenceId!);
          }
        },
        "delete": () {
          SequencerBloc bloc = context.read();
          if (bloc.state.selectedSequenceId != null) {
            _deleteSequence(bloc.state.selectedSequenceId!);
          }
        },
        "duplicate": () {
          SequencerBloc bloc = context.read();
          if (bloc.state.selectedSequenceId != null) {
            _duplicateSequence(bloc.state.selectedSequenceId!);
          }
        },
        "stop": () {
          SequencerBloc bloc = context.read();
          if (bloc.state.selectedSequenceId != null) {
            _sequenceStop(bloc.state.selectedSequenceId!);
          }
        }
      },
      child: BlocBuilder<SequencerBloc, SequencerState>(builder: (context, state) {
        return Column(
          spacing: PANEL_GAP_SIZE,
          children: [
            Expanded(
              child: Panel(
                label: "Sequences",
                child: SequenceList(
                    selectSequence: _selectSequence,
                    selectedSequence: state.selectedSequence,
                    sequenceStates: sequenceStates,
                    searchQuery: searchQuery),
                actions: [
                  PanelActionModel(
                      hotkeyId: "go_forward",
                      label: "Go+",
                      onClick: () => _sequenceGoForward(state.selectedSequenceId!),
                      disabled: state.selectedSequenceId == null,
                      menu: Menu(items: [
                        MenuItem(
                            label: "Add Midi Mapping",
                            action: () => _addMidiMappingForGo(context, state))
                      ])),
                  PanelActionModel(
                      hotkeyId: "go_backward",
                      label: "Go-",
                      onClick: () => _sequenceGoBackward(state.selectedSequenceId!),
                      disabled: state.selectedSequenceId == null),
                  PanelActionModel(
                      hotkeyId: "stop",
                      label: "Stop",
                      onClick: () => _sequenceStop(state.selectedSequenceId!),
                      disabled: state.selectedSequenceId == null,
                      menu: Menu(items: [
                        MenuItem(
                            label: "Add Midi Mapping",
                            action: () => _addMidiMappingForStop(context, state))
                      ])),
                  PanelActionModel(
                      hotkeyId: "delete",
                      label: "Delete",
                      onClick: () => _deleteSequence(state.selectedSequenceId!),
                      disabled: state.selectedSequenceId == null),
                  PanelActionModel(
                      hotkeyId: "duplicate",
                      label: "Duplicate",
                      onClick: () => _duplicateSequence(state.selectedSequenceId!),
                      disabled: state.selectedSequenceId == null),
                ],
                onSearch: (query) => setState(() => this.searchQuery = query),
              ),
            ),
            if (state.selectedSequence != null)
              Expanded(
                child: Panel.tabs(
                  label: "${state.selectedSequence!.name}",
                  tabs: [
                    tabs.Tab(
                        label: "Cue List",
                        child: CueList(
                            sequence: state.selectedSequence!,
                            activeCue: sequenceStates[state.selectedSequenceId]?.cueId)),
                    tabs.Tab(
                        label: "Track Sheet",
                        child: TrackSheet(
                            sequence: state.selectedSequence!,
                            activeCue: sequenceStates[state.selectedSequenceId]?.cueId)),
                    tabs.Tab(
                        label: "Sequence Settings",
                        child: SequencerSettings(sequence: state.selectedSequence!)),
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }

  Future<void> _addMidiMappingForGo(BuildContext context, SequencerState state) async {
    var request =
        MappingRequest(sequencerGo: SequencerGoAction(sequencerId: state.selectedSequenceId!));
    addMidiMapping(
        context, "Add MIDI Mapping for Sequence Go ${state.selectedSequence!.name}", request);
  }

  Future<void> _addMidiMappingForStop(BuildContext context, SequencerState state) async {
    var request =
        MappingRequest(sequencerStop: SequencerStopAction(sequencerId: state.selectedSequenceId!));
    addMidiMapping(
        context, "Add MIDI Mapping for Sequence Stop ${state.selectedSequence!.name}", request);
  }

  _deleteSequence(int sequenceId) {
    context.read<SequencerBloc>().add(DeleteSequence(sequenceId));
  }

  _duplicateSequence(int sequenceId) {
    context.read<SequencerBloc>().add(DuplicateSequence(sequenceId));
  }

  _sequenceGoForward(int sequenceId) {
    context.read<SequencerApi>().sequenceGoForward(sequenceId);
  }

  _sequenceGoBackward(int sequenceId) {
    context.read<SequencerApi>().sequenceGoBackward(sequenceId);
  }

  _sequenceStop(int sequenceId) {
    context.read<SequencerApi>().sequenceStop(sequenceId);
  }

  _selectSequence(Sequence sequence) {
    context.read<SequencerBloc>().add(SelectSequence(sequence: sequence.id));
  }
}
