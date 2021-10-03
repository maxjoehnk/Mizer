import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/widgets/controls/icon_button.dart';

const double TOOLBAR_HEIGHT = 48;

class NodesToolbar extends StatelessWidget {
  final Function() onToggleHidden;
  final bool showHiddenNodes;

  const NodesToolbar({this.onToggleHidden, this.showHiddenNodes, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: TOOLBAR_HEIGHT,
        color: Colors.grey.shade800,
        child: Row(
          children: [
            Expanded(child: Container()),
            SizedBox.square(
                dimension: TOOLBAR_HEIGHT,
                child: MizerIconButton(
                    onClick: onToggleHidden,
                    icon: showHiddenNodes ? MdiIcons.eyeOffOutline : MdiIcons.eyeOutline,
                    label: "Show hidden nodes"))
          ],
        ));
  }
}
