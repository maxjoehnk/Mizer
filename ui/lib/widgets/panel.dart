import 'package:flutter/material.dart';

import 'hoverable.dart';

class Panel extends StatelessWidget {
  final String label;
  final Widget child;
  final List<PanelAction> actions;

  Panel({this.child, this.label, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade800, width: 2)),
      margin: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null)
            Container(
                color: Colors.grey.shade800,
                padding: const EdgeInsets.all(2),
                child: Text(label, textAlign: TextAlign.start)),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: child),
                if (actions != null) PanelActions(actions: actions)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PanelAction {
  final String label;
  final Function() onClick;
  final bool disabled;

  PanelAction({this.label, this.onClick, this.disabled});
}

class PanelActions extends StatelessWidget {
  final List<PanelAction> actions;

  const PanelActions({this.actions, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Column(
      children: actions
          .map((a) => Hoverable(
                disabled: a.disabled,
                onTap: a.onClick,
                builder: (hovered) => Container(
                  color: _getColor(a, hovered),
                  height: 64,
                  width: 64,
                  child: Center(
                    child: Text(a.label, style: textTheme.subtitle2.copyWith(fontSize: 10)),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Color _getColor(PanelAction action, bool hovered) {
    if (action.disabled == true) {
      return Colors.grey.shade900;
    }
    if (hovered) {
      return Colors.grey.shade700;
    }
    return Colors.grey.shade800;
  }
}
