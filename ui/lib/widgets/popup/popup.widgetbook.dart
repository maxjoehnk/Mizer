import 'package:widgetbook/widgetbook.dart';
import 'popup_select.dart';
import 'popup_time_input.dart';
import 'popup_value_input.dart';

WidgetbookFolder popupWidgets() {
  return WidgetbookFolder(name: "Popup", widgets: [
    WidgetbookComponent(name: '$PopupSelect', useCases: [
      WidgetbookUseCase(
          name: 'Default',
          builder: (context) => PopupSelect(title: "Select", items: [
            SelectItem(title: "Item 1", onTap: () {}),
            SelectItem(title: "Item 2", onTap: () {}),
            SelectItem(title: "Item 3", onTap: () {}),
          ]))
    ]),
    WidgetbookComponent(name: '$PopupValueInput', useCases: [
      WidgetbookUseCase(
          name: 'Default',
          builder: (context) => PopupValueInput()
      )
    ]),
    WidgetbookComponent(name: '$PopupTimeInput', useCases: [
      WidgetbookUseCase(
          name: 'Default',
          builder: (context) => PopupTimeInput()
      )
    ]),
  ]);
}
