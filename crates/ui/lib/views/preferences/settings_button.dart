import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/hoverable.dart';

class SettingsButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final bool symmetric;

  const SettingsButton({super.key, required this.child, required this.onTap, this.symmetric = false});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
        builder: (hover) => Container(
          padding: !symmetric ? const EdgeInsets.symmetric(vertical: 2, horizontal: 4) : const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: hover ? Grey600 : Grey700,
            borderRadius: BorderRadius.circular(4),
          ),
          child: child,
        ),
        onTap: onTap
    );
  }
}
