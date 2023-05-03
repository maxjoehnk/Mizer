import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/widgets/inputs/time_input.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

class PopupDirectTimeInput extends StatelessWidget {
  final void Function(CueTime?)? onEnter;
  final CueTime? time;
  final bool allowSeconds;
  final bool allowBeats;

  const PopupDirectTimeInput(
      {this.onEnter, this.time, this.allowSeconds = true, this.allowBeats = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
        title: "Enter Time",
        width: 286,
        height: 320,
        child: DirectTimeInput(
          onEnter: (value) {
            Navigator.of(context).pop(value);
            if (onEnter != null) {
              onEnter!(value);
            }
          },
          time: time,
          allowSeconds: allowSeconds,
          allowBeats: allowBeats,
          autofocus: true,
        ));
  }
}
