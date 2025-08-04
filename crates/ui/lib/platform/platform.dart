export 'contracts/menu.dart';
export 'contracts/menu_bar.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:mizer/platform/contracts/menu.dart';

abstract class Platform {
  showContextMenu({required BuildContext context, required Menu menu, required Offset position});

  static Platform of(BuildContext context) {
    return context.read<Platform>();
  }
}

extension PlatformExt on BuildContext {
  Platform get platform {
    return Platform.of(this);
  }
}
