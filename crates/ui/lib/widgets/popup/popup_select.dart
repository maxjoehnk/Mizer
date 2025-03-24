import 'package:flutter/material.dart';
import 'package:mizer/widgets/list_item.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

class PopupSelect extends StatelessWidget {
  final String title;
  final List<SelectItem> items;
  final double width;

  const PopupSelect({required this.title, required this.items, this.width = 150, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
        title: title,
        titleFontSize: 15,
        width: width,
        height: 204,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: items
                .map((item) => ListItem(
                      child: Text(item.title, style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.of(context).pop();
                        item.onTap();
                      },
                    ))
                .toList()));
  }
}

class SelectItem {
  final String title;
  final Function() onTap;

  SelectItem({required this.title, required this.onTap});
}
