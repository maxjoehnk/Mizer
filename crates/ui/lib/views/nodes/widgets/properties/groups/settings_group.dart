import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:protobuf/protobuf.dart';

import '../fields/checkbox_field.dart';
import '../fields/enum_field.dart';
import '../fields/media_field.dart';
import '../fields/number_field.dart';
import '../fields/sequencer_field.dart';
import '../fields/spline_field.dart';
import '../fields/text_field.dart';
import '../previews/envelope_preview.dart';
import 'property_group.dart';

class NodeSettingsPane extends StatelessWidget {
  final String title;
  final Node_NodeType type;
  final List<NodeSetting> settings;
  final Function(NodeSetting) onUpdate;

  NodeSettingsPane(
      {required this.title, required this.type, required this.settings, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    var children = [
      ..._settings,
      if (type == Node_NodeType.ENVELOPE) EnvelopeSettingsPreview(settings),
    ];
    if (children.isEmpty) {
      return Container();
    }
    return PropertyGroup(title: title, children: children);
  }

  Iterable<Widget> get _settings {
    return settings.map((setting) {
      if (setting.hasText()) {
        return TextPropertyField(
            label: setting.label,
            value: setting.text.value,
            multiline: setting.text.multiline,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.text.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasFloat()) {
        return NumberField(
          label: setting.label,
          value: setting.float.value,
          fractions: true,
          min: setting.float.hasMin() ? setting.float.min : null,
          minHint: setting.float.hasMinHint() ? setting.float.minHint : null,
          max: setting.float.hasMax() ? setting.float.max : null,
          maxHint: setting.float.hasMaxHint() ? setting.float.maxHint : null,
          onUpdate: (v) {
            var updated = setting.deepCopy();
            updated.float.value = v.toDouble();
            onUpdate(updated);
          },
        );
      }
      if (setting.hasInt_6()) {
        return NumberField(
          label: setting.label,
          value: setting.int_6.value,
          fractions: false,
          min: setting.int_6.hasMin() ? setting.int_6.min : null,
          minHint: setting.int_6.hasMinHint() ? setting.int_6.minHint : null,
          max: setting.int_6.hasMax() ? setting.int_6.max : null,
          maxHint: setting.int_6.hasMaxHint() ? setting.int_6.maxHint : null,
          onUpdate: (v) {
            var updated = setting.deepCopy();
            updated.int_6.value = v.toInt();
            onUpdate(updated);
          },
        );
      }
      if (setting.hasUint()) {
        return NumberField(
          label: setting.label,
          value: setting.uint.value,
          fractions: false,
          min: setting.uint.hasMin() ? setting.uint.min : null,
          minHint: setting.uint.hasMinHint() ? setting.uint.minHint : null,
          max: setting.uint.hasMax() ? setting.uint.max : null,
          maxHint: setting.uint.hasMaxHint() ? setting.uint.maxHint : null,
          onUpdate: (v) {
            var updated = setting.deepCopy();
            updated.uint.value = v.toInt();
            onUpdate(updated);
          },
        );
      }
      if (setting.hasBool_7()) {
        return CheckboxField(
            label: setting.label,
            value: setting.bool_7.value,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.bool_7.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasSelect()) {
        return EnumField(
            disabled: setting.disabled,
            label: setting.label,
            initialValue: setting.select.value,
            items: setting.select.variants.map(mapVariant).toList(),
            onUpdate: (String v) {
              var updated = setting.deepCopy();
              updated.select.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasEnum_9()) {
        return EnumField(
            disabled: setting.disabled,
            label: setting.label,
            initialValue: setting.enum_9.value,
            items: setting.enum_9.variants
                .map((variant) => SelectOption(value: variant.value, label: variant.label))
                .toList(),
            onUpdate: (int v) {
              var updated = setting.deepCopy();
              updated.enum_9.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasId()) {
        return EnumField(
            disabled: setting.disabled,
            label: setting.label,
            initialValue: setting.id.value,
            items: setting.id.variants
                .map((variant) => SelectOption(value: variant.value, label: variant.label))
                .toList(),
            onUpdate: (int v) {
              var updated = setting.deepCopy();
              updated.id.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasSpline()) {
        return SplineField(
            value: setting.spline,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.spline = v;
              onUpdate(updated);
            });
      }
      if (setting.hasMedia()) {
        return MediaField(
            value: setting.media,
            label: setting.label,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.media.value = v.value;
              onUpdate(updated);
            });
      }
      if (setting.hasStepSequencer()) {
        return StepSequencerField(
            value: setting.stepSequencer,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.stepSequencer = v;
              onUpdate(updated);
            });
      }

      return Container();
    });
  }
}

SelectItem<String> mapVariant(NodeSetting_SelectVariant variant) {
  if (variant.hasGroup()) {
    return SelectGroup<String>(variant.group.label,
        variant.group.items.map((v) => mapVariant(v) as SelectOption<String>).toList());
  }
  return SelectOption<String>(value: variant.item.value, label: variant.item.label);
}
