import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class EnumField extends StatelessWidget {
  final String label;
  final List<EnumItem<int>> items;
  final int initialValue;
  final Function(int) onUpdate;

  EnumField({ this.label, this.items, this.initialValue, this.onUpdate });

  @override
  Widget build(BuildContext context) {
    return SelectFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: this.initialValue.toString(),
      onChanged: (value) => onUpdate(int.parse(value)),
      items: this.items.map((item) {
        return {
          'value': item.value.toString(),
          'label': item.label,
        };
      }).toList(),
    );
  }
}

class EnumItem<T> {
  final String label;
  final T value;

  EnumItem({ this.label, this.value });
}
