import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/inputs/color.dart';
import 'package:mizer/widgets/inputs/fader.dart';

class FixtureGroupControl extends StatelessWidget {
  final FixtureChannelGroup group;
  final List<Fixture> fixtures;
  final FixturesApi api;

  const FixtureGroupControl(this.group, {this.fixtures, this.api, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = Container();
    if (!group.hasColor()) {
      widget = Container(
          width: 64,
          child: FaderInput(
              // highlight: modifiedChannels.contains(group.name),
              label: group.name,
              value: group.generic.value,
              onValue: (v) {
                // onModifyChannel(group);
                api.writeFixtureChannel(WriteFixtureChannelRequest(
                  ids: fixtures.map((f) => f.id).toList(),
                  channel: group.name,
                  fader: v,
                ));
              }));
    }
    if (group.hasColor()) {
      widget = ColorInput(
        label: group.name,
        value: ColorValue(red: group.color.red, green: group.color.green, blue: group.color.blue),
        onChange: (v) {
          // onModifyChannel(group);
          api.writeFixtureChannel(WriteFixtureChannelRequest(
            ids: fixtures.map((f) => f.id).toList(),
            channel: group.name,
            color: ColorChannel(red: v.red, green: v.green, blue: v.blue),
          ));
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget,
    );
  }
}
