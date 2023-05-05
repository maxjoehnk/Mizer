import 'package:flutter/material.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

class PopupDmxAddressInput extends StatefulWidget {
  final String? title;
  final FixtureAddress value;
  final Function(FixtureAddress) onChange;

  const PopupDmxAddressInput({this.title, required this.value, required this.onChange, Key? key}) : super(key: key);

  @override
  State<PopupDmxAddressInput> createState() => _PopupDmxAddressInputState(value);
}

class _PopupDmxAddressInputState extends State<PopupDmxAddressInput> {
  final TextEditingController _universeController;
  final TextEditingController _channelController;

  _PopupDmxAddressInputState(FixtureAddress value)
      : _universeController = TextEditingController(text: value.universe.toString()),
        _channelController = TextEditingController(text: value.channel.toString());

  @override
  Widget build(BuildContext context) {
    return PopupContainer(title: widget.title ?? "Address", child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(controller: _universeController, autofocus: true, decoration: InputDecoration(hintText: "Universe")),
        TextField(controller: _channelController, autofocus: true, decoration: InputDecoration(hintText: "Channel")),
      ],
    ), actions: [
      PopupAction("Cancel", () => Navigator.of(context).pop()),
      PopupAction("Save", () {
        var universe = int.parse(_universeController.text);
        var channel = int.parse(_channelController.text);

        widget.onChange(FixtureAddress(universe: universe, channel: channel));
        Navigator.of(context).pop();
      }),
    ]);
  }
}
