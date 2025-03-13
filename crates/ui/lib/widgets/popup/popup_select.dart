import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/popup/popup_container.dart';

class PopupSelect extends StatelessWidget {
  final String title;
  final List<SelectItem> items;

  const PopupSelect({required this.title, required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
        title: title,
        width: 150,
        height: 204,
        child: ListView(
            shrinkWrap: true,
            children: items
                .map((item) => ListTile(
                      title: Text(item.title),
                      hoverColor: Grey700,
                      onTap: item.onTap,
                    ))
                .toList()));
  }
}

class SelectItem {
  final String title;
  final Function() onTap;

  SelectItem({required this.title, required this.onTap});
}
