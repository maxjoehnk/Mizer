import 'package:flutter/material.dart';

class PopupSelect extends StatelessWidget {
  final String title;
  final List<SelectItem> items;

  const PopupSelect({required this.title, required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade800, boxShadow: [
        BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2, 2))
      ]),
      width: 150,
      height: 200,
      child: Column(
        children: [
          Text(title),
          Expanded(
            child: ListView(
                children: items
                    .map((item) => ListTile(
                          title: Text(item.title),
                          hoverColor: Colors.black12,
                          onTap: item.onTap,
                        ))
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class SelectItem {
  final String title;
  final Function() onTap;

  SelectItem({required this.title, required this.onTap});
}
