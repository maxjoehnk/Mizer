import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/timecode.pb.dart';
import 'package:mizer/state/timecode_bloc.dart';

import 'timecode_details.dart';
import 'timecode_list.dart';

class TimecodeView extends StatefulWidget {
  TimecodeView({Key? key}) : super(key: key);

  @override
  State<TimecodeView> createState() => _TimecodeViewState();
}

class _TimecodeViewState extends State<TimecodeView> {
  int? selectedTimecodeId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimecodeBloc, AllTimecodes>(
      builder: (context, state) {
        Timecode? selectedTimecode =
            state.timecodes.firstWhereOrNull((t) => t.id == selectedTimecodeId);
        return Column(
          children: [
            Flexible(
                flex: 1,
                child: TimecodeList(
                    timecodes: state.timecodes,
                    onSelect: (timecode) => setState(() {
                          selectedTimecodeId = timecode.id;
                        }),
                    selectedTimecode: selectedTimecode)),
            if (selectedTimecode != null)
              Flexible(
                flex: 2,
                child: TimecodeDetail(timecode: selectedTimecode, controls: state.controls),
              ),
          ],
        );
      },
    );
  }
}
