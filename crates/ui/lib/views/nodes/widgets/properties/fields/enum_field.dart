import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/controls/select.dart';

import 'field.dart';

class EnumField<TValue> extends StatelessWidget {
  final String label;
  final double? labelWidth;
  final List<SelectItem<TValue>> items;
  final TValue? initialValue;
  final Function(TValue) onUpdate;
  final bool disabled;
  final bool vertical;

  EnumField(
      {required this.label,
      this.labelWidth,
      required this.items,
      this.disabled = false,
      this.vertical = false,
      this.initialValue,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Field(
      label: label,
      labelWidth: labelWidth,
      vertical: vertical,
      child: Container(
        height: INPUT_FIELD_HEIGHT,
        decoration: BoxDecoration(),
        clipBehavior: Clip.antiAlias,
        child: MizerSelect<TValue>(
          disabled: disabled,
          value: this.initialValue,
          options: this.items,
          onChanged: (value) => onUpdate(value),
        ),
      ),
    );
  }
}

class EnumItem<T> {
  final String label;
  final T value;

  EnumItem({required this.label, required this.value});
}
