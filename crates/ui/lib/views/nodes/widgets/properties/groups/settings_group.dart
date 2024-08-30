import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:protobuf/protobuf.dart';

import '../fields/boolean_field.dart';
import '../fields/enum_field.dart';
import '../fields/field.dart';
import '../fields/media_field.dart';
import '../fields/number_field.dart';
import '../fields/sequencer_field.dart';
import '../fields/spline_field.dart';
import '../fields/text_field.dart';
import '../previews/envelope_preview.dart';
import '../previews/surface_mapping_preview.dart';
import 'property_group.dart';

class NodeSettingsPane extends StatelessWidget {
  final String title;
  final String nodePath;
  final String type;
  final List<NodeSetting> settings;
  final Function(NodeSetting) onUpdate;
  final Function(NodeSetting?) onHover;

  NodeSettingsPane(
      {required this.title,
      required this.type,
      required this.settings,
      required this.onUpdate,
      required this.onHover,
      required this.nodePath});

  @override
  Widget build(BuildContext context) {
    var children = [
      ...getSettings(context),
      if (type == "envelope") EnvelopeSettingsPreview(settings),
      if (type == "surface-mapping") SurfaceMappingSettingsPreview(settings),
    ];
    if (children.isEmpty) {
      return Container();
    }
    return PropertyGroup(title: title, children: children);
  }

  Iterable<Widget> getSettings(BuildContext context) {
    return settings.map((setting) {
      String label = setting.hasLabel() ? setting.label : setting.id;
      Widget child = Container();
      if (setting.hasTextValue()) {
        child = TextPropertyField(
            label: label,
            value: setting.textValue.value,
            multiline: setting.textValue.multiline,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.textValue.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasFloatValue()) {
        child = NumberField(
          node: nodePath,
          label: label,
          value: setting.floatValue.value,
          fractions: true,
          step: setting.floatValue.hasStepSize() ? setting.floatValue.stepSize : null,
          min: setting.floatValue.hasMin() ? setting.floatValue.min : null,
          minHint: setting.floatValue.hasMinHint() ? setting.floatValue.minHint : null,
          max: setting.floatValue.hasMax() ? setting.floatValue.max : null,
          maxHint: setting.floatValue.hasMaxHint() ? setting.floatValue.maxHint : null,
          onUpdate: (v) {
            var updated = setting.deepCopy();
            updated.floatValue.value = v.toDouble();
            onUpdate(updated);
          },
        );
      }
      if (setting.hasIntValue()) {
        child = NumberField(
          node: nodePath,
          label: label,
          value: setting.intValue.value,
          fractions: false,
          step: setting.intValue.hasStepSize() ? setting.intValue.stepSize : null,
          min: setting.intValue.hasMin() ? setting.intValue.min : null,
          minHint: setting.intValue.hasMinHint() ? setting.intValue.minHint : null,
          max: setting.intValue.hasMax() ? setting.intValue.max : null,
          maxHint: setting.intValue.hasMaxHint() ? setting.intValue.maxHint : null,
          onUpdate: (v) {
            var updated = setting.deepCopy();
            updated.intValue.value = v.toInt();
            onUpdate(updated);
          },
        );
      }
      if (setting.hasUintValue()) {
        child = NumberField(
          node: nodePath,
          label: label,
          value: setting.uintValue.value,
          fractions: false,
          step: setting.uintValue.hasStepSize() ? setting.uintValue.stepSize : null,
          min: setting.uintValue.hasMin() ? setting.uintValue.min : null,
          minHint: setting.uintValue.hasMinHint() ? setting.uintValue.minHint : null,
          max: setting.uintValue.hasMax() ? setting.uintValue.max : null,
          maxHint: setting.uintValue.hasMaxHint() ? setting.uintValue.maxHint : null,
          onUpdate: (v) {
            var updated = setting.deepCopy();
            updated.uintValue.value = v.toInt();
            onUpdate(updated);
          },
        );
      }
      if (setting.hasBoolValue()) {
        child = BooleanField(
            label: label,
            value: setting.boolValue.value,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.boolValue.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasSelectValue()) {
        child = EnumField(
            disabled: setting.disabled,
            label: label,
            initialValue: setting.selectValue.value,
            items: setting.selectValue.variants.map(mapVariant).toList(),
            onUpdate: (String v) {
              var updated = setting.deepCopy();
              updated.selectValue.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasEnumValue()) {
        child = EnumField(
            disabled: setting.disabled,
            label: label,
            initialValue: setting.enumValue.value,
            items: setting.enumValue.variants
                .map((variant) => SelectOption(value: variant.value, label: variant.label))
                .toList(),
            onUpdate: (int v) {
              var updated = setting.deepCopy();
              updated.enumValue.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasIdValue()) {
        child = EnumField(
            disabled: setting.disabled,
            label: label,
            initialValue: setting.idValue.value,
            items: setting.idValue.variants
                .map((variant) => SelectOption(value: variant.value, label: variant.label))
                .toList(),
            onUpdate: (int v) {
              var updated = setting.deepCopy();
              updated.idValue.value = v;
              onUpdate(updated);
            });
      }
      if (setting.hasSplineValue()) {
        child = SplineField(
            value: setting.splineValue,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.splineValue = v;
              onUpdate(updated);
            });
      }
      if (setting.hasMediaValue()) {
        child = MediaField(
            value: setting.mediaValue,
            label: label,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.mediaValue.value = v.value;
              onUpdate(updated);
            });
      }
      if (setting.hasStepSequencerValue()) {
        child = StepSequencerField(
            value: setting.stepSequencerValue,
            onUpdate: (v) {
              var updated = setting.deepCopy();
              updated.stepSequencerValue = v;
              onUpdate(updated);
            });
      }
      if (setting.hasButtonValue()) {
        child = Field(
            label: "",
            child: MizerButton(
                child: Text(setting.label), onClick: () => onUpdate(setting), active: true));
      }

      return MouseRegion(
        onEnter: (event) => onHover(setting),
        onExit: (event) => onHover(null),
        child: child,
      );
    });
  }
}

SelectItem<String> mapVariant(NodeSetting_SelectVariant variant) {
  if (variant.hasGroup()) {
    return SelectGroup<String>(variant.group.label,
        variant.group.items.map((v) => mapVariant(v)).toList());
  }
  return SelectOption<String>(value: variant.item.value, label: variant.item.label);
}
