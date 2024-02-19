import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/controls/button.dart';

class MizerIconButton extends StatelessWidget {
  final void Function()? onClick;
  final IconData icon;
  final String label;

  const MizerIconButton({Key? key, required this.icon, this.onClick, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MizerButton(child: Icon(icon), onClick: onClick);
  }
}
