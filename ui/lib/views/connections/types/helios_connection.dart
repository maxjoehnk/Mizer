import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/connections.pb.dart';

class HeliosConnectionView extends StatelessWidget {
  final HeliosConnection device;

  HeliosConnectionView({this.device});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Helios DAC - ${device.name}", style: style.subtitle1),
          Text("Firmware: ${device.firmware}", style: style.bodyText1),
        ],
      ),
    );
  }
}
