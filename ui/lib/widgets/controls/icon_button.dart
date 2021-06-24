import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/controls/button.dart';

class MizerIconButton extends StatelessWidget {
  final Function() onClick;
  final IconData icon;
  final String label;

  const MizerIconButton({Key key, this.icon, this.onClick, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(message: this.label, child: MizerButton(child: Icon(icon), onClick: onClick));
  }
}
