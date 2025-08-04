import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/timecode.dart';
import 'package:mizer/api/plugin/ffi/timecode.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/state/timecode_bloc.dart';

import 'package:mizer/views/timecode/timecode_details.dart';
import 'package:mizer/views/timecode/timecode_list.dart';

class TimecodeView extends StatefulWidget {
  TimecodeView({Key? key}) : super(key: key);

  @override
  State<TimecodeView> createState() => _TimecodeViewState();
}

class _TimecodeViewState extends State<TimecodeView> {
  TimecodePointer? _timecodePointer;

  @override
  void initState() {
    super.initState();
    context.read<TimecodeApi>().getTimecodePointer().then((value) => setState(() {
          _timecodePointer = value;
        }));
  }

  @override
  void dispose() {
    _timecodePointer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimecodeBloc, TimecodeState>(
      builder: (context, state) {
        return Column(
          spacing: PANEL_GAP_SIZE,
          children: [
            Flexible(
                flex: 1,
                child: TimecodeList(
                  timecodes: state.timecodes,
                  onSelect: (timecode) => context.read<TimecodeBloc>().selectTimecode(timecode.id),
                  selectedTimecode: state.selectedTimecode,
                  timecodePointer: _timecodePointer,
                )),
            if (state.selectedTimecode != null)
              Flexible(
                flex: 2,
                child: TimecodeDetail(
                    timecode: state.selectedTimecode!,
                    controls: state.controls,
                    reader: _timecodePointer?.getTrackReader(state.selectedTimecodeId!)),
              ),
          ],
        );
      },
    );
  }
}
