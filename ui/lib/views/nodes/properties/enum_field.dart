import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class EnumField extends StatelessWidget {
  final String label;
  final List<EnumItem<String>> items;
  final String initialValue;

  EnumField({ this.label, this.items, this.initialValue });

  @override
  Widget build(BuildContext context) {
    return SelectFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: this.initialValue,
      items: this.items.map((item) {
        return {
          'value': item.value,
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
