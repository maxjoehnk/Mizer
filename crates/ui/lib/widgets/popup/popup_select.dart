import 'package:flutter/material.dart';
import 'package:mizer/widgets/list_item.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

class PopupSelect extends StatelessWidget {
  final String title;
  final List<SelectItem> items;
  final double width;
  final double height;
  final bool closeButton;

  const PopupSelect({required this.title, required this.items, this.height = 192, this.width = 150, this.closeButton = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
        title: title,
        width: width,
        height: height,
        closeButton: closeButton,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: items
                .map((item) => ListItem(
                      child: Text(item.title, style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.of(context).pop(item.value);
                        item.onTap?.call();
                      },
                    ))
                .toList()));
  }
}

class SelectItem {
  final String title;
  final Function()? onTap;
  final dynamic value;

  SelectItem({required this.title, this.onTap, this.value = null});
}
