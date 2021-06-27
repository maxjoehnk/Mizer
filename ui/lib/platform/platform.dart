export 'contracts/menu.dart';
export 'contracts/menu_bar.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'contracts/menu.dart';

abstract class Platform {
  showContextMenu({ BuildContext context, Menu menu, Offset position });

  static Platform of(BuildContext context) {
    return context.read<Platform>();
  }
}

extension PlatformExt on BuildContext {
  Platform get platform {
    return Platform.of(this);
  }
}
