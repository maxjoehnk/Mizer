import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../fields/enum_field.dart';
import '../fields/number_field.dart';
import '../property_group.dart';

class ColorConstantProperties extends StatefulWidget {
  final ColorConstantNodeConfig config;
  final Function(ColorConstantNodeConfig) onUpdate;

  ColorConstantProperties(this.config, {required this.onUpdate});

  @override
  _ColorConstantPropertiesState createState() => _ColorConstantPropertiesState(config);
}

class _ColorConstantPropertiesState extends State<ColorConstantProperties> {
  ColorConstantNodeConfig state;

  _ColorConstantPropertiesState(this.state);

  @override
  void didUpdateWidget(ColorConstantProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Color Constant", children: [
      EnumField(
        label: "Mode",
        initialValue: widget.config.hasRgb(),
        items: [
          SelectOption(
            label: "RGB",
            value: true,
          ),
          SelectOption(
            label: "HSV",
            value: false,
          ),
        ],
        onUpdate: _updateMode,
      ),
      if (state.hasRgb()) ..._rgbBinding(),
      if (state.hasHsv()) ..._hsvBinding(),
    ]);
  }

  List<Widget> _rgbBinding() {
    return [
      NumberField(
        label: "Red",
        value: this.widget.config.rgb.red,
        onUpdate: _updateRed,
        min: 0,
        max: 1,
        step: 0.1,
        fractions: true,
      ),
      NumberField(
        label: "Green",
        value: this.widget.config.rgb.green,
        onUpdate: _updateGreen,
        min: 0,
        max: 1,
        step: 0.1,
        fractions: true,
      ),
      NumberField(
        label: "Blue",
        value: this.widget.config.rgb.blue,
        onUpdate: _updateBlue,
        min: 0,
        max: 1,
        step: 0.1,
        fractions: true,
      ),
    ];
  }

  List<Widget> _hsvBinding() {
    return [
      NumberField(
        label: "Hue",
        value: this.widget.config.hsv.hue,
        onUpdate: _updateHue,
        min: 0,
        max: 1,
        step: 0.1,
        fractions: true,
      ),
      NumberField(
        label: "Saturation",
        value: this.widget.config.hsv.saturation,
        onUpdate: _updateSaturation,
        min: 0,
        max: 1,
        fractions: true,
      ),
      NumberField(
        label: "Value",
        value: this.widget.config.hsv.value,
        onUpdate: _updateValue,
        min: 0,
        max: 1,
        fractions: true,
      ),
    ];
  }

  void _updateMode(bool isRgb) {
    log("_updateMode $isRgb", name: "ColorConstantProperties");
    setState(() {
      if (isRgb) {
        state.rgb = ColorConstantNodeConfig_RgbColor();
        state.clearHsv();
      } else {
        state.clearRgb();
        state.hsv = ColorConstantNodeConfig_HsvColor();
      }
      widget.onUpdate(state);
    });
  }

  void _updateRed(num red) {
    log("_updateRed $red", name: "ColorConstantProperties");
    double value = red.toDouble();
    setState(() {
      state.rgb.red = value;
      widget.onUpdate(state);
    });
  }

  void _updateGreen(num green) {
    log("_updateGreen $green", name: "ColorConstantProperties");
    double value = green.toDouble();
    setState(() {
      state.rgb.green = value;
      widget.onUpdate(state);
    });
  }

  void _updateBlue(num blue) {
    log("_updateBlue $blue", name: "ColorConstantProperties");
    double value = blue.toDouble();
    setState(() {
      state.rgb.blue = value;
      widget.onUpdate(state);
    });
  }

  void _updateHue(num hue) {
    log("_updateHue $hue", name: "ColorConstantProperties");
    double value = hue.toDouble();
    setState(() {
      state.hsv.hue = value;
      widget.onUpdate(state);
    });
  }

  void _updateSaturation(num saturation) {
    log("_updateSaturation $saturation", name: "ColorConstantProperties");
    double value = saturation.toDouble();
    setState(() {
      state.hsv.saturation = value;
      widget.onUpdate(state);
    });
  }

  void _updateValue(num value) {
    log("_updateValue $value", name: "ColorConstantProperties");
    setState(() {
      state.hsv.value = value.toDouble();
      widget.onUpdate(state);
    });
  }
}
