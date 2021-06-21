import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/controls/button.dart';

class MizerIconButton extends StatelessWidget {
  final Function() onClick;
  final IconData icon;

  const MizerIconButton({Key key, this.icon, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MizerButton(child: Icon(icon), onClick: onClick);
  }
}
