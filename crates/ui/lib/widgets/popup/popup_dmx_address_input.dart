import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

class PopupDmxAddressInput extends StatefulWidget {
  final String? title;
  final FixtureAddress value;
  final Function(FixtureAddress) onChange;

  const PopupDmxAddressInput({this.title, required this.value, required this.onChange, Key? key})
      : super(key: key);

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
    return PopupContainer(
        title: widget.title ?? "Address",
        child: Column(
          spacing: FORM_GAP_SIZE,
          mainAxisSize: MainAxisSize.min,
          children: [
            Field(
              label: "Universe",
              big: true,
              child: TextInput(
                  controller: _universeController,
                  autofocus: true),
            ),
            Field(
              label: "Channel",
              big: true,
              child: TextInput(
                  controller: _channelController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _save(context)),
            ),
          ],
        ),
        actions: [
          PopupAction("Cancel", () => Navigator.of(context).pop()),
          PopupAction("Save", () => _save(context)),
        ]);
  }

  void _save(BuildContext context) {
    var universe = int.parse(_universeController.text);
    var channel = int.parse(_channelController.text);

    widget.onChange(FixtureAddress(universe: universe, channel: channel));
    Navigator.of(context).pop();
  }
}
