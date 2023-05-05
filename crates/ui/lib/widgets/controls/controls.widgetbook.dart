import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'button.dart';

WidgetbookFolder controlWidgets() {
  return WidgetbookFolder(name: "Controls", widgets: [
    _buttonWidget
  ]);
}

WidgetbookComponent _buttonWidget = WidgetbookComponent(name: '$MizerButton', useCases: [
  WidgetbookUseCase(
      name: 'Default',
      builder: (context) => MizerButton(child: Text("Text")))
]);
