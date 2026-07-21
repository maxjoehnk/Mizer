import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/theme.dart';
import 'package:mizer/widgets/hoverable.dart';

class DialogTile extends StatelessWidget {
  final String? title;
  final Widget child;
  final Function()? onClick;

  const DialogTile({this.title, required this.child, this.onClick, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MizerTheme mizerTheme = Theme.of(context).mizerTheme;
    return Hoverable(
        builder: (hovered) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                border: Border.all(color: mizerTheme.tileBorder, width: 2),
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                color: hovered ? mizerTheme.tileHover : mizerTheme.tileBackground),
            width: DIALOG_TILE_SIZE,
            height: DIALOG_TILE_SIZE,
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null)
                    Container(
                        color: Colors.grey.shade800,
                        child: Text(title!, textAlign: TextAlign.center)),
                  Expanded(child: child),
                ],
              ),
            ),
          );
        },
        onTap: this.onClick);
  }
}
