import 'package:flutter/material.dart';
import 'package:mizer/shell/navigation_bar.dart';

class MobileTab {
  final Widget child;
  final String title;
  final IconData icon;

  const MobileTab({required this.child, required this.title, required this.icon});
}

class Navigation extends StatefulWidget {
  final List<MobileTab> tabs;

  const Navigation({super.key, required this.tabs});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: widget.tabs[_selectedIndex].child),
        Container(
            color: Colors.grey.shade800,
            height: 56,
            child: Row(children: [
              for (final (i, tab) in widget.tabs.indexed)
                SizedBox(
                  width: 64,
                  child: NavigationBarItem(
                      icon: tab.icon,
                      label: tab.title,
                      onSelect: () => setState(() => _selectedIndex = i),
                      selected: i == _selectedIndex),
                )
            ]))
      ],
    );
  }
}
