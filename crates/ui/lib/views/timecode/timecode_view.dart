import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/timecode_bloc.dart';

import 'timecode_details.dart';
import 'timecode_list.dart';

class TimecodeView extends StatelessWidget {
  TimecodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimecodeBloc, TimecodeState>(
      builder: (context, state) {
        return Column(
          children: [
            Flexible(
                flex: 1,
                child: TimecodeList(
                    timecodes: state.timecodes,
                    onSelect: (timecode) =>
                        context.read<TimecodeBloc>().selectTimecode(timecode.id),
                    selectedTimecode: state.selectedTimecode)),
            if (state.selectedTimecode != null)
              Flexible(
                flex: 2,
                child: TimecodeDetail(timecode: state.selectedTimecode!, controls: state.controls),
              ),
          ],
        );
      },
    );
  }
}
