import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/inputs/fader.dart';

class DMXSheet extends StatelessWidget {
  final List<Fixture> fixtures;
  final ProgrammerApi api;
  final List<String> modifiedChannels;
  final Function(DmxChannel) onModifyChannel;

  const DMXSheet({this.fixtures, this.api, this.modifiedChannels, this.onModifyChannel, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: channels.isNotEmpty
          ? ListView(
              scrollDirection: Axis.horizontal, children: channels.map(_buildChannelFader).toList())
          : null,
    );
  }

  List<DmxChannel> get channels {
    return fixtures.first.dmxChannels;
  }

  Widget _buildChannelFader(DmxChannel channel) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        width: 64,
        child: FaderInput(
            highlight: modifiedChannels.contains(channel.name),
            label: channel.name,
            value: channel.value,
            onValue: (v) {
              onModifyChannel(channel);
              api.writeChannels(WriteChannelsRequest(
                channel: channel.name,
                fader: v,
              ));
            }));
  }
}
