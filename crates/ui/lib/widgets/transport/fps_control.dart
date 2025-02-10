import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/transport.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:provider/provider.dart';

class FpsSelector extends StatelessWidget {
  final Stream<Transport> transportStream;

  const FpsSelector({super.key, required this.transportStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: transportStream.map((event) => event.fps).distinct(),
        builder: (context, snapshot) {
          return Container(
            width: 96,
            height: TRANSPORT_CONTROLS_HEIGHT,
            padding: const EdgeInsets.all(4),
            child: MizerSelect<double>(
              openTop: true,
              options: [
                SelectOption(label: "30 FPS", value: 30),
                SelectOption(label: "60 FPS", value: 60),
              ],
              onChanged: (fps) => context.read<TransportApi>().setFPS(fps),
              value: snapshot.data ?? 60,
            ),
          );
        });
  }
}

