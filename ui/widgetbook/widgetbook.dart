import 'package:flutter/material.dart';
import 'package:mizer/app.dart';
import 'package:mizer/widgets/controls/controls.widgetbook.dart';
import 'package:mizer/widgets/popup/popup.widgetbook.dart';
import 'package:widgetbook/widgetbook.dart';

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      categories: [
        WidgetbookCategory(name: "Widgets", folders: [
          controlWidgets(),
          popupWidgets(),
        ])
      ],
      appInfo: AppInfo(name: "Mizer"),
      devices: [
        Apple.macBook13Inch,
        Device.desktop(
            name: "Desktop",
            resolution:
                Resolution(nativeSize: DeviceSize(width: 1920, height: 1080), scaleFactor: 1))
      ],
      defaultTheme: ThemeMode.dark,
      darkTheme: MizerApp.getTheme(),
    );
  }
}
