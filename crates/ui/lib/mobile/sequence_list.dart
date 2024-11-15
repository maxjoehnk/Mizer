import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/mobile/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

class SequenceList extends StatefulWidget {
  const SequenceList({Key? key}) : super(key: key);

  @override
  State<SequenceList> createState() => _SequenceListState();
}

class _SequenceListState extends State<SequenceList> {
  late Stream<SequencerState> _state;
  
  @override
  void initState() {
    super.initState();
    this._state = context.read<SequencerRemoteApi>().getSequencerState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Sequences",
      child: StreamBuilder(
        stream: _state,
        builder: (context, snapshot) {
          return _list(context, snapshot.data?.sequences ?? []);
        }
      )
    );
  }

  Widget _list(BuildContext context, List<SequenceState> sequences) {
    return GridView(
      padding: const EdgeInsets.all(4),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisExtent: 100,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      children: sequences
          .map((sequence) => _sequenceTile(context, sequence))
          .toList(),
    );
  }

  Widget _sequenceTile(BuildContext context, SequenceState sequence) {
    double rate = sequence.rate;
    bool active = sequence.active;
    return GestureDetector(
      child: Hoverable(
        onTap: () {
          if (active) {
            context.read<SequencerRemoteApi>().sequenceStop(sequence.sequence);
          } else {
            context.read<SequencerRemoteApi>().sequenceGoForward(sequence.sequence);
          }
        },
        builder: (hovered) => Container(
          padding: const EdgeInsets.all(2),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: hovered ? Colors.white10 : Colors.transparent,
            border: Border.all(color: Colors.white10, width: 4),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Expanded(child: Text(sequence.sequence.toString(), textAlign: TextAlign.start)),
              Text((rate * 100).toStringAsFixed(0) + "%"),
            ]),
            Spacer(),
            AutoSizeText(sequence.name, textAlign: TextAlign.center, maxLines: 2),
            Container(height: 24, child: active ? Icon(Icons.play_arrow) : null),
          ]),
        ),
      ),
    );
  }
}
