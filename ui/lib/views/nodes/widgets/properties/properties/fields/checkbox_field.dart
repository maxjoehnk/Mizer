import 'package:flutter/material.dart';

import '../field.dart';

class CheckboxField extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onUpdate;

  CheckboxField({required this.label, required this.value, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Field(
        label: label,
        child: Checkbox(
          value: value,
          onChanged: (value) => onUpdate(value!),
        )
    );
  }
}
